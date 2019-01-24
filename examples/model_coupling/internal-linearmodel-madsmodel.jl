import OrderedCollections

function makemadsmodelrun_internal_linearmodel(madsdata::AbstractDict)
	function madsmodelrun(parameters::AbstractDict) # model run
		f(t) = parameters["a"] * t - parameters["b"] # a * t - b
		times = 1:4
		predictions = OrderedCollections.OrderedDict{String, Float64}(zip(map(i -> string("o", i), times), map(f, times)))
		return predictions
	end
	return madsmodelrun
end
