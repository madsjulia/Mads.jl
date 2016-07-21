import Distributions
import DataStructures

"Is the dictionary containing all the parameters"
function isparam(madsdata::Associative, dict::Associative)
	flag = true
	par = getparamkeys(madsdata)
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
function getparamkeys(madsdata::Associative; filter="")
	if haskey( madsdata, "Parameters" )
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
	if haskey( madsdata, "Parameters" )
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
	sourcekeys = Array(ASCIIString, 0)
	if haskey( madsdata, "Sources" )
		for i = 1:length(madsdata["Sources"])
			for k = keys(madsdata["Sources"][1])
				sk = collect(ASCIIString, keys(madsdata["Sources"][i][k]))
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
getparamstypes = [Float64, Any, Any, Float64, AbstractString, AbstractString]
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
		function $(symbol(string("getparams", paramname)))(madsdata, paramkeys) # create a function to get each parameter name with 2 arguments
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
		function $(symbol(string("getparams", paramname)))(madsdata) # create a function to get each parameter name with 1 argument
			paramkeys = Mads.getparamkeys(madsdata) # get parameter keys
			return $(symbol(string("getparams", paramname)))(madsdata, paramkeys) # call the function with 2 arguments
		end
	end
	eval(q)
end

"Get an array with `min` values for parameters defined by `paramkeys`"
function getparamsmin(madsdata, paramkeys)
	paramvalue = Array(Float64, length(paramkeys))
	for i in 1:length(paramkeys)
		if haskey( madsdata["Parameters"][paramkeys[i]], "min")
			paramvalue[i] = madsdata["Parameters"][paramkeys[i]]["min"]
		else
			if haskey( madsdata["Parameters"][paramkeys[i]], "dist")
				distribution = Distributions.eval(parse(madsdata["Parameters"][paramkeys[i]]["dist"]))
				if typeof(distribution) == Distributions.Uniform
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
	end
	return paramvalue # returns the parameter values
end
"Get an array with `min` values for all the MADS model parameters"
function getparamsmin(madsdata)
	paramkeys = getparamkeys(madsdata)
	return getparamsmin(madsdata, paramkeys)
end

"Get an array with `max` values for parameters defined by `paramkeys`"
function getparamsmax(madsdata, paramkeys)
	paramvalue = Array(Float64, length(paramkeys))
	for i in 1:length(paramkeys)
		if haskey( madsdata["Parameters"][paramkeys[i]], "max")
			paramvalue[i] = madsdata["Parameters"][paramkeys[i]]["max"]
		else
			if haskey( madsdata["Parameters"][paramkeys[i]], "dist")
				distribution = Distributions.eval(parse(madsdata["Parameters"][paramkeys[i]]["dist"]))
				if typeof(distribution) == Distributions.Uniform
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
	end
	return paramvalue # returns the parameter values
end
"Get an array with `min` values for all the MADS model parameters"
function getparamsmax(madsdata)
	paramkeys = getparamkeys(madsdata)
	return getparamsmax(madsdata, paramkeys)
end

"Get an array with `init_min` values for parameters defined by `paramkeys`"
function getparamsinit_min(madsdata, paramkeys)
	paramvalue = Array(Float64, length(paramkeys))
	for i in 1:length(paramkeys)
		if haskey( madsdata["Parameters"][paramkeys[i]], "init_min")
			paramvalue[i] = madsdata["Parameters"][paramkeys[i]]["init_min"]
			continue
		end
		if haskey( madsdata["Parameters"][paramkeys[i]], "init_dist")
			distribution = Distributions.eval(parse(madsdata["Parameters"][paramkeys[i]]["init_dist"]))
			if typeof(distribution) == Distributions.Uniform
				paramvalue[i] = distribution.a
				continue
			end
		end
		if haskey( madsdata["Parameters"][paramkeys[i]], "min")
			paramvalue[i] = madsdata["Parameters"][paramkeys[i]]["min"]
			continue
		end
		if haskey( madsdata["Parameters"][paramkeys[i]], "dist")
			distribution = Distributions.eval(parse(madsdata["Parameters"][paramkeys[i]]["dist"]))
			if typeof(distribution) == Distributions.Uniform
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
function getparamsinit_min(madsdata)
	paramkeys = getparamkeys(madsdata)
	return getparamsinit_min(madsdata, paramkeys)
