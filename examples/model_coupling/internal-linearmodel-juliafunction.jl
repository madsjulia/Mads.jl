function juliafunction(parameters::AbstractVector)
	f(t) = parameters[1] * t - parameters[2] # a * t - b
	times = 1:4
	predictions = map(f, times)
	return predictions
end