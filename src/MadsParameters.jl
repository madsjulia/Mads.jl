import Distributions
import OrderedCollections
import DocumentFunction

"""
Check if a dictionary containing all the Mads model parameters

$(DocumentFunction.documentfunction(isparam;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "dict"=>"dictionary")))

Returns:

- `true` if the dictionary containing all the parameters, `false` otherwise
"""
function isparam(madsdata::AbstractDict, dict::AbstractDict)
	if haskey(madsdata, "Parameters")
		par = getparamkeys(madsdata)
	else
		par = collect(keys(madsdata))
	end
	flag = true
	for i in par
		if !haskey(dict, i)
			flag = false
			break
		end
	end
	return flag
end

"""
Get keys of all parameters in the MADS problem dictionary

$(DocumentFunction.documentfunction(getparamkeys;
argtext=Dict("madsdata"=>"MADS problem dictionary"),
keytext=Dict("filter"=>"parameter filter")))

Returns:

- array with the keys of all parameters in the MADS problem dictionary
"""
function getparamkeys(madsdata::AbstractDict; filter::String="")
	if haskey(madsdata, "Parameters")
		return collect(filterkeys(madsdata["Parameters"], filter))
	end
end

"""
Get dictionary with all parameters and their respective initial values

$(DocumentFunction.documentfunction(getparamdict;
argtext=Dict("madsdata"=>"MADS problem dictionary")))

Returns:

- dictionary with all parameters and their respective initial values
"""
function getparamdict(madsdata::AbstractDict)
	if haskey(madsdata, "Parameters")
		paramkeys = Mads.getparamkeys(madsdata)
		paramdict = OrderedCollections.OrderedDict{String,Float64}(zip(paramkeys, map(key->madsdata["Parameters"][key]["init"], paramkeys)))
		return paramdict
	end
end

"""
Get keys of all source parameters in the MADS problem dictionary

$(DocumentFunction.documentfunction(getsourcekeys;
argtext=Dict("madsdata"=>"MADS problem dictionary")))

Returns:

- array with keys of all source parameters in the MADS problem dictionary
"""
function getsourcekeys(madsdata::AbstractDict)
	sourcekeys = Array{String}(undef, 0)
	if haskey(madsdata, "Sources")
		for i = 1:length(madsdata["Sources"])
			for k = keys(madsdata["Sources"][1])
				sk = collect(String, keys(madsdata["Sources"][i][k]))
				b = fill("Source1_", length(sk))
				s = b .* sk
				sourcekeys = [sourcekeys; s]
			end
		end
	end
	return sourcekeys
end

# Make functions to get MADS parameter variable names"
getparamsnames = ["init", "type", "log", "step", "longname", "plotname"]
getparamstypes = [Float64, Any, Any, Float64, String, String]
getparamsdefault = [0, "opt", false, sqrt(eps(Float32)), "", ""]
getparamslogdefault = [1, "opt", true, sqrt(eps(Float32)), "", ""]
global index = 0
for i = 1:length(getparamsnames)
	global index = i
	paramname = getparamsnames[index]
	paramtype = getparamstypes[index]
	paramdefault = getparamsdefault[index]
	paramlogdefault = getparamslogdefault[index]
	q = quote
		"""
		Get an array with $(getparamsnames[index]) values for parameters defined by `paramkeys`
		"""
		function $(Symbol(string("getparams", paramname)))(madsdata::AbstractDict, paramkeys::Vector) # create a function to get each parameter name with 2 arguments
			paramvalue = Array{$(paramtype)}(undef, length(paramkeys))
			for i in 1:length(paramkeys)
				if haskey(madsdata["Parameters"][paramkeys[i]], $paramname)
					paramvalue[i] = madsdata["Parameters"][paramkeys[i]][$paramname]
				else
					if Mads.islog(madsdata, paramkeys[i])
						paramvalue[i] = $(paramlogdefault)
					else
						paramvalue[i] = $(paramdefault)
					end
				end
			end
			return paramvalue # returns the parameter values
		end
		"""
		Get an array with $(getparamsnames[index]) values for all the MADS model parameters
		"""
		function $(Symbol(string("getparams", paramname)))(madsdata::AbstractDict) # create a function to get each parameter name with 1 argument
			paramkeys = Mads.getparamkeys(madsdata) # get parameter keys
			return $(Symbol(string("getparams", paramname)))(madsdata::AbstractDict, paramkeys) # call the function with 2 arguments
		end
	end
	Core.eval(Mads, q)
