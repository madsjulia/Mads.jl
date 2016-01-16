"Get keys for parameters"
function getparamkeys(madsdata::Associative)
	return collect(keys(madsdata["Parameters"]))
	#return [convert(AbstractString,k) for k in keys(madsdata["Parameters"])]
end

"Get keys for source parameters"
function getsourcekeys(madsdata::Associative)
	return collect(keys(madsdata["Sources"][1]["box"]))
	#return [convert(AbstractString,k) for k in keys(madsdata["Parameters"])]
end

"Create functions to get values of the MADS parameters"
getparamsnames = ["init_min", "init_max", "min", "max", "init", "type", "log", "step", "longname", "plotname"]
getparamstypes = [Float64, Float64, Float64, Float64, Float64, Any, Any, Float64, AbstractString, AbstractString]
getparamsdefault = [-Inf32, Inf32, -Inf32, Inf32, 0, "opt", "null", sqrt(eps(Float32)), "", ""]
for i = 1:length(getparamsnames)
	paramname = getparamsnames[i]
	paramtype = getparamstypes[i]
	paramdefault = getparamsdefault[i]
	q = quote
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

"Set initial parameters in the MADS dictionary"
function setparamsinit!(madsdata::Dict, paramdict::Dict)
	od = OrderedDict() #TODO better way to do this?!
	od = merge(od, paramdict)
	setparamsinit!(madsdata, od)
end

"Set all parameters ON"
function setallparamson!(madsdata::Dict)
	paramkeys = getparamkeys(madsdata)
	for i in 1:length(paramkeys)
		madsdata["Parameters"][paramkeys[i]]["type"] = "opt"
	end
end

"Set all parameters OFF"
function setallparamsoff!(madsdata::Dict)
	paramkeys = getparamkeys(madsdata)
	for i in 1:length(paramkeys)
		madsdata["Parameters"][paramkeys[i]]["type"] = nothing
	end
end

"Set a parameter ON"
function setparamon!(madsdata::Dict, paramkey)
		madsdata["Parameters"][paramkey]["type"] = "opt";
end

"Set a parameter OFF"
function setparamoff!(madsdata::Dict, paramkey)
		madsdata["Parameters"][paramkey]["type"] = nothing
end

"Set initial parameters in the MADS dictionary"
function setparamsinit!(madsdata::Dict, paramdict::OrderedDict)
	paramkeys = getparamkeys(madsdata)
	for i in 1:length(paramkeys)
		madsdata["Parameters"][paramkeys[i]]["init"] = paramdict[paramkeys[i]]
	end
end

"Set normal parameter distributions in the MADS dictionary"
function setparamsdistnormal!(madsdata, mean, stddev)
	paramkeys = getparamkeys(madsdata)
	for i in 1:length(paramkeys)
		madsdata["Parameters"][paramkeys[i]]["dist"] = "Normal($(mean[i]),$(stddev[i]))"
	end
end
"Create functions to get parameter keys for specific MADS parameters (optimized and log-transformed)"
getfunction = [getparamstype, getparamslog]
keywordname = ["opt", "log"]
keywordvalsNOT = [nothing, false]
for i = 1:length(getfunction)
	q = quote
		function $(symbol(string("get", keywordname[i], "paramkeys")))(madsdata, paramkeys) # create functions getoptparamkeys / getlogparamkeys
			paramtypes = $(getfunction[i])(madsdata, paramkeys)
			return paramkeys[paramtypes .!= $(keywordvalsNOT[i])]
		end
		function $(symbol(string("get", keywordname[i], "paramkeys")))(madsdata)
			paramkeys = getparamkeys(madsdata)
			return $(symbol(string("get", keywordname[i], "paramkeys")))(madsdata, paramkeys)
		end
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

"Get keys for optimized parameters (redundant; already created above)"
function getoptparamkeys(madsdata)
	paramtypes = getparamstype(madsdata)
	paramkeys = getparamkeys(madsdata)
	return paramkeys[paramtypes .!= nothing]
end

"Show optimizable parameters"
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

"Show parameters"
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

"Get parameter distributions"
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