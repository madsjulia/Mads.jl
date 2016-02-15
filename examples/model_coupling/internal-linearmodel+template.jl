import DataStructures

function madsmodelrun(parameters::Dict) # model run
	# parameters are passed as an argument; however for testing they are read from an external file
	param = readdlm("parameter.dat")
	a = param[1]
	b = param[2]
	f(t) = a * t - b # a * t - b
	times = 1:4
	predictions = DataStructures.OrderedDict{String, Float64}(zip(map(i -> string("o", i), times), map(f, times)))
	return predictions
end