end

function getparamsmin(madsdata::AbstractDict, paramkeys::AbstractVector)
	paramvalue = Array{Float64}(undef, length(paramkeys))
	for i in 1:length(paramkeys)
		p = madsdata["Parameters"][paramkeys[i]]
		if haskey(p, "min")
			paramvalue[i] = p["min"]
			continue
		elseif haskey(p, "dist")
			distribution = Mads.getdistribution(p["dist"], paramkeys[i], "parameter")
			if typeof(distribution) <: Distributions.Uniform
				paramvalue[i] = distribution.a
				continue
			end
		end
		if Mads.islog(madsdata, paramkeys[i])
			paramvalue[i] = 1e-6
		else
			paramvalue[i] = -1e6
		end
	end
	return paramvalue # returns the parameter values
end
function getparamsmin(madsdata::AbstractDict)
	paramkeys = getparamkeys(madsdata)
	return getparamsmin(madsdata, paramkeys)
end

@doc """
Get an array with `min` values for parameters defined by `paramkeys`

$(DocumentFunction.documentfunction(getparamsmin;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "paramkeys"=>"parameter keys")))

Returns:

- the parameter values
""" getparamsmin

function getparamsmax(madsdata::AbstractDict, paramkeys::Vector)
	paramvalue = Array{Float64}(undef, length(paramkeys))
	for i in 1:length(paramkeys)
		p = madsdata["Parameters"][paramkeys[i]]
		if haskey(p, "max")
			paramvalue[i] = p["max"]
			continue
		elseif haskey(p, "dist")
			distribution = Mads.getdistribution(p["dist"], paramkeys[i], "parameter")
			if typeof(distribution) <: Distributions.Uniform
				paramvalue[i] = distribution.b
				continue
			end
		end
		if Mads.islog(madsdata, paramkeys[i])
			paramvalue[i] = 1e+6
		else
			paramvalue[i] = 1e6
		end
	end
	return paramvalue # returns the parameter values
end
function getparamsmax(madsdata::AbstractDict)
	paramkeys = getparamkeys(madsdata)
	return getparamsmax(madsdata, paramkeys)
end

@doc """
Get an array with `max` values for parameters defined by `paramkeys`

$(DocumentFunction.documentfunction(getparamsmax;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "paramkeys"=>"parameter keys")))

Returns:

- returns the parameter values
""" getparamsmax

function getparamsinit_min(madsdata::AbstractDict, paramkeys::Vector)
	paramvalue = Array{Float64}(undef, length(paramkeys))
	for i in 1:length(paramkeys)
		p = madsdata["Parameters"][paramkeys[i]]
		if haskey(p, "init_min")
			paramvalue[i] = p["init_min"]
			continue
		end
		if haskey(p, "init_dist")
			distribution = Mads.getdistribution(p["init_dist"], paramkeys[i], "parameter")
			if typeof(distribution) <: Distributions.Uniform
				paramvalue[i] = distribution.a
				continue
			end
		end
		if haskey(p, "min")
			paramvalue[i] = p["min"]
			continue
		end
		if haskey(p, "dist")
			distribution = Mads.getdistribution(p["dist"], paramkeys[i], "parameter")
			if typeof(distribution) <: Distributions.Uniform
				paramvalue[i] = distribution.a
				continue
			end
		end
		if Mads.islog(madsdata, paramkeys[i])
			paramvalue[i] = 1e-6
		else
			paramvalue[i] = -1e6
		end
	end
	return paramvalue # returns the parameter values
