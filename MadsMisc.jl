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
