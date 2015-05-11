module Mads

using Optim
using Lora
using Distributions
using Logging
if VERSION < v"0.4.0-dev"
	using Docile # default for v > 0.4
end
import NLopt

include("MadsIO.jl")
include("MadsTestFunctions.jl")
include("MadsMisc.jl")
include("MadsSA.jl")
include("MadsMC.jl")
include("MadsLM.jl")
include("MadsLog.jl") # messages higher than specified level are printed
# Logging.configure(level=OFF) # OFF
# Logging.configure(level=CRITICAL) # ONLY CRITICAL
Logging.configure(level=DEBUG)
madsverbositylevel = 1
madsdebuglevel = 1

# @document
@docstrings

@doc "TODO Save calibration results" ->
function savecalibrationresults(madsdata, results)
	#TODO map estimated parameters on a new madsdata structure
	#TODO save madsdata in yaml file using dumpyamlmadsfile
	#TODO save residuals, predictions, observations (yaml?)
end

@doc "Calibrate " ->
function calibrate(madsdata; maxIter=100)
	f = makemadscommandfunction(madsdata)
	g = makemadscommandgradient(madsdata, f)
	#f, g = makemadscommandfunctionandgradient(madsdata)
	obskeys = getobskeys(madsdata)
	paramkeys = getparamkeys(madsdata)
	initparams = getparamsinit(madsdata)
	lowerbounds = getparamsmin(madsdata)
	upperbounds = getparamsmax(madsdata)
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
	f_lm_sin = sinetransformfunction(f_lm, lowerbounds, upperbounds)
	g_lm_sin = sinetransformgradient(g_lm, lowerbounds, upperbounds)
	results = Mads.levenberg_marquardt(f_lm_sin, g_lm_sin, asinetransform(initparams, lowerbounds, upperbounds), show_trace=false, maxIter=maxIter)
	minimum = sinetransform(results.minimum, lowerbounds, upperbounds)
	return minimum, results
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