end
function getparamsinit_min(madsdata::AbstractDict)
	paramkeys = getparamkeys(madsdata)
	return getparamsinit_min(madsdata, paramkeys)
end

@doc """
Get an array with `init_min` values for parameters

$(DocumentFunction.documentfunction(getparamsinit_min;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "paramkeys"=>"parameter keys")))

Returns:

- the parameter values
""" getparamsinit_min

function getparamsinit_max(madsdata::AbstractDict, paramkeys::Vector)
	paramvalue = Array{Float64}(undef, length(paramkeys))
	for i in 1:length(paramkeys)
		p = madsdata["Parameters"][paramkeys[i]]
		if haskey(p, "init_max")
			paramvalue[i] = p["init_max"]
			continue
		end
		if haskey(p, "init_dist")
			distribution = Mads.getdistribution(p["init_dist"], paramkeys[i], "parameter")
			if typeof(distribution) <: Distributions.Uniform
				paramvalue[i] = distribution.b
				continue
			end
		end
		if haskey(p, "max")
			paramvalue[i] = p["max"]
			continue
		end
		if haskey(p, "dist")
			distribution = Mads.getdistribution(p["dist"], paramkeys[i], "parameter")
			if typeof(distribution) <: Distributions.Uniform
				paramvalue[i] = distribution.b
				continue
			end
		end
		if Mads.islog(madsdata, paramkeys[i])
			paramvalue[i] = 1e+6
		else
			paramvalue[i] = 1e6
		end
	end
	return paramvalue # returns the parameter values
end
function getparamsinit_max(madsdata::AbstractDict)
	paramkeys = getparamkeys(madsdata)
	return getparamsinit_max(madsdata, paramkeys)
end

@doc """
Get an array with `init_max` values for parameters defined by `paramkeys`

$(DocumentFunction.documentfunction(getparamsinit_max;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "paramkeys"=>"parameter keys")))

Returns:

- the parameter values
""" getparamsinit_max

"""
Set initial optimized parameter guesses in the MADS problem dictionary

$(DocumentFunction.documentfunction(setparamsinit!;
argtext=Dict("madsdata"=>"MADS problem dictionary",
             "paramdict"=>"dictionary with initial model parameter values",
            "paramdictarray"=>"dictionary of arrays with initial model parameter values",
            "idx"=>"index of the dictionary of arrays with initial model parameter values")))
"""
function setparamsinit!(madsdata::AbstractDict, paramdict::AbstractDict, idx::Int=1)
	paramkeys = getparamkeys(madsdata)
	for k in paramkeys
		if haskey(paramdict, k)
			if typeof(paramdict[k]) <: Number
				madsdata["Parameters"][k]["init"] = paramdict[k]
			else
				madsdata["Parameters"][k]["init"] = paramdict[k][idx]
			end
		end
	end
	setsourceinit!(madsdata, paramdict, idx)
end

"""
Set initial optimized parameter guesses in the MADS problem dictionary for the Source class

$(DocumentFunction.documentfunction(setparamsinit!;
argtext=Dict("madsdata"=>"MADS problem dictionary",
             "paramdict"=>"dictionary with initial model parameter values",
            "paramdictarray"=>"dictionary of arrays with initial model parameter values",
            "idx"=>"index of the dictionary of arrays with initial model parameter values")))
"""
function setsourceinit!(madsdata::AbstractDict, paramdict::AbstractDict, idx::Int=1)
	if haskey(madsdata, "Sources")
		ns = length(madsdata["Sources"])
		paramkeys = getparamkeys(madsdata)
		for k in paramkeys
			if haskey(paramdict, k) && occursin(r"source[1-9]*_(.*)", k)
				m = match(r"source([1-9])*_(.*)", k)
				sn = Meta.parse(m.captures[1])
				pk = m.captures[2]
				if sn > 0 && sn < ns
					sk = collect(keys(madsdata["Sources"][sn]))[1]
					if typeof(paramdict[k]) <: Number
						madsdata["Sources"][sn][sk][pk]["init"] = paramdict[k]
					else
						madsdata["Sources"][sn][sk][pk]["init"] = paramdict[k][idx]
					end
				end
			end
		end
	end
