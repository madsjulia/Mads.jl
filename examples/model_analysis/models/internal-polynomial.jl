import Mads
import OrderedCollections

function makemadsmodelrun_internal_polynomial(madsdata::AbstractDict)
	times = Mads.getobstime(madsdata)
	names = Mads.getobskeys(madsdata)
	function madsmodelrun(parameters::AbstractDict) # model run
		f(t) = parameters["a"] * (t ^ parameters["n"]) + parameters["b"] * t + parameters["c"] # a * t^n + b * t + c
		predictions = OrderedCollections.OrderedDict{String, Float64}(zip(names, map(f, times)))
		return predictions
	end
end
