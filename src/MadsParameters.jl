import Distributions
import DataStructures

"Is the dictionary containing all the parameters"
function isparam(madsdata::Associative, dict::Associative)
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
Get keys of all parameters in the MADS dictionary

`Mads.getparamkeys(madsdata)`

Arguments:

- `madsdata` : MADS problem dictionary

Returns:

- `paramkeys` : array with the keys of all parameters in the MADS dictionary
"""
function getparamkeys(madsdata::Associative; filter::String="")
	if haskey(madsdata, "Parameters")
		return collect(filterkeys(madsdata["Parameters"], filter))
	end
end

"""
Get dictionary with all parameters and their respective initial values

`Mads.getparamdict(madsdata)`

Arguments:

- `madsdata` : MADS problem dictionary

Returns:

- `paramdict` : dictionary with all parameters and their respective initial values
"""
function getparamdict(madsdata::Associative)
	if haskey(madsdata, "Parameters")
		paramkeys = Mads.getparamkeys(madsdata)
		paramdict = DataStructures.OrderedDict(zip(paramkeys, map(key->madsdata["Parameters"][key]["init"], paramkeys)))
		return paramdict
	end
end

"""
Get keys of all source parameters in the MADS dictionary

`Mads.getsourcekeys(madsdata)`

Arguments:

- `madsdata` : MADS problem dictionary

Returns:

- `sourcekeys` : array with keys of all source parameters in the MADS dictionary
"""
function getsourcekeys(madsdata::Associative)
	sourcekeys = Array(String, 0)
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
index = 0
for i = 1:length(getparamsnames)
	paramname = getparamsnames[i]
	paramtype = getparamstypes[i]
	paramdefault = getparamsdefault[i]
	paramlogdefault = getparamslogdefault[i]
	index = i
	q = quote
		@doc "Get an array with `$(getparamsnames[index])` values for parameters defined by `paramkeys`" ->
		function $(Symbol(string("getparams", paramname)))(madsdata::Associative, paramkeys::Vector) # create a function to get each parameter name with 2 arguments
			paramvalue = Array($(paramtype), length(paramkeys))
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
		@doc "Get an array with `$(getparamsnames[index])` values for all the MADS model parameters" ->
		function $(Symbol(string("getparams", paramname)))(madsdata::Associative) # create a function to get each parameter name with 1 argument
			paramkeys = Mads.getparamkeys(madsdata) # get parameter keys
			return $(Symbol(string("getparams", paramname)))(madsdata::Associative, paramkeys) # call the function with 2 arguments
		end
	end
	eval(q)
end

"Get an array with `min` values for parameters defined by `paramkeys`"
function getparamsmin(madsdata::Associative, paramkeys::Vector)
	paramvalue = Array(Float64, length(paramkeys))
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
"Get an array with `min` values for all the MADS model parameters"
function getparamsmin(madsdata::Associative)
	paramkeys = getparamkeys(madsdata)
	return getparamsmin(madsdata, paramkeys)
end

"Get an array with `max` values for parameters defined by `paramkeys`"
function getparamsmax(madsdata::Associative, paramkeys::Vector)
	paramvalue = Array(Float64, length(paramkeys))
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
"Get an array with `min` values for all the MADS model parameters"
function getparamsmax(madsdata::Associative)
	paramkeys = getparamkeys(madsdata)
	return getparamsmax(madsdata, paramkeys)
end

"Get an array with `init_min` values for parameters defined by `paramkeys`"
function getparamsinit_min(madsdata::Associative, paramkeys::Vector)
	paramvalue = Array(Float64, length(paramkeys))
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
"Get an array with `init_min` values for all the MADS model parameters"
function getparamsinit_min(madsdata::Associative)
	paramkeys = getparamkeys(madsdata)
	return getparamsinit_min(madsdata, paramkeys)
end

"Get an array with `init_max` values for parameters defined by `paramkeys`"
function getparamsinit_max(madsdata::Associative, paramkeys::Vector)
	paramvalue = Array(Float64, length(paramkeys))
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
"Get an array with `init_max` values for all the MADS model parameters"
function getparamsinit_max(madsdata::Associative)
	paramkeys = getparamkeys(madsdata)
	return getparamsinit_max(madsdata, paramkeys)
end

"""
Set initial parameter guesses in the MADS dictionary

`Mads.setparamsinit!(madsdata, paramdict)`

Arguments:

