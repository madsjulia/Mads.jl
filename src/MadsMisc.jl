import MetaProgTools
import OrderedCollections
import DocumentFunction
import Printf

#=
function makearrayfunction_vector(madsdata::AbstractDict, f::Function=makemadscommandfunction(madsdata))
	function arrayfunction(arrayparameters::AbstractVector)
		return f(arrayparameters)
	end
	return arrayfunction
end
=#

function makearrayfunction_dictionary(madsdata::AbstractDict, f::Function=makemadscommandfunction(madsdata))
	optparamkeys = getoptparamkeys(madsdata)
	initparams = Mads.getparamdict(madsdata)
	function arrayfunction_merge(arrayparameters::AbstractVector)
		@assert length(arrayparameters) == length(optparamkeys)
		return f(merge(initparams, OrderedCollections.OrderedDict{String,Float64}(zip(optparamkeys, arrayparameters))))
	end
	function arrayfunction(arrayparameters::AbstractVector)
		@assert length(arrayparameters) == length(optparamkeys)
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
	function doublearrayfunction(arrayparameters::AbstractMatrix)
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
	function doublearrayfunction(arrayparameters::AbstractVector)
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
	function arrayconditionalloglikelihood(arrayparameters::AbstractVector)
		@assert length(arrayparameters) == length(optparamkeys)
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
function makearrayloglikelihood(madsdata::AbstractDict, loglikelihood)
	f = makemadscommandfunction(madsdata)
	optparamkeys = getoptparamkeys(madsdata)
	initparams = Mads.getparamdict(madsdata)
	function arrayloglikelihood(arrayparameters::AbstractVector)
		predictions = OrderedCollections.OrderedDict()
		@assert length(arrayparameters) == length(optparamkeys)
		d = OrderedCollections.OrderedDict{String,Float64}(zip(optparamkeys, arrayparameters))
		try
			predictions = f(merge(initparams, d))
		catch
			return -Inf
		end
		loglikelihood(d, predictions, madsdata["Observations"])
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
function evaluatemadsexpression(expressionstring::AbstractString, parameters::AbstractDict)
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
function evaluatemadsexpressions(madsdata::AbstractDict, parameters::AbstractDict=Mads.getparamdict(madsdata))
	if haskey(madsdata, "Expressions")
		expkeys = keys(madsdata["Expressions"])
		for k in expkeys
			e = evaluatemadsexpression(madsdata["Expressions"][k]["exp"], parameters)
			parameters[k] = e
		end
	end
	if haskey(madsdata, "Order")
		parameters_ordered = OrderedCollections.OrderedDict{String,Float64}()
		for k in madsdata["Order"]
			parameters_ordered[k] = parameters[k]
		end
		# display(parameters_ordered)
		parameters = parameters_ordered
	end
	return parameters
end

"Convert `@Printf.sprintf` macro into `sprintf` function"
sprintf(args...) = Core.eval(Mads, :@Printf.sprintf($(args...)))

"""
Parse parameter distribution from a string

$(DocumentFunction.documentfunction(getdistribution;
argtext=Dict("dist"=>"parameter distribution",
            "inputtype"=>"input type (parameter or observation)")))

Returns:

- distribution
"""
function getdistribution(dist::AbstractString, inputtype::AbstractString="parameter")
	distribution = nothing
	try
		distribution = Distributions.eval(Meta.parse(dist))
	catch errmsg
		printerrormsg(errmsg)
		madserror("Something is wrong with $(inputtype) distribution (dist: '$(dist)')")
	end
	return distribution
end

function decimal_year(dyear::AbstractFloat, period::Type{<:Dates.Period}=Dates.Nanosecond)
	year, reminder = divrem(dyear, 1)
	year_start = Dates.DateTime(year)
	@show typeof(year_start)
	@show typeof((year_start + Dates.Year(1)) - year_start)
	nanoseconds_year = period((year_start + Dates.Year(1)) - year_start)
	@show nanoseconds_year
	partial = period(round(Dates.value(nanoseconds_year) * reminder))
	return year_start + partial
end

function decimal_day(dday::AbstractFloat, date_start::Dates.DateTime=Dates.now(), period::Type{<:Dates.Period}=Dates.Nanosecond)
	day, reminder = divrem(dday, 1)
	nanoseconds_day = period(Dates.Day(1))
	partial = period(round(Dates.value(nanoseconds_day) * reminder))
	return date_start + Dates.Day(day) + partial
end

function decimal_day(dday::AbstractFloat, date_start::Dates.Date, period::Type{<:Dates.Period}=Dates.Nanosecond)
	decimal_day(dday, Dates.DateTime.(date_start), period)
end