"Make a version of f that accepts an array containing the opt parameters' values"
function makearrayfunction(madsdata, f)
	optparamkeys = getoptparamkeys(madsdata)
	initparams = Dict(zip(getparamkeys(madsdata), getparamsinit(madsdata)))
	function arrayfunction(arrayparameters::Vector)
		return f(merge(initparams, Dict(zip(optparamkeys, arrayparameters))))
	end
	return arrayfunction
end

"Make a conditional log likelihood function that accepts an array containing the opt parameters' values"
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

"Make a log likelihood function that accepts an array containing the opt parameters' values"
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

"Set Dynamic Model for MADS model calls using internal Julia functions"
function setdynamicmodel(madsdata, f::Function)
	madsdata["Dynamic model"] = f
end

"Evaluate the expression in terms of the parameters, return a Dict() containing the expression names as keys, and the values of the expression as values"
function evaluatemadsexpression(expressionstring, parameters)
	expression = parse(expressionstring)
	expression = MPTools.populateexpression(expression, parameters)
	retval::Float64
	retval = eval(expression) # populate the expression with the parameter values, then evaluate it
	return retval
end

"Evaluate the expressions in terms of the parameters, return a Dict() containing the expression names as keys, and the values of the expression as values"
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
