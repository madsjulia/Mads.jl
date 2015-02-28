function loglikelihood(parameters::Dict, predictions::Dict, observations::Dict)
	ssr = 0.::Float64
	for i = 1:4
		obsname = string("o", i)
		diff = observations[obsname]["target"] - predictions[obsname]
		ssr += diff * diff
	end
	return -(ssr + (4 - parameters["a"]) ^ 2 + (7 - parameters["b"]) ^ 2) # TODO is [4,7] or [7,4]?
  # return -(ssr + (7 - parameters["a"]) ^ 2 + (4 - parameters["b"]) ^ 2)
end
