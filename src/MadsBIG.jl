import BIGUQ

function makebigdt(madsdata::Associative, choice::Associative)
	return makebigdt!(deepcopy(madsdata), choice)
end

function makebigdt!(madsdata::Associative, choice::Associative)
	for paramname in keys(choice["Parameters"])
		if madsdata["Parameters"][paramname]["type"] == "opt"
			error("A decision parameter, $paramname, is also an \"opt\" parameter.")
		end
		madsdata["Parameters"][paramname]["init"] = choice["Parameters"][paramname]
	end
	makeloglikelihood = makemakearrayconditionalloglikelihood(madsdata)
	logprior = makearrayfunction(madsdata, makelogprior(madsdata))
	nominalparams = getparamsinit(madsdata)
	f = makemadscommandfunction(madsdata)
	function likelihoodparamsmax(horizon::Real)
		return [horizon]
	end
	function likelihoodparamsmin(horizon::Real)
		return [-horizon]
	end
	function performancegoalsatisfied(arrayparams::Vector, horizon::Real)
		paramdict = Dict(getparamkeys(madsdata), getparamsinit(madsdata))
		optparams = Dict(getoptparamkeys(madsdata), arrayparams)
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
	return BIGUQ.BigDT(makeloglikelihood, logprior, nominalparams, likelihoodparamsmin, likelihoodparamsmax, performancegoalsatisfied)
end

function dobigdt(madsdata::Associative, nummodelruns::Int; numhorizons::Int=100, hakunamatata::Real=3., numlikelihoods::Int=25)
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
	for i = 1:length(madsdata["Choices"])
		bigdt = makebigdt(madsdata, madsdata["Choices"][i])
		maxfailureprobs[:, i], horizons, badlikelihoodparams = BIGUQ.getrobustnesscurve(bigdt, hakunamatata, numlikelihoods; getfailureprobfnct=getfailureprobs, numhorizons=numhorizons)
	end
	return maxfailureprobs, horizons
end

function makemakearrayconditionalloglikelihood(madsdata::Associative)
	function makeloglikelihood(likelihoodparams::Vector)
		log10weightfactor = likelihoodparams[1]
		return makearrayconditionalloglikelihood(madsdata, makemadsconditionalloglikelihood(madsdata; weightfactor=10 ^ log10weightfactor))
	end
end

function plotrobustnesscurves(madsdata::Associative, maxfailureprobs::Matrix, horizons::Vector, filename::String; format="")
	filename, format = setimagefileformat(filename, format)
	layers = Array(Any, size(maxfailureprobs, 2))
	df = DataFrame(horizon=[], maxfailureprob=[], Choice=[])
	for i = 1:size(maxfailureprobs, 2)
		df = vcat(df, DataFrame(horizon=horizons, maxfailureprob=maxfailureprobs[:, i], Choice=madsdata["Choices"][i]["name"]))
		#layers[i] = Gadfly.layer(x=horizons, y=maxfailureprobs[:, i], Geom.line)
	end
	#p = Gadfly.plot(layers..., Guide.xlabel("Horizon of uncertainty"), Guide.ylabel("Max probability of failure"))
	p = Gadfly.plot(df, x="horizon", y="maxfailureprob", color="Choice", Geom.line, Guide.xlabel("Horizon of uncertainty"), Guide.ylabel("Max probability of failure"), Scale.color_discrete_manual(["red" "blue" "green" "cyan" "magenta" "yellow"]...))
	Gadfly.draw(eval(Gadfly.symbol(format))(filename, 4Gadfly.inch, 3Gadfly.inch), p)
	return nothing
end
