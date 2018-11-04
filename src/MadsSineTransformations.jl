import DocumentFunction

function asinetransform(madsdata::AbstractDict, params::Vector)
	paramkeys = getoptparamkeys(madsdata)
	lowerbounds = Mads.getparamsmin(madsdata, paramkeys)
	upperbounds = Mads.getparamsmax(madsdata, paramkeys)
	logtransformed = Mads.getparamslog(madsdata, paramkeys)
	indexlogtransformed = findall(logtransformed)
	lowerbounds[indexlogtransformed] = log10.(lowerbounds[indexlogtransformed])
	upperbounds[indexlogtransformed] = log10.(upperbounds[indexlogtransformed])
	return Mads.asinetransform(params, lowerbounds, upperbounds, indexlogtransformed)
end
function asinetransform(params::Vector, lowerbounds::Vector, upperbounds::Vector, indexlogtransformed::Vector) # asine transformation
	sineparams = copy(params)
	sineparams[indexlogtransformed] = log10.(sineparams[indexlogtransformed])
	sineparams = asin.((sineparams .- lowerbounds) ./ (upperbounds .- lowerbounds) .* 2 .- 1)
	return sineparams
end

@doc """
Arcsine transformation of model parameters

$(DocumentFunction.documentfunction(asinetransform;
argtext=Dict("madsdata"=>"MADS problem dictionary",
			"params"=>"model parameters",
			"lowerbounds"=>"lower bounds",
			"upperbounds"=>"upper bounds",
			"indexlogtransformed"=>"index vector of log-transformed parameters")))

Returns:

- Arcsine transformation of model parameters
""" asinetransform

function sinetransform(madsdata::AbstractDict, params::Vector)
	paramkeys = getoptparamkeys(madsdata)
	lowerbounds = Mads.getparamsmin(madsdata, paramkeys)
	upperbounds = Mads.getparamsmax(madsdata, paramkeys)
	logtransformed = Mads.getparamslog(madsdata, paramkeys)
	indexlogtransformed = findall(logtransformed)
	lowerbounds[indexlogtransformed] = log10.(lowerbounds[indexlogtransformed])
	upperbounds[indexlogtransformed] = log10.(upperbounds[indexlogtransformed])
	return Mads.sinetransform(params, lowerbounds, upperbounds, indexlogtransformed)
end
function sinetransform(sineparams::Vector, lowerbounds::Vector, upperbounds::Vector, indexlogtransformed::Vector) # sine transformation
	params = lowerbounds .+ (upperbounds .- lowerbounds) .* ((1 .+ sin.(sineparams)) .* .5) # untransformed parameters (regular parameter space)
	params[indexlogtransformed] = 10 .^ params[indexlogtransformed]
	return params
end

@doc """
Sine transformation of model parameters

$(DocumentFunction.documentfunction(sinetransform;
argtext=Dict("madsdata"=>"MADS problem dictionary",
			"sineparams"=>"model parameters",
			"lowerbounds"=>"lower bounds",
			"upperbounds"=>"upper bounds",
			"indexlogtransformed"=>"index vector of log-transformed parameters")))

Returns:

- Sine transformation of model parameters
""" sinetransform

"""
Sine transformation of a function

$(DocumentFunction.documentfunction(sinetransformfunction;
argtext=Dict("f"=>"function",
			"lowerbounds"=>"lower bounds",
			"upperbounds"=>"upper bounds",
			"indexlogtransformed"=>"index vector of log-transformed parameters")))

Returns:

- Sine transformation
"""
function sinetransformfunction(f::Function, lowerbounds::Vector, upperbounds::Vector, indexlogtransformed::Vector) # sine transformation a function
	function sinetransformedf(sineparams::Vector)
		return f(sinetransform(sineparams, lowerbounds, upperbounds, indexlogtransformed))
	end
	return sinetransformedf
end

"""
Sine transformation of a gradient function

$(DocumentFunction.documentfunction(sinetransformgradient;
argtext=Dict("g"=>"gradient function",
			"lowerbounds"=>"vector with parameter lower bounds",
			"upperbounds"=>"vector with parameter upper bounds",
			"indexlogtransformed"=>"index vector of log-transformed parameters"),
keytext=Dict("sindx"=>"sin-space parameter step applied to compute numerical derivatives [default=`0.1`]")))

Returns:

- Sine transformation of a gradient function
"""
function sinetransformgradient(g::Function, lowerbounds::Vector, upperbounds::Vector, indexlogtransformed::Vector; sindx::Float64 = 0.1)
	function sinetransformed(sineparams::Vector; center::Array{Float64,1}=Array{Float64}(undef, 0))
		params = sinetransform(sineparams, lowerbounds, upperbounds, indexlogtransformed)
		dxparams1 = sinetransform(sineparams .+ sindx, lowerbounds, upperbounds, indexlogtransformed)
		dxparams2 = sinetransform(sineparams .- sindx, lowerbounds, upperbounds, indexlogtransformed)
		dxparams = maximum([dxparams1 dxparams2], dims=2)
		lineardx = vec(dxparams .- params)
		result = g(params; dx=lineardx, center=center)
		if result != nothing
			lineardx ./= sindx
			for i = 1:size(result, 1)
				result[i, :] .*= lineardx
			end
		end
		return result
	end
	return sinetransformed
end
