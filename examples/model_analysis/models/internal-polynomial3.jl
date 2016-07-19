import Mads
import DataStructures

function makemadsmodelrun(madsdata::Associative)
	times = Mads.getobstime(madsdata)
	names = Mads.getobskeys(madsdata)
	function madsmodelrun(parameters::Associative) # model run
		f(t) = parameters["a"] * (t^1.1) + parameters["b"] * t + parameters["c"] # a * t^n + b * t + c
		predictions = DataStructures.OrderedDict{AbstractString, Float64}(zip(names, map(f, times)))
		return predictions
	end
end