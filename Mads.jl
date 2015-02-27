module Mads

using Optim
#import YAML
using PyCall
@pyimport yaml
import Lora
using Distributions

function asinetransform(params::Vector, lowerbounds::Vector, upperbounds::Vector) # asine transformation
	sineparams = asin((params - lowerbounds) ./ (upperbounds - lowerbounds) * 2 - 1) # transformed parameters (sine parameter space)
	return sineparams
end

function sinetransform(sineparams::Vector, lowerbounds::Vector, upperbounds::Vector) # sine transformation
	params = lowerbounds + (upperbounds - lowerbounds) .* ((1 + sin(sineparams)) * .5) # untransformed parameters (regular parameter space)
	return params
end

function sinetransformfunction(f::Function, lowerbounds::Vector, upperbounds::Vector) # sine transformation a function
	function sinetransformedf(sineparams::Vector)
		params = sinetransform(sineparams, lowerbounds, upperbounds)
		return f(params)
	end
	return sinetransformedf
end

function sinetransformgradient(g::Function, lowerbounds::Vector, upperbounds::Vector) # sine transformation a gradient function
	function sinetransformedg(sineparams::Vector)
		params = sinetransform(sineparams, lowerbounds, upperbounds)
		straightgrad = g(params)
		f(x) = cos(x) / 2
		transformgrad = (upperbounds - lowerbounds) .* f(sineparams)
		return straightgrad .* transformgrad
	end
	return sinetransformedg
end

function loadyamlfile(filename::String) # load YAML file
	f = open(filename)
	#madsdict = YAML.load(f) # crashes
	yamldata = yaml.load(f) # for now we use the python library because the julia library crashes
	close(f)
	return yamldata
end

function dumpyamlfile(filename::String, yamldata) # dump YAML file
	f = open(filename, "w")
	write(f, yaml.dump(yamldata))
	close(f)
end

function loadyamlmadsfile(filename::String) # load MADS input file in YAML format
	madsdict = loadyamlfile(filename)
	parameters = Dict()
	for paramdict in madsdict["Parameters"]
		for key in keys(paramdict)
			parameters[key] = paramdict[key]
		end
	end
	madsdict["Parameters"] = parameters
	observations = Dict()
	for obsdict in madsdict["Observations"]
		for key in keys(obsdict)
			observations[key] = obsdict[key]
		end
	end
	madsdict["Observations"] = observations
	if haskey(madsdict, "Templates")
		templates = Array(Dict, length(madsdict["Templates"]))
		i = 1
		for tmpdict in madsdict["Templates"]
			for key in keys(tmpdict) # this should only iterate once
				templates[i] = tmpdict[key]
			end
			i += 1
		end
		madsdict["Templates"] = templates
	end
	if haskey(madsdict, "Instructions")
		instructions = Array(Dict, length(madsdict["Instructions"]))
		i = 1
		for insdict in madsdict["Instructions"]
			for key in keys(insdict) # this should only iterate once
				instructions[i] = insdict[key]
			end
			i += 1
		end
		madsdict["Instructions"] = instructions
	end
	return madsdict
end

function readyamlpredictions(filename::String) # read YAML predictions
	return loadyamlfile(filename)
end

function makemadscommandfunction(madsdata) # make MADS command function
	if haskey(madsdata, "Model")
		madscommandfunction = evalfile(madsdata["Model"])
	elseif haskey(madsdata, "Command")
		function madscommandfunction(parameters::Dict) # MADS command function
			newdirname = "../$(split(pwd(),"/")[end])_$(strftime("%Y%m%d%H%M%S",time()))_$(rand(Uint32))_$(myid())"
			run(`mkdir $newdirname`)
			currentdir = pwd()
			run(`bash -c "ln -s $(currentdir)/* $newdirname"`) # link all the files in the current directory
			for filename in vcat(madsdata["YAMLPredictions"], madsdata["YAMLParameters"])
				run(`rm -f $(newdirname)/$filename`) # delete the parameter file links
			end
			dumpyamlfile("$(newdirname)/$(madsdata["YAMLParameters"])", parameters) # create parameter files
			run(`bash -c "cd $newdirname; $(madsdata["Command"])"`)
			results = Dict()
			for filename in madsdata["YAMLPredictions"]
				results = merge(results, loadyamlfile("$(newdirname)/$filename"))
			end
      run(`rm -fR $newdirname`)
			return results
		end
	else
		error("Cannot create a madscommand function without a Model or a Command entry in the mads input file")
	end
	return madscommandfunction
