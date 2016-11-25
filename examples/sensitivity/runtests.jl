import Mads
import JSON
import Base.Test
import DataStructures

problemdir = Mads.getmadsdir()
if problemdir == ""
	@everywhere problemdir = Mads.madsdir * "/../examples/sensitivity/"
end

md = Mads.loadmadsfile(problemdir * "sobol.mads")
sa_results = Mads.efast(md, N=385, seed=2015)
Mads.computeparametersensitities(md, sa_results)

if Mads.create_tests
	warn("* Generating test file examples/sensitivity/sobol-efast-results_correct.json ... ")
	file = open(problemdir * "sobol-efast-results_correct.json", "w")
	JSON.print(file, sa_results)
	close(file)
else
	sa_results_correct = JSON.parsefile(problemdir * "sobol-efast-results_correct.json"; dicttype=DataStructures.OrderedDict, use_mmap=true)
	@Base.Test.test !in( Base.collect(Base.values(sa_results_correct["mes"]["of"])) - Base.collect(Base.values(sa_results["mes"]["of"])) .< 1e-6, false )
	@Base.Test.test !in( Base.collect(Base.values(sa_results_correct["tes"]["of"])) - Base.collect(Base.values(sa_results["tes"]["of"])) .< 1e-6, false )
end

sa_results = Mads.saltellibruteparallel(md, 1, N=5, seed=2015)
sa_results = Mads.saltelliparallel(md, 1, N=5, seed=2015)
# sa_results = Mads.saltellibrute(md, N=10, seed=2015)
# sa_results = Mads.saltelli(md, N=10, seed=2015)

originalSTDOUT = STDOUT;
(outRead, outWrite) = redirect_stdout();
Mads.printSAresults(md, sa_results)
Mads.printSAresults2(md, sa_results)
close(outWrite);
close(outRead);
redirect_stdout(originalSTDOUT);

return