end

"Get an array with `init_max` values for parameters defined by `paramkeys`"
function getparamsinit_max(madsdata, paramkeys)
	paramvalue = Array(Float64, length(paramkeys))
	for i in 1:length(paramkeys)
		if haskey( madsdata["Parameters"][paramkeys[i]], "init_max")
			paramvalue[i] = madsdata["Parameters"][paramkeys[i]]["init_max"]
			continue
		end
		if haskey( madsdata["Parameters"][paramkeys[i]], "init_dist")
			distribution = Distributions.eval(parse(madsdata["Parameters"][paramkeys[i]]["init_dist"]))
			if typeof(distribution) == Distributions.Uniform
				paramvalue[i] = distribution.b
				continue
			end
		end
		if haskey( madsdata["Parameters"][paramkeys[i]], "max")
			paramvalue[i] = madsdata["Parameters"][paramkeys[i]]["max"]
			continue
		end
		if haskey( madsdata["Parameters"][paramkeys[i]], "dist")
			distribution = Distributions.eval(parse(madsdata["Parameters"][paramkeys[i]]["dist"]))
			if typeof(distribution) == Distributions.Uniform
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
function getparamsinit_max(madsdata)
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

"Get optimizable parameters", 
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
function isopt(madsdata::Associative, parameterkey::AbstractString)
	if !haskey(madsdata["Parameters"][parameterkey], "type") || 
		haskey(madsdata["Parameters"][parameterkey], "type") && madsdata["Parameters"][parameterkey]["type"] == "opt"
		return true
	else
		return false
	end
end

"Is parameter with key `parameterkey` log-transformed?"
function islog(madsdata::Associative, parameterkey::AbstractString)
	if haskey(madsdata["Parameters"][parameterkey], "log") && madsdata["Parameters"][parameterkey]["log"] == true
		return true
	else
		return false
	end
end

"Set all parameters ON"
function setallparamson!(madsdata::Associative; filter="")
	paramkeys = getparamkeys(madsdata; filter=filter)
	for i in 1:length(paramkeys)
		madsdata["Parameters"][paramkeys[i]]["type"] = "opt"
	end
end

"Set all parameters OFF"
function setallparamsoff!(madsdata::Associative; filter="")
	paramkeys = getparamkeys(madsdata; filter=filter)
	for i in 1:length(paramkeys)
		madsdata["Parameters"][paramkeys[i]]["type"] = nothing
	end
end

"Set a specific parameter with a key `parameterkey` ON"
function setparamon!(madsdata::Associative, parameterkey::AbstractString)
		madsdata["Parameters"][parameterkey]["type"] = "opt";
end

"Set a specific parameter with a key `parameterkey` OFF"
function setparamoff!(madsdata::Associative, parameterkey)
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
function setparamsdistnormal!(madsdata::Associative, mean, stddev)
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
function setparamsdistuniform!(madsdata::Associative, min, max)
	paramkeys = getparamkeys(madsdata)
	for i in 1:length(paramkeys)
		madsdata["Parameters"][paramkeys[i]]["dist"] = "Distributions.Uniform($(min[i]),$(max[i]))"
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
		function $(symbol(string("get", keywordname[i], "paramkeys")))(madsdata, paramkeys) # create functions getoptparamkeys / getlogparamkeys
			paramtypes = $(getfunction[i])(madsdata, paramkeys)
			return paramkeys[paramtypes .!= $(keywordvalsNOT[i])]
		end
		function $(symbol(string("get", keywordname[i], "paramkeys")))(madsdata)
			paramkeys = getparamkeys(madsdata)
			return $(symbol(string("get", keywordname[i], "paramkeys")))(madsdata, paramkeys)
		end
		@doc "Get the keys in the MADS problem dictionary for parameters that are NOT $(funcname[index]) (`$(keywordname[index])`)" ->
		function $(symbol(string("getnon", keywordname[i], "paramkeys")))(madsdata, paramkeys) # create functions getnonoptparamkeys / getnonlogparamkeys
			paramtypes = $(getfunction[i])(madsdata, paramkeys)
			return paramkeys[paramtypes .== $(keywordvalsNOT[i])]
		end
		function $(symbol(string("getnon", keywordname[i], "paramkeys")))(madsdata)
			paramkeys = getparamkeys(madsdata)
			return $(symbol(string("getnon", keywordname[i], "paramkeys")))(madsdata, paramkeys)
		end
	end
	eval(q)