end

function getoptparams(madsdata::AbstractDict)
	getoptparams(madsdata, getparamsinit(madsdata), getoptparamkeys(madsdata))
end
function getoptparams(madsdata::AbstractDict, parameterarray::Array, optparameterkey::Array=[])
	if length(optparameterkey) == 0
		optparameterkey = getoptparamkeys(madsdata)
	end
	parameterkey = getparamkeys(madsdata)
	nP = length(parameterkey)
	nP2 = length(parameterarray)
	nPo = length(optparameterkey)
	if nP2 == nPo
		return parameterarray
	elseif nP > nPo
		@assert nP2 == nP
		parameterarraynew = Array{Float64}(undef, nPo)
		j = 1
		for i in 1:nP
			if optparameterkey[j] == parameterkey[i]
				parameterarraynew[j] = parameterarray[i]
				j += 1
				if j > nPo
					break
				end
			end
		end
		return parameterarraynew
	else
		return parameterarray
	end
end

@doc """
Get optimizable parameters

$(DocumentFunction.documentfunction(getoptparams;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "parameterarray"=>"parameter array",
            "optparameterkey"=>"optimizable parameter keys")))

Returns:

- parameter array
""" getoptparams

"""
Is parameter with key `parameterkey` optimizable?

$(DocumentFunction.documentfunction(isopt;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "parameterkey"=>"parameter key")))

Returns:

- `true` if optimizable, `false` if not
"""
function isopt(madsdata::AbstractDict, parameterkey::String)
	if haskey(madsdata, "Parameters") && haskey(madsdata["Parameters"], parameterkey) &&
		(!haskey(madsdata["Parameters"][parameterkey], "type") || haskey(madsdata["Parameters"][parameterkey], "type") && madsdata["Parameters"][parameterkey]["type"] == "opt")
		return true
	else
		return false
	end
end

"""
Is parameter with key `parameterkey` log-transformed?

$(DocumentFunction.documentfunction(islog;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "parameterkey"=>"parameter key")))

Returns:

- `true` if log-transformed, `false` otherwise
"""
function islog(madsdata::AbstractDict, parameterkey::String)
	if haskey(madsdata["Parameters"][parameterkey], "log") && madsdata["Parameters"][parameterkey]["log"] == true
		return true
	else
		return false
	end
end

"""
Set all parameters ON

$(DocumentFunction.documentfunction(setallparamson!;
argtext=Dict("madsdata"=>"MADS problem dictionary"),
keytext=Dict("filter"=>"parameter filter")))
"""
function setallparamson!(madsdata::AbstractDict; filter::String="")
	paramkeys = getparamkeys(madsdata; filter=filter)
	for k in paramkeys
		madsdata["Parameters"][k]["type"] = "opt"
	end
end

"""
Set all parameters OFF

$(DocumentFunction.documentfunction(setallparamsoff!;
argtext=Dict("madsdata"=>"MADS problem dictionary"),
keytext=Dict("filter"=>"parameter filter")))
"""
function setallparamsoff!(madsdata::AbstractDict; filter::String="")
	paramkeys = getparamkeys(madsdata; filter=filter)
	for k in paramkeys
		madsdata["Parameters"][k]["type"] = nothing
	end
end

"""
Set a specific parameter with a key `parameterkey` ON

$(DocumentFunction.documentfunction(setparamon!;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "parameterkey"=>"parameter key")))
"""
function setparamon!(madsdata::AbstractDict, parameterkey::String)
	madsdata["Parameters"][parameterkey]["type"] = "opt";
end

"""
Set a specific parameter with a key `parameterkey` OFF

$(DocumentFunction.documentfunction(setparamoff!;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "parameterkey"=>"parameter key")))
"""
function setparamoff!(madsdata::AbstractDict, parameterkey::String)
	madsdata["Parameters"][parameterkey]["type"] = nothing
