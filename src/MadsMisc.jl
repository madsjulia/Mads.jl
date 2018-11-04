import MetaProgTools
import OrderedCollections
import DocumentFunction
using Printf

#=
function makearrayfunction_vector(madsdata::AbstractDict, f::Function=makemadscommandfunction(madsdata))
	function arrayfunction(arrayparameters::Vector)
		return f(arrayparameters)
	end
	return arrayfunction
end
=#

function makearrayfunction_dictionary(madsdata::AbstractDict, f::Function=makemadscommandfunction(madsdata))
	optparamkeys = getoptparamkeys(madsdata)
	initparams = Mads.getparamdict(madsdata)
	function arrayfunction_merge(arrayparameters::Vector)
		return f(merge(initparams, OrderedCollections.OrderedDict{String,Float64}(zip(optparamkeys, arrayparameters))))
	end
	function arrayfunction(arrayparameters::Vector)
		return f(OrderedCollections.OrderedDict{String,Float64}(zip(optparamkeys, arrayparameters)))
	end
	if length(initparams) == length(optparamkeys)
		return arrayfunction
	else
		return arrayfunction_merge
	end
end

function makearrayfunction(madsdata::AbstractDict, f::Function=makemadscommandfunction(madsdata))
	# arrayfunction = vectorflag ? makearrayfunction_vector(madsdata, f) : makearrayfunction_dictionary(madsdata, f)
	makearrayfunction_dictionary(madsdata, f)
end

@doc """
Make a version of the function `f` that accepts an array containing the optimal parameter values

$(DocumentFunction.documentfunction(makearrayfunction;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "f"=>"function [default=`makemadscommandfunction(madsdata)`]")))

Returns:

- function accepting an array containing the optimal parameter values
""" makearrayfunction

function makedoublearrayfunction_vector(madsdata::AbstractDict, f::Function=makemadscommandfunction(madsdata))
	arrayfunction = makearrayfunction(madsdata, f)
	function doublearrayfunction(arrayparameters::Matrix)
		nr = size(arrayparameters, 2)
		vectorresult = Array{Float64}(undef, nr)
		for i = 1:nr
			vectorresult[i] = arrayfunction(arrayparameters[:,i])
		end
		return vectorresult
	end
	return doublearrayfunction
end

function makedoublearrayfunction_dictionary(madsdata::AbstractDict, f::Function=makemadscommandfunction(madsdata))
	arrayfunction = makearrayfunction(madsdata, f)
	obskeys = getobskeys(madsdata)
	function doublearrayfunction(arrayparameters::Vector)
		dictresult = arrayfunction(arrayparameters)
		arrayresult = Array{Float64}(undef, length(obskeys))
		i = 1
		for k in obskeys
			arrayresult[i] = dictresult[k]
			i += 1
		end
		return arrayresult
	end
	return doublearrayfunction
end

function makedoublearrayfunction(madsdata::AbstractDict, f::Function=makemadscommandfunction(madsdata))
	doublearrayfunction = vectorflag ? makedoublearrayfunction_vector(madsdata, f) : makedoublearrayfunction_dictionary(madsdata, f)
end

@doc """
Make a version of the function `f` that accepts an array containing the optimal parameter values, and returns an array of observations

$(DocumentFunction.documentfunction(makedoublearrayfunction;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "f"=>"function [default=`makemadscommandfunction(madsdata)`]")))

Returns:

- function accepting an array containing the optimal parameter values, and returning an array of observations
""" makedoublearrayfunction

"""
Make a conditional log likelihood function that accepts an array containing the optimal parameter values

$(DocumentFunction.documentfunction(makearrayconditionalloglikelihood;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "conditionalloglikelihood"=>"conditional log likelihood")))

Returns:

- a conditional log likelihood function that accepts an array
"""
function makearrayconditionalloglikelihood(madsdata::AbstractDict, conditionalloglikelihood)
	f = makemadscommandfunction(madsdata)
	optparamkeys = getoptparamkeys(madsdata)
	initparams = Mads.getparamdict(madsdata)
	function arrayconditionalloglikelihood(arrayparameters::Vector)
		predictions = f(merge(initparams, OrderedCollections.OrderedDict{String,Float64}(zip(optparamkeys, arrayparameters))))
		cll = conditionalloglikelihood(predictions, madsdata["Observations"])
		return cll
	end
	return arrayconditionalloglikelihood
end

"""
Make a log likelihood function that accepts an array containing the optimal parameter values

$(DocumentFunction.documentfunction(makearrayloglikelihood;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "loglikelihood"=>"log likelihood")))

Returns:

- a log likelihood function that accepts an array
"""
function makearrayloglikelihood(madsdata::AbstractDict, loglikelihood) # make log likelihood array
	f = makemadscommandfunction(madsdata)
	optparamkeys = getoptparamkeys(madsdata)
	initparams = Mads.getparamdict(madsdata)
	function arrayloglikelihood(arrayparameters::Vector)
		predictions = OrderedCollections.OrderedDict()
		try
			predictions = f(merge(initparams, OrderedCollections.OrderedDict{String,Float64}(zip(optparamkeys, arrayparameters))))
		catch
			return -Inf
		end
		loglikelihood(OrderedCollections.OrderedDict{String,Float64}(zip(optparamkeys, arrayparameters)), predictions, madsdata["Observations"])
	end
	return arrayloglikelihood
end

"""
Evaluate an expression string based on a parameter dictionary

$(DocumentFunction.documentfunction(evaluatemadsexpression;
argtext=Dict("expressionstring"=>"expression string",
            "parameters"=>"parameter dictionary applied to evaluate the expression string")))

Returns:

- dictionary containing the expression names as keys, and the values of the expression as values
"""
function evaluatemadsexpression(expressionstring::String, parameters::AbstractDict)
	expression = Meta.parse(expressionstring)
	expression = MetaProgTools.populateexpression(expression, parameters)
	local retval::Float64
	retval = Core.eval(Main, expression) # populate the expression with the parameter values, then evaluate it
	return retval
end

"""
Evaluate all the expressions in the Mads problem dictiorany based on a parameter dictionary

$(DocumentFunction.documentfunction(evaluatemadsexpressions;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "parameters"=>"parameter dictionary applied to evaluate the expression strings")))

Returns:

- dictionary containing the parameter and expression names as keys, and the values of the expression as values
"""
function evaluatemadsexpressions(madsdata::AbstractDict, parameters::AbstractDict)
	if haskey(madsdata, "Expressions")
		expressions = Dict()
		expkeys = keys(madsdata["Expressions"])
		for exprname in expkeys
			expressions[exprname] = evaluatemadsexpression(madsdata["Expressions"][exprname]["exp"], parameters)
		end
		for exprname in expkeys
			parameters[exprname] = expressions[exprname]
		end
	end
	return parameters
end

"Convert `@Printf.sprintf` macro into `sprintf` function"
sprintf(args...) = Core.eval(Mads, :@Printf.sprintf($(args...)))

"""
Parse parameter distribution from a string

$(DocumentFunction.documentfunction(getdistribution;
argtext=Dict("dist"=>"parameter distribution",
            "inputname"=>"input name (name of a parameter or observation)",
            "inputtype"=>"input type (parameter or observation)")))

Returns:

- distribution
"""
function getdistribution(dist::String, i::String, inputtype::String)
	distribution = nothing
	try
		distribution = Distributions.eval(Meta.parse(dist))
	catch errmsg
		printerrormsg(errmsg)
		madserror("Something is wrong with $(inputtype) distribution (dist: '$(dist)')")
	end
	return distribution
end