end

"Show optimizable parameters in the MADS problem dictionary"
function showparameters(madsdata::Associative)
	pardict = madsdata["Parameters"]
	parkeys = Mads.getoptparamkeys(madsdata)
	p = Array(ASCIIString, 0)
	for parkey in parkeys
		if haskey( pardict[parkey], "longname" )
			s = @sprintf "%-30s : " pardict[parkey]["longname"]
		else
			s = ""
		end
		s *= @sprintf "%-10s = %15g " parkey pardict[parkey]["init"]
		if haskey( pardict[parkey], "log" ) && pardict[parkey]["log"] == true
			s *= @sprintf "log-transformed "
		end
		if haskey( pardict[parkey], "min" )
			s *= @sprintf "min = %s " pardict[parkey]["min"]
		end
		if haskey( pardict[parkey], "max" )
			s *= @sprintf "max = %s " pardict[parkey]["max"]
		end
		if haskey( pardict[parkey], "dist" )
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
	p = Array(ASCIIString, 0)
	for parkey in parkeys
		if haskey( pardict[parkey], "longname" )
			s = @sprintf "%-30s : " pardict[parkey]["longname"]
		else
			s = ""
		end
		s *= @sprintf "%-10s = %15g " parkey pardict[parkey]["init"]
		if haskey( pardict[parkey], "type" ) 
			if pardict[parkey]["type"] != nothing
				s *= "<- optimizable "
			else
				s *= "<- fixed "
			end
		else
			s *= "<- optimizable "
		end
		if haskey( pardict[parkey], "log" ) && pardict[parkey]["log"] == true
			s *= @sprintf "log-transformed "
		end
		if haskey( pardict[parkey], "min" )
			s *= @sprintf "min = %s " pardict[parkey]["min"]
		end
		if haskey( pardict[parkey], "max" )
			s *= @sprintf "max = %s " pardict[parkey]["max"]
		end
		if haskey( pardict[parkey], "dist" )
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
function getparamdistributions(madsdata::Associative; init_dist=false)
	paramkeys = getoptparamkeys(madsdata)
	distributions = DataStructures.OrderedDict()
	for i in 1:length(paramkeys)
		if init_dist
			if haskey(madsdata["Parameters"][paramkeys[i]], "init_dist")
				distributions[paramkeys[i]] = Distributions.eval(parse(madsdata["Parameters"][paramkeys[i]]["init_dist"]))
				continue
			else
				minkey = haskey(madsdata["Parameters"][paramkeys[i]], "init_min") ? "init_dist" : "min"
				maxkey = haskey(madsdata["Parameters"][paramkeys[i]], "init_max") ? "init_dist" : "max"
			end
		else
			if haskey(madsdata["Parameters"][paramkeys[i]], "dist")
				distributions[paramkeys[i]] = Distributions.eval(parse(madsdata["Parameters"][paramkeys[i]]["dist"]))
				continue
			else
				minkey = "min"
				maxkey = "max"
			end
		end
		if haskey(madsdata["Parameters"][paramkeys[i]], minkey ) && haskey(madsdata["Parameters"][paramkeys[i]], maxkey )
			distributions[paramkeys[i]] = Distributions.Uniform(madsdata["Parameters"][paramkeys[i]][minkey], madsdata["Parameters"][paramkeys[i]][maxkey])
		else
			Mads.madserror("""Probabilistic distribution of parameter $(paramkeys[i]) is not defined; "dist" or "min"/"max" are missing!""")
		end
	end
	return distributions
end