end

"""
Set normal parameter distributions for all the model parameters in the MADS problem dictionary

$(DocumentFunction.documentfunction(setparamsdistnormal!;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "mean"=>"array with the mean values",
            "stddev"=>"array with the standard deviation values")))
"""
function setparamsdistnormal!(madsdata::AbstractDict, mean::Vector, stddev::Vector)
	paramkeys = getparamkeys(madsdata)
	for i = 1:length(paramkeys)
		madsdata["Parameters"][paramkeys[i]]["dist"] = "Normal($(mean[i]),$(stddev[i]))"
	end
end

"""
Set uniform parameter distributions for all the model parameters in the MADS problem dictionary

$(DocumentFunction.documentfunction(setparamsdistuniform!;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "min"=>"array with the minimum values",
            "max"=>"array with the maximum values")))
"""
function setparamsdistuniform!(madsdata::AbstractDict, min::Vector, max::Vector)
	paramkeys = getparamkeys(madsdata)
	for i = 1:length(paramkeys)
		madsdata["Parameters"][paramkeys[i]]["dist"] = "Uniform($(min[i]),$(max[i]))"
	end
end

# Make functions to get parameter keys for specific MADS parameters (optimized and log-transformed)
getfunction = [getparamstype, getparamslog]
keywordname = ["opt", "log"]
funcname = ["optimized", "log-transformed"]
keywordvalsNOT = [nothing, false]
global index = 0
for i = 1:length(getfunction)
	global index = i
	q = quote
		"""
		Get the keys in the MADS problem dictionary for parameters that are $(funcname[index]) (`$(keywordname[index])`)
		"""
		function $(Symbol(string("get", keywordname[index], "paramkeys")))(madsdata::AbstractDict, paramkeys::Vector) # create functions getoptparamkeys / getlogparamkeys
			paramtypes = $(getfunction[index])(madsdata, paramkeys)
			return paramkeys[paramtypes .!= $(keywordvalsNOT[index])]
		end
		function $(Symbol(string("get", keywordname[index], "paramkeys")))(madsdata::AbstractDict)
			paramkeys = getparamkeys(madsdata)
			return $(Symbol(string("get", keywordname[index], "paramkeys")))(madsdata, paramkeys::Vector)
		end
		"""
		Get the keys in the MADS problem dictionary for parameters that are NOT $(funcname[index]) (`$(keywordname[index])`)
		"""
		function $(Symbol(string("getnon", keywordname[index], "paramkeys")))(madsdata::AbstractDict, paramkeys::Vector) # create functions getnonoptparamkeys / getnonlogparamkeys
			paramtypes = $(getfunction[index])(madsdata, paramkeys)
			return paramkeys[paramtypes .== $(keywordvalsNOT[index])]
		end
		function $(Symbol(string("getnon", keywordname[index], "paramkeys")))(madsdata::AbstractDict)
			paramkeys = getparamkeys(madsdata)
			return $(Symbol(string("getnon", keywordname[index], "paramkeys")))(madsdata, paramkeys)
		end
	end
	Core.eval(Mads, q)
end

"""
Show parameters in the MADS problem dictionary

$(DocumentFunction.documentfunction(showparameters;
argtext=Dict("madsdata"=>"MADS problem dictionary")))
"""
function showparameters(madsdata::AbstractDict)
	pardict = madsdata["Parameters"]
	parkeys = Mads.getoptparamkeys(madsdata)
	p = Array{String}(undef, 0)
	for parkey in parkeys
		if haskey(pardict[parkey], "longname" )
			s = @Printf.sprintf "%-30s : " pardict[parkey]["longname"]
		else
			s = ""
		end
		s *= @Printf.sprintf "%-20s = %15g " parkey pardict[parkey]["init"]
		if haskey(pardict[parkey], "log" ) && pardict[parkey]["log"] == true
			s *= @Printf.sprintf "log-transformed "
		end
		if haskey(pardict[parkey], "min" )
			s *= @Printf.sprintf "min = %s " pardict[parkey]["min"]
		end
		if haskey(pardict[parkey], "max" )
			s *= @Printf.sprintf "max = %s " pardict[parkey]["max"]
		end
		if haskey(pardict[parkey], "dist" )
			s *= @Printf.sprintf "distribution = %s " pardict[parkey]["dist"]
		end
		s *= "\n"
		push!(p, s)
	end
	print(p...)
	println("Number of parameters is $(length(p))")
