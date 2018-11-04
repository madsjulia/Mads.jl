import Mads
import OrderedCollections

function makemadsmodelrun(madsdata::AbstractDict)
	times = Mads.getobstime(madsdata)
	names = Mads.getobskeys(madsdata)
	function madsmodelrun(parameters::AbstractDict) # model run
		f(t) = parameters["a"] * t + parameters["b"] # a * t + b
		predictions = OrderedCollections.OrderedDict{String, Float64}(zip(names, map(f, times)))
		return predictions
	end
end