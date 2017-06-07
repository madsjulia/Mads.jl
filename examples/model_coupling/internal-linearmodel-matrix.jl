import DataStructures

function madsmodelrun_internal_linearmodel_matrix(parameters::Associative) # model run
	f1(t) = parameters["a1"] * t - parameters["b1"] # a * t - b
	f2(t) = parameters["a2"] * t - parameters["b2"]
	times = 1:14
	p1 = DataStructures.OrderedDict{String, Float64}(zip(map(i -> string("A", i), times), map(f1, times)))
	p2 = DataStructures.OrderedDict{String, Float64}(zip(map(i -> string("B", i), times), map(f2, times)))
	return merge(p1, p2)
end