- `madsdata` : MADS problem dictionary
- `paramdict` : dictionary with initial model parameter values
"""
function setparamsinit!(madsdata::Associative, paramdict::Associative)
	paramkeys = getparamkeys(madsdata)
	for i in 1:length(paramkeys)
		madsdata["Parameters"][paramkeys[i]]["init"] = paramdict[paramkeys[i]]
	end
end

"Get optimizable parameters"
function getoptparams(madsdata::Associative)
	getoptparams(madsdata, getparamsinit(madsdata), getoptparamkeys(madsdata))
end
function getoptparams(madsdata::Associative, parameterarray::Array, optparameterkey::Array=[])
	if length(optparameterkey) == 0
		optparameterkey = getoptparamkeys(madsdata)
	end
	parameterkey = getparamkeys(madsdata)
	nP = length(parameterkey)
	nPo = length(optparameterkey)
	if nP > nPo
		parameterarraynew = Array(Float64, nPo)
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

"Is parameter with key `parameterkey` optimizable?"
function isopt(madsdata::Associative, parameterkey::String)
	if !haskey(madsdata["Parameters"][parameterkey], "type") ||
		haskey(madsdata["Parameters"][parameterkey], "type") && madsdata["Parameters"][parameterkey]["type"] == "opt"
		return true
	else
		return false
	end
end

"Is parameter with key `parameterkey` log-transformed?"
function islog(madsdata::Associative, parameterkey::String)
	if haskey(madsdata["Parameters"][parameterkey], "log") && madsdata["Parameters"][parameterkey]["log"] == true
		return true
	else
		return false
	end
end

"Set all parameters ON"
function setallparamson!(madsdata::Associative; filter::String="")
	paramkeys = getparamkeys(madsdata; filter=filter)
	for i in 1:length(paramkeys)
		madsdata["Parameters"][paramkeys[i]]["type"] = "opt"
	end
end

"Set all parameters OFF"
function setallparamsoff!(madsdata::Associative; filter::String="")
	paramkeys = getparamkeys(madsdata; filter=filter)
	for i in 1:length(paramkeys)
		madsdata["Parameters"][paramkeys[i]]["type"] = nothing
	end
end

"Set a specific parameter with a key `parameterkey` ON"
function setparamon!(madsdata::Associative, parameterkey::String)
	madsdata["Parameters"][parameterkey]["type"] = "opt";
end

"Set a specific parameter with a key `parameterkey` OFF"
function setparamoff!(madsdata::Associative, parameterkey::String)
	madsdata["Parameters"][parameterkey]["type"] = nothing
end

"""
Set normal parameter distributions for all the model parameters in the MADS problem dictionary

`Mads.setparamsdistnormal!(madsdata, mean, stddev)`

Arguments:

- `madsdata` : MADS problem dictionary
- `mean` : array with the mean values
- `stddev` : array with the standard deviation values
"""
function setparamsdistnormal!(madsdata::Associative, mean::Vector, stddev::Vector)
	paramkeys = getparamkeys(madsdata)
	for i in 1:length(paramkeys)
		madsdata["Parameters"][paramkeys[i]]["dist"] = "Normal($(mean[i]),$(stddev[i]))"
	end
end

"""
Set uniform parameter distributions for all the model parameters in the MADS problem dictionary

`Mads.setparamsdistuniform!(madsdata, min, max)`

Arguments:

