function conditionalloglikelihood(predictions::AbstractDict, observations::AbstractDict)
	ssr = 0.::Float64
	for i in keys(observations)
		diff = observations[i]["target"] - predictions[i]
		ssr += diff * diff
	end
	return -ssr
end