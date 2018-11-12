import Mads
import JSON
import OrderedCollections
import Test

using Distributed

cwd = pwd()
workdir = Mads.getmadsdir()
if workdir == "."
	@everywhere workdir = joinpath(Mads.madsdir, "examples", "sensitivity")
end

md = Mads.loadmadsfile(joinpath(workdir, "sobol.mads"))
sa_results = Mads.efast(md, N=385, seed=2015)
Mads.computeparametersensitities(md, sa_results)

filename_correct = joinpath(workdir, "sobol-efast-results_correct.json")
if Mads.create_tests
	@warn("Generating test file $filename_correct ... ")
	file = open(filename_correct, "w")
	JSON.print(file, sa_results)
	close(file)
end

sa_results_correct = JSON.parsefile(filename_correct; dicttype=OrderedCollections.OrderedDict, use_mmap=true)
@Test.testset "Sensitivity" begin
	@Test.test !in(Base.collect(Base.values(sa_results_correct["mes"]["of"])) - Base.collect(Base.values(sa_results["mes"]["of"])) .< 1e-6, false)
	@Test.test !in(Base.collect(Base.values(sa_results_correct["tes"]["of"])) - Base.collect(Base.values(sa_results["tes"]["of"])) .< 1e-6, false)
end

sa_results = Mads.saltelli(md; N=5, seed=2015, parallel=true)
sa_results = Mads.saltellibruteparallel(md, 2; N=5, seed=2015)
sa_results = Mads.saltelliparallel(md, 2; N=5, seed=2015)
# sa_results = Mads.saltellibrute(md, N=10, seed=2015)
# sa_results = Mads.saltelli(md, N=10, seed=2015)

Mads.stdoutcaptureon();

sad1 = Mads.printSAresults(md, sa_results)
Mads.printSAresults2(md, sa_results)

Mads.stdoutcaptureoff();

A=[[1,2] [2,3]]
Mads.savesaltellirestart(A, "A", workdir)
Mads.loadsaltellirestart!(A, "A", workdir)
Mads.rmfile(joinpath(workdir, "A_1.jld2"))
Mads.rmdir(joinpath(cwd, "sobol_restart"))

:passed