- `madsdata` : MADS problem dictionary
- `min` : array with the minimum values
- `max` : array with the maximum values
"""
function setparamsdistuniform!(madsdata::Associative, min::Vector, max::Vector)
	paramkeys = getparamkeys(madsdata)
	for i in 1:length(paramkeys)
		madsdata["Parameters"][paramkeys[i]]["dist"] = "Uniform($(min[i]),$(max[i]))"
	end
end

# Make functions to get parameter keys for specific MADS parameters (optimized and log-transformed)
getfunction = [getparamstype, getparamslog]
keywordname = ["opt", "log"]
funcname = ["optimized", "log-transformed"]
keywordvalsNOT = [nothing, false]
index = 0
for i = 1:length(getfunction)
	index = i
	q = quote
		@doc "Get the keys in the MADS problem dictionary for parameters that are $(funcname[index]) (`$(keywordname[index])`)" ->
		function $(Symbol(string("get", keywordname[i], "paramkeys")))(madsdata::Associative, paramkeys::Vector) # create functions getoptparamkeys / getlogparamkeys
			paramtypes = $(getfunction[i])(madsdata, paramkeys)
			return paramkeys[paramtypes .!= $(keywordvalsNOT[i])]
		end
		function $(Symbol(string("get", keywordname[i], "paramkeys")))(madsdata::Associative)
			paramkeys = getparamkeys(madsdata)
			return $(Symbol(string("get", keywordname[i], "paramkeys")))(madsdata, paramkeys::Vector)
		end
		@doc "Get the keys in the MADS problem dictionary for parameters that are NOT $(funcname[index]) (`$(keywordname[index])`)" ->
		function $(Symbol(string("getnon", keywordname[i], "paramkeys")))(madsdata::Associative, paramkeys::Vector) # create functions getnonoptparamkeys / getnonlogparamkeys
			paramtypes = $(getfunction[i])(madsdata, paramkeys)
			return paramkeys[paramtypes .== $(keywordvalsNOT[i])]
		end
		function $(Symbol(string("getnon", keywordname[i], "paramkeys")))(madsdata::Associative)
			paramkeys = getparamkeys(madsdata)
			return $(Symbol(string("getnon", keywordname[i], "paramkeys")))(madsdata, paramkeys)
		end
	end
	eval(q)
end

"Show optimizable parameters in the MADS problem dictionary"
function showparameters(madsdata::Associative)
	pardict = madsdata["Parameters"]
	parkeys = Mads.getoptparamkeys(madsdata)
	p = Array(String, 0)
	for parkey in parkeys
		if haskey(pardict[parkey], "longname" )
			s = @sprintf "%-30s : " pardict[parkey]["longname"]
		else
			s = ""
		end
		s *= @sprintf "%-10s = %15g " parkey pardict[parkey]["init"]
		if haskey(pardict[parkey], "log" ) && pardict[parkey]["log"] == true
			s *= @sprintf "log-transformed "
		end
		if haskey(pardict[parkey], "min" )
			s *= @sprintf "min = %s " pardict[parkey]["min"]
		end
		if haskey(pardict[parkey], "max" )
			s *= @sprintf "max = %s " pardict[parkey]["max"]
		end
		if haskey(pardict[parkey], "dist" )
			s *= @sprintf "distribution = %s " pardict[parkey]["dist"]
		end
		s *= "\n"
		push!(p, s)
	end
	print(p...)
	println("Number of parameters is $(length(p))")
end

"Show all parameters in the MADS problem dictionary"
function showallparameters(madsdata::Associative)
	pardict = madsdata["Parameters"]
	parkeys = Mads.getparamkeys(madsdata)
	p = Array(String, 0)
	for parkey in parkeys
		if haskey(pardict[parkey], "longname")
			s = @sprintf "%-30s : " pardict[parkey]["longname"]
		else
			s = ""
		end
		s *= @sprintf "%-10s = %15g " parkey pardict[parkey]["init"]
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
			s *= @sprintf "log-transformed "
		end
		if haskey(pardict[parkey], "min")
			s *= @sprintf "min = %s " pardict[parkey]["min"]
		end
		if haskey(pardict[parkey], "max")
			s *= @sprintf "max = %s " pardict[parkey]["max"]
		end
		if haskey(pardict[parkey], "dist")
			s *= @sprintf "distribution = %s " pardict[parkey]["dist"]
		end
		s *= "\n"
		push!(p, s)
	end
	print(p...)
	println("Number of parameters is $(length(p))")
end

"""
Get probabilistic distributions of all parameters in the MADS problem dictionary

`Mads.getparamdistributions(madsdata; init_dist=false)`

Note:

Probabilistic distribution of parameters can be defined only if `dist` or `min`/`max` model parameter fields are specified in the MADS problem dictionary `madsdata`.

Arguments:

- `madsdata` : MADS problem dictionary
- `init_dist` : if `true` use the distribution defined for initialization in the MADS problem dictionary (defined using `init_dist` parameter field); else use the regular distribution defined in the MADS problem dictionary (defined using `dist` parameter field)
"""
function getparamdistributions(madsdata::Associative; init_dist::Bool=false)
	paramkeys = getoptparamkeys(madsdata)
	distributions = DataStructures.OrderedDict()
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

"Check parameter ranges for model parameters"
function checkparameterranges(madsdata::Associative)
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
		for i in find(d)
			madswarn("Parameter `$(paramkeys[i])` initial value is less than the minimum (init = $(init[i]); min = $(min[i]))!")
			if findfirst(optparamkeys, paramkeys[i]) > 0
				flag_error = true
			end
		end
	end
	d = max - init .< 0
	if any(d)
		for i in find(d)
			madswarn("Parameter `$(paramkeys[i])` initial value is greater than the maximum (init = $(init[i]); max = $(max[i]))!")
			if findfirst(optparamkeys, paramkeys[i]) > 0
				flag_error = true
			end
		end
	end
	d = max - min .< 0
	if any(d)
		for i in find(d)
			madswarn("Parameter `$(paramkeys[i])` maximum is less than the minimum (max = $(max[i]); min = $(min[i]))!")
			if findfirst(optparamkeys, paramkeys[i]) > 0
				flag_error = true
			end
		end
	end
	d = init_max - init_min .< 0
	if any(d)
		for i in find(d)
			madswarn("Parameter `$(paramkeys[i])` initialization maximum is less than the initialization minimum (init_max = $(init_max[i]); init_min = $(init_min[i]))!")
		end
	end
	d = init_min - min .< 0
	if any(d)
		for i in find(d)
			madswarn("Parameter `$(paramkeys[i])` initialization minimum is less than the minimum (init_min = $(init_min[i]); min = $(min[i]))!")
		end
	end
	d = max - init_max .< 0
	if any(d)
		for i in find(d)
			madswarn("Parameter `$(paramkeys[i])` initialization maximum is greater than the maximum (init_max = $(init_max[i]); max = $(min[i]))!")
		end
	end
	if flag_error
		madserror("Parameter ranges are incorrect!")
	end
end
