module Mads

using Optim
#import YAML
using PyCall
@pyimport yaml
import MCMC

function asinetransform(params::Vector, lowerbounds::Vector, upperbounds::Vector)
	sineparams = asin((params - lowerbounds) ./ (upperbounds - lowerbounds) * 2 - 1)
	return sineparams
end

function sinetransform(sineparams::Vector, lowerbounds::Vector, upperbounds::Vector)
	params = lowerbounds + (upperbounds - lowerbounds) .* ((1 + sin(sineparams)) * .5)
	return params
end

function sinetransformfunction(f::Function, lowerbounds::Vector, upperbounds::Vector)
	function sinetransformedf(sineparams::Vector)
		params = sinetransform(sineparams, lowerbounds, upperbounds)
		return f(params)
	end
	return sinetransformedf
end

function sinetransformgradient(g::Function, lowerbounds::Vector, upperbounds::Vector)
	function sinetransformedg(sineparams::Vector)
		params = sinetransform(sineparams, lowerbounds, upperbounds)
		straightgrad = g(params)
		f(x) = cos(x) / 2
		transformgrad = (upperbounds - lowerbounds) .* f(sineparams)
		return straightgrad .* transformgrad
	end
	return sinetransformedg
end

function loadyamlfile(filename::String)
	f = open(filename)
	#madsdict = YAML.load(f)
	yamldata = yaml.load(f)#for now we use the python library because the julia library crashes
	close(f)
	return yamldata
end

function dumpyamlfile(filename::String, yamldata)
	f = open(filename, "w")
	write(f, yaml.dump(yamldata))
	close(f)
end

function loadmadsfile(filename::String)
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
			for key in keys(tmpdict)#this should only iterate once
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
			for key in keys(insdict)#this should only iterate once
				instructions[i] = insdict[key]
			end
			i += 1
		end
		madsdict["Instructions"] = instructions
	end

	return madsdict
end

function readyamlpredictions(filename::String)
	return loadyamlfile(filename)
end

function makemadscommandfunction(madsdata)
	if haskey(madsdata, "ForwardModel")
		madscommandfunction = evalfile(madsdata["ForwardModel"])
	elseif haskey(madsdata, "Command")
		function madscommandfunction(parameters::Dict)
			newdirname = "../temp_$(replace(replace(strftime(time()), ":", ""), " ", "_"))_$(myid())_$(rand(Int64))"
			run(`mkdir $newdirname`)
			currentdir = pwd()
			run(`bash -c "ln -s $(currentdir)/* $newdirname"`)
			for filename in vcat(madsdata["YAMLPredictions"], madsdata["YAMLParameters"])
				run(`rm -f $(newdirname)/$filename`)
			end
			dumpyamlfile("$(newdirname)/$(madsdata["YAMLParameters"])", parameters)
			run(`bash -c "cd $newdirname; $(madsdata["Command"])"`)
			results = Dict()
			for filename in madsdata["YAMLPredictions"]
				results = merge(results, loadyamlfile("$(newdirname)/$filename"))
			end
			return results
		end
	else
		error("Can't make a madscommand function without an Include or a Command entry in the mads file")
	end
	return madscommandfunction
end

function makemadscommandgradient(madsdata)
	f = makemadscommandfunction(madsdata)
	function madscommandgradient(parameters::Dict)
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
		initparams[i] = madsdata["Parameters"][paramkeys[i]]["init"]
		lowerbounds[i] = madsdata["Parameters"][paramkeys[i]]["min"]
		upperbounds[i] = madsdata["Parameters"][paramkeys[i]]["max"]
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

function makearrayloglikelihood(madsdata, loglikelihood)
	f = makemadscommandfunction(madsdata)
	paramkeys = getparamkeys(madsdata)
	return arrayparameters::Vector -> loglikelihood(Dict(paramkeys, arrayparameters), f(Dict(paramkeys, arrayparameters)), madsdata["Observations"])
end

function bayessampling(madsdata; nsteps=int(1e2), burnin=int(1e3))#madsloglikelihood should be a function that takes a dict of MADS parameters, a dict of model predictions, and a dict of MADS observations
	madsloglikelihood = evalfile(madsdata["LogLikelihood"])
	arrayloglikelihood = makearrayloglikelihood(madsdata, madsloglikelihood)
	paramkeys = getparamkeys(madsdata)
	initvals = Array(Float64, length(paramkeys))
	for i = 1:length(paramkeys)
		initvals[i] = madsdata["Parameters"][paramkeys[i]]["init"]
	end
	mcmcmodel = MCMC.model(arrayloglikelihood, init=initvals)
	sampler = MCMC.RAM(1e-0, 0.3)
	smc = MCMC.SerialMC(nsteps=nsteps + burnin, burnin=burnin)
	mcmcchain = MCMC.run(mcmcmodel, sampler, smc)
	return mcmcchain
end

function writeviatemplate(parameters, templatefilename, outputfilename)
	tplfile = open(templatefilename)
	line = readline(tplfile)#read the line that says "template $separator\n"
	separator = line[end-1]
	lines = readlines(tplfile)
	close(tplfile)
	outfile = open(outputfilename, "w")
	for line in lines
		splitline = split(line, separator)
		@assert rem(length(splitline), 2) == 1#length(splitlines) should always be an odd number -- if it isn't the assumptions in the code below fail
		for i = 1:int((length(splitline)-1)/2)
			write(outfile, splitline[2 * i - 1])
			write(outfile, string(parameters[splitline[2 * i]]["init"]))
		end
		write(outfile, splitline[end])
	end
	close(outfile)
end

function writetemplates(madsdata)
	for template in madsdata["Templates"]
		writeviatemplate(madsdata["Parameters"], template["tpl"], template["write"])
	end
end

end