end

function makemadscommandgradient(madsdata) # make MADS command gradient function
	f = makemadscommandfunction(madsdata)
	function madscommandgradient(parameters::Dict) # MADS command gradient function
		xph = Dict()
		h = 1e-6
		xph["noparametersvaried"] = parameters
		i = 2
		for paramkey in keys(parameters)
			xph[paramkey] = copy(parameters)
			xph[paramkey][paramkey] += h
			i += 1
		end
		fevals = pmap(keyval->[keyval[1], f(keyval[2])], xph)
		fevalsdict = Dict()
		for feval in fevals
			fevalsdict[feval[1]] = feval[2]
		end
		gradient = Dict()
		resultkeys = keys(fevals[1][2])
		for resultkey in resultkeys
			gradient[resultkey] = Dict()
			for paramkey in keys(parameters)
				gradient[resultkey][paramkey] = (fevalsdict[paramkey][resultkey] - fevalsdict["noparametersvaried"][resultkey]) / h
			end
		end
		return gradient
	end
	return madscommandgradient
end

function getparamkeys(madsdata)
	return [k for k in keys(madsdata["Parameters"])]
end

function getobskeys(madsdata)
	return [k for k in keys(madsdata["Observations"])]
end

function calibrate(madsdata)
	f = makemadscommandfunction(madsdata)
	g = makemadscommandgradient(madsdata)
	obskeys = getobskeys(madsdata)
	paramkeys = getparamkeys(madsdata)
	initparams = Array(Float64, length(paramkeys))
	lowerbounds = Array(Float64, length(paramkeys))
	upperbounds = Array(Float64, length(paramkeys))
	for i in 1:length(paramkeys)
		initparams[i] = madsdata["Parameters"][paramkeys[i]]["init"] # initial parameter values
		lowerbounds[i] = madsdata["Parameters"][paramkeys[i]]["min"] # parameter bounds: minimum
		upperbounds[i] = madsdata["Parameters"][paramkeys[i]]["max"] # parameter bounds: maximum
	end
	function f_lm(arrayparameters::Vector)
		parameters = Dict(paramkeys, arrayparameters)
		resultdict = f(parameters)
		squaredresiduals = Array(Float64, length(madsdata["Observations"]))
		i = 1
		for obskey in obskeys
			diff = resultdict[obskey] - madsdata["Observations"][obskey]["target"]
			squaredresiduals[i] = diff * sqrt(madsdata["Observations"][obskey]["weight"])
			i += 1
		end
		return squaredresiduals
	end
	function g_lm(arrayparameters::Vector)
		parameters = Dict(paramkeys, arrayparameters)
		gradientdict = g(parameters)
		jacobian = Array(Float64, (length(obskeys), length(paramkeys)))
		for i in 1:length(obskeys)
			for j in 1:length(paramkeys)
				jacobian[i, j] = gradientdict[obskeys[i]][paramkeys[j]]
			end
		end
		return jacobian
	end
	results = Optim.levenberg_marquardt(f_lm, g_lm, initparams, show_trace=true)
	return results
end

function makearrayloglikelihood(madsdata, loglikelihood) # make log likelihood array
	f = makemadscommandfunction(madsdata)
	paramkeys = getparamkeys(madsdata)
	return arrayparameters::Vector -> loglikelihood(Dict(paramkeys, arrayparameters), f(Dict(paramkeys, arrayparameters)), madsdata["Observations"])
end

function bayessampling(madsdata; nsteps=int(1e2), burnin=int(1e3))
	madsloglikelihood = evalfile(madsdata["LogLikelihood"]) # madsloglikelihood should be a function that takes a dict of MADS parameters, a dict of model predictions, and a dict of MADS observations
	arrayloglikelihood = makearrayloglikelihood(madsdata, madsloglikelihood)
	paramkeys = getparamkeys(madsdata)
	initvals = Array(Float64, length(paramkeys))
	for i = 1:length(paramkeys)
		initvals[i] = madsdata["Parameters"][paramkeys[i]]["init"]
	end
	mcmcmodel = Lora.model(arrayloglikelihood, init=initvals)
	sampler = Lora.RAM(1e-0, 0.3)
	smc = Lora.SerialMC(nsteps=nsteps + burnin, burnin=burnin)
	mcmcchain = Lora.run(mcmcmodel, sampler, smc)
	return mcmcchain
