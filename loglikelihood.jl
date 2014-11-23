function loglikelihood(parameters::Dict, predictions::Dict, observations::Dict)
	ssr = 0.::Float64
	for i = 1:4
		obsname = string("v", i)
		diff = observations[obsname]["target"] - predictions[obsname]
		ssr += diff * diff
	end
	return -(ssr + (4 - parameters["a"]) ^ 2 + (7 - parameters["b"]) ^ 2)
end
