function madsmodelrun(parameters::Dict) # model run
	f(t) = parameters["a"] * t - parameters["b"] # a * t - b
	times = 1:4
	predictions = Dict{String, Float64}(map(i -> string("o", i), times), map(f, times))
	return predictions
end
