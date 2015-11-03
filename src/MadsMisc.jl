@doc "Arcsine transformation of model parameters" ->
function asinetransform(params::Vector, lowerbounds::Vector, upperbounds::Vector, indexlogtransformed::Vector) # asine transformation
	sineparams = copy(params)
	sineparams[indexlogtransformed] = log10(sineparams[indexlogtransformed])
	sineparams = asin((sineparams - lowerbounds) ./ (upperbounds - lowerbounds) * 2 - 1)
	return sineparams
end

@doc "Sine transformation of model parameters" ->
function sinetransform(sineparams::Vector, lowerbounds::Vector, upperbounds::Vector, indexlogtransformed::Vector) # sine transformation
	params = lowerbounds + (upperbounds - lowerbounds) .* ((1 + sin(sineparams)) * .5) # untransformed parameters (regular parameter space)
	params[indexlogtransformed] = 10 .^ params[indexlogtransformed]
	return params
end

@doc "Sine transformation of a function" ->
function sinetransformfunction(f::Function, lowerbounds::Vector, upperbounds::Vector, indexlogtransformed::Vector) # sine transformation a function
	function sinetransformedf(sineparams::Vector)
		return f(sinetransform(sineparams, lowerbounds, upperbounds, indexlogtransformed))
	end
	return sinetransformedf
end

@doc "Sine transformation of a gradient function" ->
function sinetransformgradient(g::Function, lowerbounds::Vector, upperbounds::Vector, indexlogtransformed::Vector; sindx = 0.1) # sine transformation a gradient function
	function sinetransformedg(sineparams::Vector)
		#TODO option needed to control sindx
		params = sinetransform(sineparams, lowerbounds, upperbounds, indexlogtransformed)
		dxparams = sinetransform(sineparams .+ sindx, lowerbounds, upperbounds, indexlogtransformed)
		lineardx = dxparams - params
		result = g(params; dx=lineardx)
		lineardx ./= sindx
		for j = 1:size(result, 2)
			for i = 1:size(result, 1)
				# println(result[i, j])
				result[i, j] *= lineardx[j]
			end
		end
		return result
	end
	return sinetransformedg
end

@doc "Make a version of f that accepts an array containing the opt parameters' values" ->
function makearrayfunction(madsdata, f)
	optparamkeys = getoptparamkeys(madsdata)
	initparams = Dict(zip(getparamkeys(madsdata), getparamsinit(madsdata)))
	function arrayfunction(arrayparameters::Vector)
		return f(merge(initparams, Dict(zip(optparamkeys, arrayparameters))))
	end
	return arrayfunction
end

@doc "Make a conditional log likelihood function that accepts an array containing the opt parameters' values" ->
function makearrayconditionalloglikelihood(madsdata, conditionalloglikelihood)
	f = makemadscommandfunction(madsdata)
	optparamkeys = getoptparamkeys(madsdata)
	initparams = Dict(zip(getparamkeys(madsdata), getparamsinit(madsdata)))
	function arrayconditionalloglikelihood(arrayparameters::Vector)
		predictions = f(merge(initparams, Dict(zip(optparamkeys, arrayparameters))))
		cll = conditionalloglikelihood(predictions, madsdata["Observations"])
		return cll
	end
	return arrayconditionalloglikelihood
end

@doc "Make a log likelihood function that accepts an array containing the opt parameters' values" ->
function makearrayloglikelihood(madsdata, loglikelihood) # make log likelihood array
	f = makemadscommandfunction(madsdata)
	optparamkeys = getoptparamkeys(madsdata)
	initparams = Dict(zip(getparamkeys(madsdata), getparamsinit(madsdata)))
	function arrayloglikelihood(arrayparameters::Vector)
		predictions = Dict()
		try
			predictions = f(merge(initparams, Dict(zip(optparamkeys, arrayparameters))))
		catch DomainError #TODO fix this so that we don't call f if the prior likelihood is zero...this is a dirty hack
			return -Inf
		end
		loglikelihood(Dict(zip(optparamkeys, arrayparameters)), predictions, madsdata["Observations"])
	end
	return arrayloglikelihood
end

@doc "Set Dynamic Model for MADS model calls using internal Julia functions" ->
function setdynamicmodel(madsdata, f::Function)
	madsdata["Dynamic model"] = f
end

@doc "Evaluate the expression in terms of the parameters, return a Dict() containing the expression names as keys, and the values of the expression as values" ->
function evaluatemadsexpression(expressionstring, parameters)
	expression = parse(expressionstring)
	expression = MPTools.populateexpression(expression, parameters)
	retval::Float64
	retval = eval(expression) # populate the expression with the parameter values, then evaluate it
	return retval
end

@doc "Evaluate the expressions in terms of the parameters, return a Dict() containing the expression names as keys, and the values of the expression as values" ->
function evaluatemadsexpressions(parameters, madsdata)
	if haskey(madsdata, "Expressions")
		expressions = Dict()
		for exprname in keys(madsdata["Expressions"])
			expressions[exprname] = evaluatemadsexpression(madsdata["Expressions"][exprname]["exp"], parameters)
		end
		return expressions
	else
		return Dict()
	end
end
