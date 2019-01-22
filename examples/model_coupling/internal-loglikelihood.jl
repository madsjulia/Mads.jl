function loglikelihood(parameters::T, predictions::T, observations::T) where {T<:AbstractDict}
	ssr = 0.::Float64
	for i = 1:4
		obsname = string("o", i)
		diff = observations[obsname]["target"] - predictions[obsname]
		ssr += diff * diff
	end
	return -(ssr + (4 - parameters["a"])^2 + (7 - parameters["b"])^2)
end