end

"""
Show all parameters in the MADS problem dictionary

$(DocumentFunction.documentfunction(showallparameters;
argtext=Dict("madsdata"=>"MADS problem dictionary")))
"""
function showallparameters(madsdata::AbstractDict)
	pardict = madsdata["Parameters"]
	parkeys = Mads.getparamkeys(madsdata)
	p = Array{String}(undef, 0)
	for parkey in parkeys
		if haskey(pardict[parkey], "longname")
			s = @Printf.sprintf "%-30s : " pardict[parkey]["longname"]
		else
			s = ""
		end
		s *= @Printf.sprintf "%-20s = %15g " parkey pardict[parkey]["init"]
		if haskey(pardict[parkey], "type")
			if pardict[parkey]["type"] != nothing
				s *= "<- optimizable "
			else
				s *= "<- fixed "
			end
		else
			s *= "<- optimizable "
		end
		if haskey(pardict[parkey], "log" ) && pardict[parkey]["log"] == true
			s *= @Printf.sprintf "log-transformed "
		end
		if haskey(pardict[parkey], "min")
			s *= @Printf.sprintf "min = %s " pardict[parkey]["min"]
		end
		if haskey(pardict[parkey], "max")
			s *= @Printf.sprintf "max = %s " pardict[parkey]["max"]
		end
		if haskey(pardict[parkey], "dist")
			s *= @Printf.sprintf "distribution = %s " pardict[parkey]["dist"]
		end
		s *= "\n"
		push!(p, s)
	end
	print(p...)
	println("Number of parameters is $(length(p))")
end

"""
Get probabilistic distributions of all parameters in the MADS problem dictionary

Note:

Probabilistic distribution of parameters can be defined only if `dist` or `min`/`max` model parameter fields are specified in the MADS problem dictionary `madsdata`.

$(DocumentFunction.documentfunction(getparamdistributions;
argtext=Dict("madsdata"=>"MADS problem dictionary"),
keytext=Dict("init_dist"=>"if `true` use the distribution defined for initialization in the MADS problem dictionary (defined using `init_dist` parameter field); else use the regular distribution defined in the MADS problem dictionary (defined using `dist` parameter field [default=`false`]")))

Returns:

- probabilistic distributions
"""
function getparamdistributions(madsdata::AbstractDict; init_dist::Bool=false)
	paramkeys = getoptparamkeys(madsdata)
	distributions = OrderedCollections.OrderedDict()
	for i in 1:length(paramkeys)
		p = madsdata["Parameters"][paramkeys[i]]
		if init_dist
			if haskey(p, "init_dist")
				distributions[paramkeys[i]] = Mads.getdistribution(p["init_dist"], paramkeys[i], "parameter")
				continue
			elseif haskey(p, "dist")
				distributions[paramkeys[i]] = Mads.getdistribution(p["dist"], paramkeys[i], "parameter")
				continue
			else
				minkey = haskey(p, "init_min") ? "init_dist" : "min"
				maxkey = haskey(p, "init_max") ? "init_dist" : "max"
			end
		else
			if haskey(p, "dist")
				distributions[paramkeys[i]] = Mads.getdistribution(p["dist"], paramkeys[i], "parameter")
				continue
			else
				minkey = "min"
				maxkey = "max"
			end
		end
		if haskey(p, minkey ) && haskey(p, maxkey )
			min = p[minkey]
			max = p[maxkey]
			if(min > max)
				madserror("Min/max for parameter `$(paramkeys[i])` are messed up (min = $min; max = $max)!")
			end
			distributions[paramkeys[i]] = Distributions.Uniform(min, max)
		else
			madserror("""Probabilistic distribution of parameter `$(paramkeys[i])` is not defined; "dist" or "min"/"max" are missing!""")
		end
	end
	return distributions
