include("MadsIO.jl")

function asinetransform(params::Vector, lowerbounds::Vector, upperbounds::Vector) # asine transformation
	sineparams = asin((params - lowerbounds) ./ (upperbounds - lowerbounds) * 2 - 1) # transformed parameters (sine parameter space)
	return sineparams
end

function sinetransform(sineparams::Vector, lowerbounds::Vector, upperbounds::Vector) # sine transformation
	params = lowerbounds + (upperbounds - lowerbounds) .* ((1 + sin(sineparams)) * .5) # untransformed parameters (regular parameter space)
	return params
end

function sinetransformfunction(f::Function, lowerbounds::Vector, upperbounds::Vector) # sine transformation a function
	function sinetransformedf(sineparams::Vector)
		params = sinetransform(sineparams, lowerbounds, upperbounds)
		return f(params)
	end
	return sinetransformedf
end

function sinetransformgradient(g::Function, lowerbounds::Vector, upperbounds::Vector) # sine transformation a gradient function
	function sinetransformedg(sineparams::Vector)
		params = sinetransform(sineparams, lowerbounds, upperbounds)
		result = g(params)
		f(x) = cos(x) / 2
		transformgrad = (upperbounds - lowerbounds) .* f(sineparams)
		for i = 1:size(result, 1)
			for j = 1:size(result, 2)
				result[i, j] *= transformgrad[j]
			end
		end
		return result
	end
	return sinetransformedg
end

function makearrayloglikelihood(madsdata, loglikelihood) # make log likelihood array
	f = makemadscommandfunction(madsdata)
	paramkeys = getparamkeys(madsdata)
	return arrayparameters::Vector -> loglikelihood(Dict(paramkeys, arrayparameters), f(Dict(paramkeys, arrayparameters)), madsdata["Observations"])
end

function setdynamicmodel(madsdata, f::Function)
	madsdata["Dynamic model"] = f
end

getparamsnames = ["min", "max", "init", "type", "log"]
getparamstypes = [Float64, Float64, Float64, Any, Any]
for i = 1:length(getparamsnames)
	name = getparamsnames[i]
	typ = getparamstypes[i]
	q = quote
		function $(symbol(string("getparams", name)))(madsdata, paramkeys)
			retval = Array($(typ), length(paramkeys))
			for i in 1:length(paramkeys)
				retval[i] = madsdata["Parameters"][paramkeys[i]][$name]
			end
			return retval
		end
		function $(symbol(string("getparams", name)))(madsdata)
			paramkeys = getparamkeys(madsdata)
			return $(symbol(string("getparams", name)))(madsdata, paramkeys)
		end
	end
	eval(q)
end

getfunction = [getparamstype, getparamslog]
keywordname = ["opt", "log"]
keywordvals = ["opt", true]
for i = 1:length(getfunction)
	q = quote
		function $(symbol(string("get", keywordname[i], "paramkeys")))(madsdata, paramkeys)
			paramtypes = $(getfunction[i])(madsdata, paramkeys)
			return paramkeys[paramtypes .== $(keywordvals[i])]
		end
		function $(symbol(string("get", keywordname[i], "paramkeys")))(madsdata)
			paramkeys = getparamkeys(madsdata)
			return $(symbol(string("get", keywordname[i], "paramkeys")))(madsdata, paramkeys)
		end
		function $(symbol(string("getnon", keywordname[i], "paramkeys")))(madsdata, paramkeys)
			paramtypes = $(getfunction[i])(madsdata, paramkeys)
			return paramkeys[paramtypes .!= $(keywordvals[i])]
		end
		function $(symbol(string("getnon", keywordname[i], "paramkeys")))(madsdata)
			paramkeys = getparamkeys(madsdata)
			return $(symbol(string("getnon", keywordname[i], "paramkeys")))(madsdata, paramkeys)
		end
	end
	eval(q)
end
function getoptparamkeys(madsdata)
	paramtypes = getparamstype(madsdata)
	paramkeys = getparamkeys(madsdata)
	return paramkeys[paramtypes .== "opt"]
end
