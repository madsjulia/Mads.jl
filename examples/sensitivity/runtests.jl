import Mads
using JSON
using Base.Test
using DataStructures

problemdir = Mads.getmadsdir()
if problemdir == ""
	@everywhere problemdir = Mads.madsdir * "/../examples/sensitivity/"
end

md = Mads.loadmadsfile(problemdir * "sobol.mads")
sa_results = Mads.efast(md, N=385, seed=2015)

if Mads.create_tests
	warn("* Generating test file examples/sensitivity/sobol-efast-results_correct.json ... ")
	file = open(problemdir * "sobol-efast-results_correct.json", "w")
	JSON.print(file, sa_results)
	close(file)
else
	sa_results_correct = JSON.parsefile(problemdir * "sobol-efast-results_correct.json"; dicttype=DataStructures.OrderedDict, use_mmap=true)
	@test !in( Base.collect(Base.values(sa_results_correct["mes"]["of"])) - Base.collect(Base.values(sa_results["mes"]["of"])) .< 1e-6, false )
	@test !in( Base.collect(Base.values(sa_results_correct["tes"]["of"])) - Base.collect(Base.values(sa_results["tes"]["of"])) .< 1e-6, false )
end

return