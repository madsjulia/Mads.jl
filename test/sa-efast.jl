using Mads

Mads.quieton()

problemdir = Mads.getmadsdir()

mdsobol = Mads.loadyamlmadsfile(problemdir * "../tests/test-sobol.mads")
sa_results = Mads.efast(mdsobol, N=385, seed=2015)

if Mads.create_tests
	println(" - Generating file ../tests/test-sobol-efast-results_correct.json ... ")
	file = open(problemdir * "../tests/test-sobol-efast-results_correct.json", "w")
	JSON.print(file, sa_results)
	close(file)
else
	sa_results_correct = JSON.parsefile(problemdir * "../tests/test-sobol-efast-results_correct.json"; ordered=true, use_mmap=true)
	@test sa_results_correct == sa_results
end

Mads.quietoff()

return