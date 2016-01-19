"""
Get keys of all parameters in the MADS dictionary

`Mads.getparamkeys(madsdata)`

Arguments:

- `madsdata` : Mads data dictionary

Returns:

- `paramkeys` : array with the keys of all parameters in the MADS dictionary
"""
function getparamkeys(madsdata::Associative)
	if haskey( madsdata, "Parameters" )
		return collect(keys(madsdata["Parameters"]))
	end
end

"""
Get dictionary with all parameters and their respective initial values

`Mads.getparamdict(madsdata)`

Arguments:

- `madsdata` : Mads data dictionary

Returns:

- `paramdict` : dictionary with all parameters and their respective initial values
"""
function getparamdict(madsdata::Associative)
	if haskey( madsdata, "Parameters" )
		paramkeys = Mads.getparamkeys(madsdata)
		paramdict = OrderedDict(zip(paramkeys, map(key->madsdata["Parameters"][key]["init"], paramkeys)))
		return paramdict
	end
end

"""
Get keys of all source parameters in the MADS dictionary

`Mads.getsourcekeys(madsdata)`

Arguments:

- `madsdata` : Mads data dictionary

Returns:

- `sourcekeys` : array with keys of all source parameters in the MADS dictionary
"""
function getsourcekeys(madsdata::Associative)
	sourcekeys = Array(ASCIIString, 0)
	if haskey( madsdata, "Sources" )
		for i = 1:length(madsdata["Sources"])
			k = collect(ASCIIString, keys(madsdata["Sources"][i]["box"]))
			b = fill("Source1_", length(k))
			s = b .* k
			sourcekeys = [sourcekeys; s]
		end
	end
	return sourcekeys
end

"MADS parameter variable names"
getparamsnames = ["init_min", "init_max", "min", "max", "init", "type", "log", "step", "longname", "plotname"]
getparamstypes = [Float64, Float64, Float64, Float64, Float64, Any, Any, Float64, AbstractString, AbstractString]
getparamsdefault = [-Inf32, Inf32, -Inf32, Inf32, 0, "opt", "null", sqrt(eps(Float32)), "", ""]
index = 0
for i = 1:length(getparamsnames)
	paramname = getparamsnames[i]
	paramtype = getparamstypes[i]
	paramdefault = getparamsdefault[i]
	index = i
	q = quote
		@doc "Get an array with `$(getparamsnames[index])` values for all the MADS model parameters" ->
		function $(symbol(string("getparams", paramname)))(madsdata, paramkeys) # create a function to get each parameter name with 2 arguments
			paramvalue = Array($(paramtype), length(paramkeys))
			for i in 1:length(paramkeys)
				if haskey( madsdata["Parameters"][paramkeys[i]], $paramname)
					paramvalue[i] = madsdata["Parameters"][paramkeys[i]][$paramname]
				else
					paramvalue[i] = $(paramdefault)
				end
			end
			return paramvalue # returns the parameter values
		end
		function $(symbol(string("getparams", paramname)))(madsdata) # create a function to get each parameter name with 1 argument
			paramkeys = getparamkeys(madsdata) # get parameter keys
			return $(symbol(string("getparams", paramname)))(madsdata, paramkeys) # call the function with 2 arguments
		end
	end
	eval(q)
end

"""
Set initial parameter guesses in the MADS dictionary

`Mads.setparamsinit!(madsdata, paramdict)`

Arguments:

- `madsdata` : Mads data dictionary
- `paramdict` : dictionary with initial model parameter values
"""
function setparamsinit!(madsdata::Associative, paramdict::Associative)
	paramkeys = getparamkeys(madsdata)
	for i in 1:length(paramkeys)
		madsdata["Parameters"][paramkeys[i]]["init"] = paramdict[paramkeys[i]]
	end
end

"Set all parameters ON"
function setallparamson!(madsdata::Associative)
	paramkeys = getparamkeys(madsdata)
	for i in 1:length(paramkeys)
		madsdata["Parameters"][paramkeys[i]]["type"] = "opt"
	end
end

"Set all parameters OFF"
function setallparamsoff!(madsdata::Associative)
	paramkeys = getparamkeys(madsdata)
	for i in 1:length(paramkeys)
		madsdata["Parameters"][paramkeys[i]]["type"] = nothing
	end
end

"Set a specific parameter with a key `parameterkey` ON"
function setparamon!(madsdata::Associative, parameterkey)
		madsdata["Parameters"][parameterkey]["type"] = "opt";
end

"Set a specific parameter with a key `parameterkey`  OFF"
function setparamoff!(madsdata::Associative, parameterkey)
		madsdata["Parameters"][parameterkey]["type"] = nothing