end

function writeviatemplate(parameters, templatefilename, outputfilename)
	tplfile = open(templatefilename) # open template file
	line = readline(tplfile) # read the first line that says "template $separator\n"
	separator = line[end-1] # template separator
	lines = readlines(tplfile)
	close(tplfile)
	outfile = open(outputfilename, "w")
	for line in lines
		splitline = split(line, separator) # two separators are needed for each parameter
		@assert rem(length(splitline), 2) == 1 # length(splitlines) should always be an odd number -- if it isn't the assumptions in the code below fail
		for i = 1:int((length(splitline)-1)/2)
			write(outfile, splitline[2 * i - 1]) # write the text before the parameter separator
			write(outfile, string(parameters[splitline[2 * i]]["init"])) # replace the initial value for the parameter; splitline[2 * i] in this case is parameter ID
		end
		write(outfile, splitline[end]) # write the rest of the line after the last separator
	end
	close(outfile)
end

function writetemplates(madsdata)
	for template in madsdata["Templates"]
		writeviatemplate(madsdata["Parameters"], template["tpl"], template["write"])
	end
end

function getdistributions(madsdata)
	paramkeys = getparamkeys(madsdata)
	distributions = Dict()
	for i in 1:length(paramkeys)
		distributions[paramkeys[i]] = eval(parse(madsdata["Parameters"][paramkeys[i]]["dist"]))
	end
	return distributions
end

function saltellibrute(madsdata; numsamples=int(1e6), numoneparamsamples=int(1e2), nummanyparamsamples=int(1e4))
	#convert the distribution strings into actual distributions
	paramkeys = getparamkeys(madsdata)
	distributions = getdistributions(madsdata)
	#find the mean and variance
	f = makemadscommandfunction(madsdata)
	results = Array(Dict, numsamples)
	paramdict = Dict()
	for i = 1:numsamples
		for j in 1:length(paramkeys)
			paramdict[paramkeys[j]] = Distributions.rand(distributions[paramkeys[j]])
		end
		results[i] = f(paramdict)
	end
	obskeys = getobskeys(madsdata)
	sum = Dict()
	for i = 1:length(obskeys)
		sum[obskeys[i]] = 0.
	end
	for j = 1:numsamples
		for i = 1:length(obskeys)
			sum[obskeys[i]] += results[j][obskeys[i]]
		end
	end
	mean = Dict()
	for i = 1:length(obskeys)
		mean[obskeys[i]] = sum[obskeys[i]] / numsamples
	end
	for i = 1:length(paramkeys)
		sum[paramkeys[i]] = 0.
	end
	for j = 1:numsamples
		for i = 1:length(obskeys)
			sum[obskeys[i]] += (results[j][obskeys[i]] - mean[obskeys[i]]) ^ 2
		end
	end
	variance = Dict()
	for i = 1:length(obskeys)
		variance[obskeys[i]] = sum[obskeys[i]] / (numsamples - 1)
	end
	#compute the first order sensitivities
	fos = Dict()
	for k = 1:length(obskeys)
		fos[obskeys[k]] = Dict()
	end
	for i = 1:length(paramkeys)
		cond_means = Array(Dict, numoneparamsamples)
		for j = 1:numoneparamsamples
			cond_means[j] = Dict()
			for k = 1:length(obskeys)
				cond_means[j][obskeys[k]] = 0.
			end
			paramdict[paramkeys[i]] = Distributions.rand(distributions[paramkeys[i]])
			for k = 1:nummanyparamsamples
				for m = 1:length(paramkeys)
					if m != i
						paramdict[paramkeys[m]] = Distributions.rand(distributions[paramkeys[m]])
					end
				end
				results = f(paramdict)
				for k = 1:length(obskeys)
					cond_means[j][obskeys[k]] += results[obskeys[k]]
				end
			end
			for k = 1:length(obskeys)
				cond_means[j][obskeys[k]] /= nummanyparamsamples
			end
		end
		v = Array(Float64, numoneparamsamples)
		for k = 1:length(obskeys)
			for m = 1:numoneparamsamples
				v[m] = cond_means[m][obskeys[k]]
			end
			fos[obskeys[k]][paramkeys[i]] = std(v) ^ 2 / variance[obskeys[k]]
			println(fos)
		end
	end
	#compute the total effect
	te = Dict()
	for k = 1:length(obskeys)
		te[obskeys[k]] = Dict()
	end
	for i = 1:length(paramkeys)
		cond_vars = Array(Dict, nummanyparamsamples)
		cond_means = Array(Dict, nummanyparamsamples)
		for j = 1:nummanyparamsamples
			cond_vars[j] = Dict()
			cond_means[j] = Dict()
			for m = 1:length(obskeys)
				cond_means[j][obskeys[m]] = 0.
				cond_vars[j][obskeys[m]] = 0.
			end
			for m = 1:length(paramkeys)
				if m != i
					paramdict[paramkeys[m]] = Distributions.rand(distributions[paramkeys[m]])
				end
			end
			results = Array(Dict, numoneparamsamples)
			for k = 1:numoneparamsamples
				paramdict[paramkeys[i]] = Distributions.rand(distributions[paramkeys[i]])
				results[k] = f(paramdict)
				for m = 1:length(obskeys)
					cond_means[j][obskeys[m]] += results[k][obskeys[m]]
				end
			end
			for m = 1:length(obskeys)
				cond_means[j][obskeys[m]] /= numoneparamsamples
			end
			for k = 1:numoneparamsamples
				for m = 1:length(obskeys)
					cond_vars[j][obskeys[m]] += (results[k][obskeys[m]] - cond_means[j][obskeys[m]]) ^ 2
				end
			end
			for m = 1:length(obskeys)
				cond_vars[j][obskeys[m]] /= numoneparamsamples - 1
			end
		end
		for j = 1:length(obskeys)
			runningsum = 0.
			for m = 1:nummanyparamsamples
				runningsum += cond_vars[m][obskeys[j]]
			end
			te[obskeys[j]][paramkeys[i]] = runningsum / nummanyparamsamples / variance[obskeys[j]]
			println(te)
		end
	end
	return mean, variance, fos, te
