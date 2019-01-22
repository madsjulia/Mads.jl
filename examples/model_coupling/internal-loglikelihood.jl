function loglikelihood(parameters::T, predictions::T, observations::T) where {T<:AbstractDict}
	ssr = 0.::Float64
	for i in keys(observations)
		diff = observations[i]["target"] - predictions[i]
		ssr += diff * diff
	end
	return -(ssr + (4 - parameters["a"])^2 + (7 - parameters["b"])^2)
end