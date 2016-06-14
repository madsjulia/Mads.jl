import BIGUQ
import ProgressMeter
import DataFrames
import Optim

"""
Setup BIG-DT problem

Arguments:

- `madsdata` : MADS problem dictionary
- `choice` : dictionary of BIG-DT choices (scenarios)

Returns:

- `bigdtproblem` : BIG-DT problem type
"""
function makebigdt(madsdata::Associative, choice::Associative)
	return makebigdt!(deepcopy(madsdata), choice)
end

"""
Setup BIG-DT problem

Arguments:

- `madsdata` : MADS problem dictionary
- `choice` : dictionary of BIG-DT choices (scenarios)

Returns:

- `bigdtproblem` : BIG-DT problem type
"""
function makebigdt!(madsdata::Associative, choice::Associative)
	Mads.madsinfo("Decision parameters:")
	for paramname in keys(choice["Parameters"])
		if Mads.isopt(madsdata, paramname)
			Mads.madscritical("Decision parameter, $paramname, is also an adjustable (type = \"opt\") parameter.")
		end
		c = choice["Parameters"][paramname]
		madsdata["Parameters"][paramname]["init"] = c
		Mads.madsinfo("Decision parameter $paramname set to $c.")
	end
	makeloglikelihood = makemakearrayconditionalloglikelihood(madsdata)
	logprior = makearrayfunction(madsdata, makelogprior(madsdata))
	nominalparams = getparamsinit(madsdata)
	f = makemadscommandfunction(madsdata; calczeroweightobs=true, calcpredictions=true)
	function likelihoodparamsmax(horizon::Real)
		return [horizon]
	end
	function likelihoodparamsmin(horizon::Real)
		return [-horizon]
	end
	function performancegoalsatisfied(arrayparams::Vector, horizon::Real)
		paramdict = Dict(zip(getparamkeys(madsdata), getparamsinit(madsdata)))
		optparams = Dict(zip(getoptparamkeys(madsdata), arrayparams))
		merge!(paramdict, optparams)
		predictions = f(paramdict)
		paramsandpredictionsdict = merge(paramdict, predictions)
		for performancegoal in madsdata["Performance Goals"]
			expval = evaluatemadsexpression(performancegoal["exp"], paramsandpredictionsdict)
			if haskey(performancegoal, "lessthan")
				if (1 + horizon) * expval >= performancegoal["lessthan"]
					return false
				elseif (1 - horizon) * expval >= performancegoal["lessthan"]
					return false
				end
			end
			if haskey(performancegoal, "greaterthan")
				if (1 + horizon) * expval <= performancegoal["greaterthan"]
					return false
				elseif (1 - horizon) * expval <= performancegoal["greaterthan"]
					return false
				end
			end
		end
		return true
	end
	function gethorizonoffailure(arrayparams::Vector)
		paramdict = Dict(zip(getparamkeys(madsdata), getparamsinit(madsdata)))
		optparams = Dict(zip(getoptparamkeys(madsdata), arrayparams))
		merge!(paramdict, optparams)
		predictions = f(paramdict)
		paramsandpredictionsdict = merge(paramdict, predictions)
		horizonoffailure = Inf
		for performancegoal in madsdata["Performance Goals"]
			expval = evaluatemadsexpression(performancegoal["exp"], paramsandpredictionsdict)
			if haskey(performancegoal, "lessthan")
				if expval * performancegoal["lessthan"] >= 0#if they have the same sign
					horizonoffailure = max(0., min(horizonoffailure, performancegoal["lessthan"] / expval - 1))
				else#they have the opposite sign
					horizonoffailure = max(0., min(horizonoffailure, 1 - performancegoal["lessthan"] / expval))
				end
			end
			if haskey(performancegoal, "greaterthan")
				if expval * performancegoal["greaterthan"] >= 0#if they have the same sign
					horizonoffailure = max(0., min(horizonoffailure, performancegoal["greaterthan"] / expval - 1))
				else#they have the opposite sign
					horizonoffailure = max(0., min(horizonoffailure, 1 - performancegoal["greaterthan"] / expval))
				end
			end
		end
		return horizonoffailure
	end
	return BIGUQ.BigDT(makeloglikelihood, logprior, nominalparams, likelihoodparamsmin, likelihoodparamsmax, performancegoalsatisfied, gethorizonoffailure)
end

"""
Perform BIG-DT analysis

Arguments:

- `madsdata` : MADS problem dictionary
- `nummodelruns` : number of model runs
- `numhorizons` : number of info-gap horizons of uncertainty
- `maxHorizon` : maximum info-gap horizons of uncertainty
- `numlikelihoods` : number of Bayesian likelihoods

Returns:

- `bigdtresults` : dictionary with BIG-DT results
"""
function dobigdt(madsdata::Associative, nummodelruns::Int; numhorizons::Int=100, maxHorizon::Real=3., numlikelihoods::Int=25)
	parametersamples = parametersample(madsdata, nummodelruns)
	optparamkeys = getoptparamkeys(madsdata)
	modelparams = Array(Float64, length(parametersamples), nummodelruns)
	for i = 1:nummodelruns
		for j = 1:length(optparamkeys)
			modelparams[j, i] = parametersamples[optparamkeys[j]][i]
		end
	end
	getfailureprobs = BIGUQ.makegetfailureprobabilities_mc(modelparams)
	maxfailureprobs = Array(Float64, numhorizons, length(madsdata["Choices"]))
	local horizons::Array{Float64, 1}
	local likelihoodparams::Array{Float64, 2} = zeros(0, 0)
	Mads.madsinfo("Choices:")
	@ProgressMeter.showprogress 1 "Computing ... " for i = 1:length(madsdata["Choices"])
		Mads.madsinfo("Choice #$i: $(madsdata["Choices"][i]["name"])")
		bigdt = makebigdt(madsdata, madsdata["Choices"][i])
		if length(likelihoodparams) == 0
			minlikelihoodparams = bigdt.likelihoodparamsmin(maxHorizon)
			maxlikelihoodparams = bigdt.likelihoodparamsmax(maxHorizon)
			likelihoodparams = BlackBoxOptim.Utils.latin_hypercube_sampling(minlikelihoodparams, maxlikelihoodparams, numlikelihoods)
		end
		maxfailureprobs[:, i], horizons, badlikelihoodparams = BIGUQ.getrobustnesscurve(bigdt, maxHorizon, numlikelihoods; getfailureprobfnct=getfailureprobs, numhorizons=numhorizons, likelihoodparams=likelihoodparams)
	end
	return Dict("maxfailureprobs" => maxfailureprobs, "horizons" => horizons)
end

function makemakearrayconditionalloglikelihood(madsdata::Associative)
	function makeloglikelihood(likelihoodparams::Vector)
		log10weightfactor = likelihoodparams[1]
		return makearrayconditionalloglikelihood(madsdata, makemadsconditionalloglikelihood(madsdata; weightfactor=10 ^ log10weightfactor))
	end
end