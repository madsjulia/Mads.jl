using Mads
using DataStructures
function madsmodelrun(madsdata::Dict) # model run
	param = readdlm("parameter.dat")
	a = param[1]
	b = param[2]
	f(t) = a * t - b # a * t - b
	obskeys = Mads.getobskeys(madsdata)
	nT = length(obskeys)
	times = 1:nT
	predictions = OrderedDict{String, Float64}(zip(map(i -> string("o", i), times), map(f, times)))
	return predictions
end