end

"""
Check parameter ranges for model parameters

$(DocumentFunction.documentfunction(checkparameterranges;
argtext=Dict("madsdata"=>"MADS problem dictionary")))
"""
function checkparameterranges(madsdata::AbstractDict)
	if !haskey(madsdata, "Parameters")
		return
	end
	paramkeys = Mads.getparamkeys(madsdata)
	optparamkeys = Mads.getoptparamkeys(madsdata)
	init = Mads.getparamsinit(madsdata)
	min = Mads.getparamsmin(madsdata)
	max = Mads.getparamsmax(madsdata)
	init_min = Mads.getparamsinit_min(madsdata)
	init_max = Mads.getparamsinit_max(madsdata)
	flag_error = false
	d = init - min .< 0
	if any(d)
		for i in findall(d)
			madswarn("Parameter `$(paramkeys[i])` initial value is less than the minimum (init = $(init[i]); min = $(min[i]))!")
			if findfirst(optparamkeys, paramkeys[i]) > 0
				flag_error = true
			end
		end
	end
	d = max - init .< 0
	if any(d)
		for i in findall(d)
			madswarn("Parameter `$(paramkeys[i])` initial value is greater than the maximum (init = $(init[i]); max = $(max[i]))!")
			if findfirst(optparamkeys, paramkeys[i]) > 0
				flag_error = true
			end
		end
	end
	d = max - min .< 0
	if any(d)
		for i in findall(d)
			madswarn("Parameter `$(paramkeys[i])` maximum is less than the minimum (max = $(max[i]); min = $(min[i]))!")
			if findfirst(optparamkeys, paramkeys[i]) > 0
				flag_error = true
			end
		end
	end
	d = init_max - init_min .< 0
	if any(d)
		for i in findall(d)
			madswarn("Parameter `$(paramkeys[i])` initialization maximum is less than the initialization minimum (init_max = $(init_max[i]); init_min = $(init_min[i]))!")
		end
	end
	d = init_min - min .< 0
	if any(d)
		for i in findall(d)
			madswarn("Parameter `$(paramkeys[i])` initialization minimum is less than the minimum (init_min = $(init_min[i]); min = $(min[i]))!")
		end
	end
	d = max - init_max .< 0
	if any(d)
		for i in findall(d)
			madswarn("Parameter `$(paramkeys[i])` initialization maximum is greater than the maximum (init_max = $(init_max[i]); max = $(min[i]))!")
		end
	end
	if flag_error
		madserror("Parameter ranges are incorrect!")
	end
end

function boundparameters!(madsdata::AbstractDict, parvec::Vector)
	if !haskey(madsdata, "Parameters")
		return
	end
	parmin = Mads.getparamsmin(madsdata)
	parmax = Mads.getparamsmax(madsdata)
	i = par .> parmax
	par[i] .= parmax[i]
	i = par .< parmin
	par[i] .= parmin[i]
	return nothing
end
function boundparameters!(madsdata::AbstractDict, pardict::AbstractDict)
	if !haskey(madsdata, "Parameters")
		return
	end
	parkeys = getparamkeys(madsdata)
	parmin = Mads.getparamsmin(madsdata, parkeys)
	parmax = Mads.getparamsmax(madsdata, parkeys)
	for (i, k) in enumerate(parkeys)
		if pardict[k] > parmax[i]
			pardict[k] = parmax[i]
		elseif pardict[k] < parmin[i]
			pardict[k] = parmin[i]
		end
	end
	return nothing
end

@doc """
Bound model parameters based on their ranges

$(DocumentFunction.documentfunction(boundparameters!;
argtext=Dict("madsdata"=>"MADS problem dictionary","parvec"=>"Parameter vector","pardict"=>"Parameter dictionary")))
""" boundparameters!