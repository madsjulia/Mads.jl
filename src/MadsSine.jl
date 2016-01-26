"Arcsine transformation of model parameters"
function asinetransform(params::Vector, lowerbounds::Vector, upperbounds::Vector, indexlogtransformed::Vector) # asine transformation
	sineparams = copy(params)
	sineparams[indexlogtransformed] = log10(sineparams[indexlogtransformed])
	sineparams = asin((sineparams - lowerbounds) ./ (upperbounds - lowerbounds) * 2 - 1)
	return sineparams
end

"Sine transformation of model parameters"
function sinetransform(sineparams::Vector, lowerbounds::Vector, upperbounds::Vector, indexlogtransformed::Vector) # sine transformation
	params = lowerbounds + (upperbounds - lowerbounds) .* ((1 + sin(sineparams)) * .5) # untransformed parameters (regular parameter space)
	params[indexlogtransformed] = 10 .^ params[indexlogtransformed]
	return params
end

"Sine transformation of a function"
function sinetransformfunction(f::Function, lowerbounds::Vector, upperbounds::Vector, indexlogtransformed::Vector) # sine transformation a function
	function sinetransformedf(sineparams::Vector)
		return f(sinetransform(sineparams, lowerbounds, upperbounds, indexlogtransformed))
	end
	return sinetransformedf
end

"Sine transformation of a gradient function"
function sinetransformgradient(g::Function, lowerbounds::Vector, upperbounds::Vector, indexlogtransformed::Vector; sindx::Float64 = 0.1) # sine transformation a gradient function
	function sinetransformedg(sineparams::Vector; center=Array(Float64,0))
		params = sinetransform(sineparams, lowerbounds, upperbounds, indexlogtransformed)
		dxparams = sinetransform(sineparams .+ sindx, lowerbounds, upperbounds, indexlogtransformed)
		lineardx = dxparams - params
		result = g(params; dx=lineardx, center=center)
		lineardx ./= sindx
		for i = 1:size(result, 1)
			for j = 1:size(result, 2)
			# println(result[i, j])
				result[i, j] *= lineardx[j]
			end
		end
		return result
	end
	return sinetransformedg
end
