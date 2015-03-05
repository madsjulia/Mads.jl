module Mads

include("MadsIO.jl")
include("MadsTestFunctions.jl")
include("MadsMisc.jl")
include("MadsLM.jl")
using Optim
using Lora
using Distributions
using Logging
include("MadsLog.jl") # messages higher than specified level are printed
# Logging.configure(level=OFF) # OFF
# Logging.configure(level=CRITICAL) # ONLY CRITICAL
Logging.configure(level=DEBUG)
if VERSION < v"0.4.0-dev"
	using Docile # default for v > 0.4
end
# @document
@docstrings

@doc "Save calibration results" ->
function savecalibrationresults(madsdata, results)
#TODO map estimated parameters on a new madsdata structure
#TODO save madsdata in yaml file using dumpyamlmadsfile
#TODO save residuals, predictions, observations (yaml?)
end

@doc "Calibrate " ->
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
	results = Mads.levenberg_marquardt(f_lm, g_lm, initparams, show_trace=false)
	return results
end

@doc "Bayes Sampling " ->
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

@doc " Saltelli (brute force)" ->
function saltellibrute(madsdata; numsamples=int(1e6), numoneparamsamples=int(1e2), nummanyparamsamples=int(1e4))
	# convert the distribution strings into actual distributions
	paramkeys = getparamkeys(madsdata)
	# find the mean and variance
	f = makemadscommandfunction(madsdata)
	distributions = getdistributions(madsdata)
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
	# compute the first order sensitivities
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
		end
	end
	# compute the total effect
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
		end
	end
	return mean, variance, fos, te
end

@doc "Saltelli " ->
function saltelli(madsdata; N=int(1e6))
	paramkeys = getparamkeys(madsdata)
	obskeys = getobskeys(madsdata)
	distributions = getdistributions(madsdata)
	f = makemadscommandfunction(madsdata)
	A = Array(Float64, (N, length(paramkeys)))
	B = Array(Float64, (N, length(paramkeys)))
	Ci = Dict{String, Float64}()
	# yA = Array(Float64, (N, length(obskeys)))
	# yB = Array(Float64, (N, length(obskeys)))
	yC = Array(Float64, (N, length(obskeys)))
	fos = Dict{String, Dict{String, Float64}}() # f irst order sensitivities
	te = Dict{String, Dict{String, Float64}}()	# total effect
	for i = 1:length(obskeys)
		fos[obskeys[i]] = Dict{String, Float64}()
		te[obskeys[i]] = Dict{String, Float64}()
	end
	for i = 1:N
		for j = 1:length(paramkeys)
			A[i, j] = Distributions.rand(distributions[paramkeys[j]])
			B[i, j] = Distributions.rand(distributions[paramkeys[j]])
		end
	end
	yA = Array(Float64, length(obskeys)) # there shoudl be better way
	yB = Array(Float64, length(obskeys)) # we need to define vector length
	println(yA);
	# println(pmap(f,{Dict{String, Float64}(paramkeys, A[:, :])}))
	yA = vcat(yA, pmap(f,{Dict{String, Float64}(paramkeys, A[:, :])}))
	yB = vcat(yB, pmap(f,{Dict{String, Float64}(paramkeys, B[:, :])}))
	madswarn("""$(yA)""");
	#yA[i, :] = map(k->result[k], obskeys)
	#yB[i, :] = map(k->result[k], obskeys)
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

names = ["saltelli", "saltellibrute"]

for mi = 1:length(names)
	q = quote
		function $(symbol(string(names[mi], "parallel")))(madsdata, numsaltellis; N=int(1e5))
			results = pmap(i->$(symbol(names[mi]))(madsdata; N=N), 1:numsaltellis)
			fosall, teall = results[1]
			for i = 2:numsaltellis
				fos, te = results[i]
				for obskey in keys(fos)
					for paramkey in keys(fos[obskey])
						fosall[obskey][paramkey] += fos[obskey][paramkey]
						teall[obskey][paramkey] += te[obskey][paramkey]
					end
				end
			end
			for obskey in keys(fosall)
				for paramkey in keys(fosall[obskey])
					fosall[obskey][paramkey] /= numsaltellis
					teall[obskey][paramkey] /= numsaltellis
				end
			end
			return fosall, teall
		end
	end
	eval(q)
end

function printsaltelli(madsdata, fos, te)
	println("First order sensitivity")
	print("\t")
	obskeys = getobskeys(madsdata)
	paramkeys = getparamkeys(madsdata)
	for paramkey in paramkeys
		print("\t$(paramkey)")
	end
	println()
	for obskey in obskeys
		print(obskey)
		for paramkey in paramkeys
			print("\t$(fos[obskey][paramkey])")
		end
		println()
	end
	println("\nTotal effect")
	print("\t")
	for paramkey in paramkeys
		print("\t$(paramkey)")
	end
	println()
	for obskey in obskeys
		print(obskey)
		for paramkey in paramkeys
			print("\t$(te[obskey][paramkey])")
		end
		println()
	end
end

end # Module end
