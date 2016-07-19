import Mads
import DataStructures

function makemadsmodelrun(madsdata::Associative)
	times = Mads.getobstime(madsdata)
	names = Mads.getobskeys(madsdata)
	function madsmodelrun(parameters::Associative) # model run
		f(t) = parameters["a"] * t + parameters["b"] # a * t + b
		predictions = DataStructures.OrderedDict{AbstractString, Float64}(zip(names, map(f, times)))
		return predictions
	end
end