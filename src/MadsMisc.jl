import MetaProgTools
import DataStructures

"""
Make a version of the function `f` that accepts an array containing the optimal parameters' values

```julia
Mads.makearrayfunction(madsdata, f)
```

Arguments:

- `madsdata` : MADS problem dictionary
- `f` : ...

Returns:

- `arrayfunction` : function accepting an array containing the optimal parameters' values

$(documentfunction(makearrayfunction))
"""
function makearrayfunction(madsdata::Associative, f::Function=makemadscommandfunction(madsdata))
	optparamkeys = getoptparamkeys(madsdata)
	initparams = DataStructures.OrderedDict{String,Float64}(zip(getparamkeys(madsdata), getparamsinit(madsdata)))
	function arrayfunction(arrayparameters::Vector)
		return f(merge(initparams, DataStructures.OrderedDict{String,Float64}(zip(optparamkeys, arrayparameters))))
	end
	return arrayfunction
end

"""
Make a version of the function `f` that accepts an array containing the optimal parameters' values, and returns an array of observations

```julia
Mads.makedoublearrayfunction(madsdata, f)
```

Arguments:

- `madsdata` : MADS problem dictionary
- `f` : ...

Returns:

- `doublearrayfunction` : function accepting an array containing the optimal parameters' values, and returning an array of observations

$(documentfunction(makedoublearrayfunction))
"""
function makedoublearrayfunction(madsdata::Associative, f::Function=makemadscommandfunction(madsdata))
	arrayfunction = makearrayfunction(madsdata, f)
	obskeys = getobskeys(madsdata)
	function doublearrayfunction(arrayparameters::Vector)
		dictresult = arrayfunction(arrayparameters)
		arrayresult = Array{Float64}(length(obskeys))
		i = 1
		for k in obskeys
			arrayresult[i] = dictresult[k]
			i += 1
		end
		return arrayresult
	end
	return doublearrayfunction
end

"""
Make a conditional log likelihood function that accepts an array containing the opt parameters' values

$(documentfunction(makearrayconditionalloglikelihood))
"""
function makearrayconditionalloglikelihood(madsdata::Associative, conditionalloglikelihood)
	f = makemadscommandfunction(madsdata)
	optparamkeys = getoptparamkeys(madsdata)
	initparams = DataStructures.OrderedDict{String,Float64}(zip(getparamkeys(madsdata), getparamsinit(madsdata)))
	function arrayconditionalloglikelihood(arrayparameters::Vector)
		predictions = f(merge(initparams, DataStructures.OrderedDict{String,Float64}(zip(optparamkeys, arrayparameters))))
		cll = conditionalloglikelihood(predictions, madsdata["Observations"])
		return cll
	end
	return arrayconditionalloglikelihood
end

"""
Make a log likelihood function that accepts an array containing the opt parameters' values

$(documentfunction(makearrayloglikelihood))
"""
function makearrayloglikelihood(madsdata::Associative, loglikelihood) # make log likelihood array
	f = makemadscommandfunction(madsdata)
	optparamkeys = getoptparamkeys(madsdata)
	initparams = DataStructures.OrderedDict{String,Float64}(zip(getparamkeys(madsdata), getparamsinit(madsdata)))
	function arrayloglikelihood(arrayparameters::Vector)
		predictions = DataStructures.OrderedDict()
		try
			predictions = f(merge(initparams, DataStructures.OrderedDict{String,Float64}(zip(optparamkeys, arrayparameters))))
		catch e
			return -Inf
		end
		loglikelihood(DataStructures.OrderedDict{String,Float64}(zip(optparamkeys, arrayparameters)), predictions, madsdata["Observations"])
	end
	return arrayloglikelihood
end

"""
Set Dynamic Model for MADS model calls using internal Julia functions

$(documentfunction(setdynamicmodel))
"""
function setdynamicmodel(madsdata::Associative, f::Function)
	madsdata["Dynamic model"] = f
end

"""
Evaluate the expression in terms of the parameters, return a Dict() containing the expression names as keys, and the values of the expression as values

$(documentfunction(evaluatemadsexpression))
"""
function evaluatemadsexpression(expressionstring::String, parameters::Associative)
	expression = parse(expressionstring)
	expression = MetaProgTools.populateexpression(expression, parameters)
	local retval::Float64
	retval = eval(expression) # populate the expression with the parameter values, then evaluate it
	return retval
end

"""
Evaluate the expressions in terms of the parameters, return a Dict() containing the expression names as keys, and the values of the expression as values

$(documentfunction(evaluatemadsexpressions))
"""
function evaluatemadsexpressions(madsdata::Associative, parameters::Associative)
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

"Convert `@sprintf` macro into `sprintf` function"
sprintf(args...) = eval(:@sprintf($(args...)))

"""
Parse distribution from a string

$(documentfunction(getdistribution))
"""
function getdistribution(dist::String, i::String, inputtype::String)
	distribution = nothing
	try
		distribution = Distributions.eval(parse(dist))
	catch e
		printerrormsg(e)
		madserror("""Something is wrong with $inputtype '$i' distribution (dist: '$(dist)')""")
	end
	return distribution
end
