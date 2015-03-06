module Mads

using Optim
using Lora
using Distributions
using Logging

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

end # Module end