end

function saltelli(madsdata; N=int(1e6))
	paramkeys = getparamkeys(madsdata)
	obskeys = getobskeys(madsdata)
	distributions = getdistributions(madsdata)
	f = makemadscommandfunction(madsdata)
	A = Array(Float64, (N, length(paramkeys)))
	B = Array(Float64, (N, length(paramkeys)))
	Ci = Dict{String, Float64}()
	yA = Array(Float64, (N, length(obskeys)))
	yB = Array(Float64, (N, length(obskeys)))
	yC = Array(Float64, (N, length(obskeys)))
	fos = Dict{String, Dict{String, Float64}}()#first order sensitivities
	te = Dict{String, Dict{String, Float64}}()#total effect
	for i = 1:length(obskeys)
		fos[obskeys[i]] = Dict{String, Float64}()
		te[obskeys[i]] = Dict{String, Float64}()
	end
	for i = 1:N
		for j = 1:length(paramkeys)
			A[i, j] = Distributions.rand(distributions[paramkeys[j]])
			B[i, j] = Distributions.rand(distributions[paramkeys[j]])
		end
		result = f(Dict{String, Float64}(paramkeys, A[i, :]))
		yA[i, :] = map(k->result[k], obskeys)
		result = f(Dict{String, Float64}(paramkeys, B[i, :]))
		yB[i, :] = map(k->result[k], obskeys)
	end
	for i = 1:length(paramkeys)
		for j = 1:N
			for k = 1:length(paramkeys)
				if k != i
					Ci[paramkeys[k]] = B[j, k]
				else
					Ci[paramkeys[k]] = A[j, k]
				end
			end
			result = f(Ci)
			yC[j, :] = map(k->result[k], obskeys)
		end
		for j = 1:length(obskeys)
			f0 = .5 * (mean(yA[:, j]) + mean(yB[:, j]))
			variance = .5 * ((dot(yA[:, j], yA[:, j]) - f0 ^ 2) + (dot(yB[:, j], yB[:, j]) - f0 ^ 2))
			fos[obskeys[j]][paramkeys[i]] = (dot(yA[:, j], yC[:, j]) - f0 ^ 2) / variance
			te[obskeys[j]][paramkeys[i]] = 1 - (dot(yB[:, j], yC[:, j]) - f0 ^ 2) / variance
		end
	end
	return fos, te
end

end # Module end
