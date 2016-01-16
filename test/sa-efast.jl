using Mads
using Base.Test
using DataStructures

Mads.quieton()

problemdir = Mads.getmadsdir()

mdsobol = Mads.loadmadsfile(problemdir * "../tests/test-sobol.mads")
sa_results = Mads.efast(mdsobol, N=385, seed=2015)

if Mads.create_tests
	println(" - Generating file ../tests/test-sobol-efast-results_correct.json ... ")
	file = open(problemdir * "../tests/test-sobol-efast-results_correct.json", "w")
	JSON.print(file, sa_results)
	close(file)
else
	sa_results_correct = JSON.parsefile(problemdir * "../tests/test-sobol-efast-results_correct.json"; dicttype=DataStructures.OrderedDict, use_mmap=true)
	@test !in( collect(values(sa_results_correct["mes"]["of"])) - collect(values(sa_results["mes"]["of"])) .< 1e-6, false )
	@test !in( collect(values(sa_results_correct["tes"]["of"])) - collect(values(sa_results["tes"]["of"])) .< 1e-6, false )
end

Mads.quietoff()

return
