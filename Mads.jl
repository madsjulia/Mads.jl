module Mads

using Optim
using Lora
using Distributions
using Logging
import NLopt

include("MadsIO.jl")
include("MadsTestFunctions.jl")
include("MadsMisc.jl")
include("MadsSA.jl")
include("MadsLM.jl")
include("MadsLog.jl") # messages higher than specified level are printed
# Logging.configure(level=OFF) # OFF
# Logging.configure(level=CRITICAL) # ONLY CRITICAL
Logging.configure(level=DEBUG)
madsinfolevel=0
madsdebuglevel=0
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
		residuals = Array(Float64, length(madsdata["Observations"]))
		i = 1
		for obskey in obskeys
			diff = resultdict[obskey] - madsdata["Observations"][obskey]["target"]
			residuals[i] = diff * sqrt(madsdata["Observations"][obskey]["weight"])
			i += 1
		end
		return residuals
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

@doc "Do a calibration using NLopt " -> # TODO switch to a mathprogbase approach
function calibratenlopt(madsdata; algorithm=:LD_LBFGS)
	const paramkeys = getparamkeys(madsdata)
	const obskeys = getobskeys(madsdata)
	parammins = Array(Float64, length(paramkeys))
	parammaxs = Array(Float64, length(paramkeys))
	paraminits = Array(Float64, length(paramkeys))
	for i = 1:length(paramkeys)
		parammins[i] = madsdata["Parameters"][paramkeys[i]]["min"]
		parammaxs[i] = madsdata["Parameters"][paramkeys[i]]["max"]
		paraminits[i] = madsdata["Parameters"][paramkeys[i]]["init"]
	end
	obs = Array(Float64, length(obskeys))
	weights = Array(Float64, length(obskeys))
	for i = 1:length(obskeys)
		obs[i] = madsdata["Observations"][obskeys[i]]["target"]
		weights[i] = madsdata["Observations"][obskeys[i]]["weight"]
	end
	fg = makemadscommandfunctionandgradient(madsdata)
	function fg_nlopt(arrayparameters::Vector, grad::Vector)
		parameters = Dict(paramkeys, arrayparameters)
		resultdict, gradientdict = fg(parameters)
		residuals = Array(Float64, length(madsdata["Observations"]))
		ssr = 0
		i = 1
		for obskey in obskeys
			residuals[i] = resultdict[obskey] - madsdata["Observations"][obskey]["target"]
			ssr += residuals[i] * residuals[i] * madsdata["Observations"][obskey]["weight"]
			i += 1
		end
		if length(grad) > 0
			i = 1
			for paramkey in paramkeys
				grad[i] = 0.
				j = 1
				for obskey in obskeys
					grad[i] += 2 * residuals[j] * gradientdict[obskey][paramkey]
					j += 1
				end
				i += 1
			end
		end
		return ssr
	end
	opt = NLopt.Opt(algorithm, length(paramkeys))
	NLopt.lower_bounds!(opt, parammins)
	NLopt.upper_bounds!(opt, parammaxs)
	NLopt.min_objective!(opt, fg_nlopt)
	NLopt.maxeval!(opt, int(1e3))
	minf, minx, ret = NLopt.optimize(opt, paraminits)
	return minf, minx, ret
end

end # Module end
