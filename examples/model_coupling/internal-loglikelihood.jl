function loglikelihood(parameters::T1, predictions::T2, observations::T3) where {T1<:AbstractDict, T2<:AbstractDict, T3<:AbstractDict}
	ssr = 0.::Float64
	for i = 1:4
		obsname = string("o", i)
		diff = observations[obsname]["target"] - predictions[obsname]
		ssr += diff * diff
	end
	return -(ssr + (4 - parameters["a"]) ^ 2 + (7 - parameters["b"]) ^ 2)
end