end

"""
Set normal parameter distributions for all the model parameters in the MADS data dictionary

`Mads.setparamsdistnormal!(madsdata, mean, stddev)`

Arguments:

- `madsdata` : Mads data dictionary
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
Set uniform parameter distributions for all the model parameters in the MADS data dictionary

`Mads.setparamsdistuniform!(madsdata, min, max)`

Arguments:

- `madsdata` : Mads data dictionary
- `min` : array with the minimum values
- `max` : array with the maximum values
"""
function setparamsdistuniform!(madsdata::Associative, min, max)
	paramkeys = getparamkeys(madsdata)
	for i in 1:length(paramkeys)
		madsdata["Parameters"][paramkeys[i]]["dist"] = "Uniform($(min[i]),$(max[i]))"
	end
end

["Make functions to get parameter keys for specific MADS parameters (optimized and log-transformed)"]
getfunction = [getparamstype, getparamslog]
keywordname = ["opt", "log"]
funcname = ["optimized", "log-transformed"]
keywordvalsNOT = [nothing, false]
index = 0
for i = 1:length(getfunction)
	index = i
	q = quote
		@doc "Get the keys in the MADS data dictionary for parameters that are $(funcname[index]) (`$(keywordname[index])`)" ->
		function $(symbol(string("get", keywordname[i], "paramkeys")))(madsdata, paramkeys) # create functions getoptparamkeys / getlogparamkeys
			paramtypes = $(getfunction[i])(madsdata, paramkeys)
			return paramkeys[paramtypes .!= $(keywordvalsNOT[i])]
		end
		function $(symbol(string("get", keywordname[i], "paramkeys")))(madsdata)
			paramkeys = getparamkeys(madsdata)
			return $(symbol(string("get", keywordname[i], "paramkeys")))(madsdata, paramkeys)
		end
		@doc "Get the keys in the MADS data dictionary for parameters that are NOT $(funcname[index]) (`$(keywordname[index])`)" ->
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

"Show optimizable parameters in the Mads data dictionary"
function showparameters(madsdata::Associative)
	pardict = madsdata["Parameters"]
	parkeys = Mads.getoptparamkeys(madsdata)
	p = Array(ASCIIString, 0)
	for parkey in parkeys
		s = @sprintf "%-10s init = %15g log = %5s  Distribution = %s" parkey pardict[parkey]["init"] pardict[parkey]["log"] pardict[parkey]["dist"]
		push!(p, s)
	end
	display(p)
end

"Show all parameters in the Mads data dictionary"
function showallparameters(madsdata::Associative)
	pardict = madsdata["Parameters"]
	parkeys = Mads.getparamkeys(madsdata)
	p = Array(ASCIIString, 0)
	for parkey in parkeys
		s = @sprintf "%-10s = %15g" parkey pardict[parkey]["init"]
		if pardict[parkey]["type"] != nothing
			s *= " <- optimizable "
			s *= @sprintf "log = %5s  Distribution = %s" pardict[parkey]["log"] pardict[parkey]["dist"]
		end
		push!(p, s)
	end
	display(p)
end

"""
Get distributions of all parameters in the Mads data dictionary

`Mads.getparamdistributions(madsdata; init_dist=false)`

Arguments:

- `madsdata` : Mads data dictionary
- `init_dist` : if true, use the initialization distributions (if defined)
"""
function getparamdistributions(madsdata::Associative; init_dist=false)
	paramkeys = getoptparamkeys(madsdata)
	distributions = OrderedDict()
	for i in 1:length(paramkeys)
		if init_dist
			if haskey(madsdata["Parameters"][paramkeys[i]], "init_dist")
				distributions[paramkeys[i]] = eval(parse(madsdata["Parameters"][paramkeys[i]]["init_dist"]))
				continue
			else
				minkey = haskey(madsdata["Parameters"][paramkeys[i]], "init_min") ? "init_dist" : "min"
				maxkey = haskey(madsdata["Parameters"][paramkeys[i]], "init_max") ? "init_dist" : "max"
			end
		else
			if haskey(madsdata["Parameters"][paramkeys[i]], "dist")
				distributions[paramkeys[i]] = eval(parse(madsdata["Parameters"][paramkeys[i]]["dist"]))
				continue
			else
				minkey = "min"
				maxkey = "max"
			end
		end
		distributions[paramkeys[i]] = Uniform(madsdata["Parameters"][paramkeys[i]][minkey], madsdata["Parameters"][paramkeys[i]][maxkey])
	end
	return distributions
end