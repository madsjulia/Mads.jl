import Mads
import JSON
import OrderedCollections
import Test

import Distributed

cwd = pwd()
workdir = Mads.getproblemdir()
if workdir == "."
	Distributed.@everywhere workdir = joinpath(Mads.dir, "examples", "sensitivity")
end

md = Mads.loadmadsfile(joinpath(workdir, "sobol.mads"))
sa_results = Mads.efast(md; N=385, seed=2015, save=false)
Mads.computeparametersensitities(md, sa_results)

filename_correct = joinpath(workdir, "sobol-efast-results_correct.json")
if Mads.create_tests
	@warn("Generating test file $filename_correct ... ")
	file = open(filename_correct, "w")
	JSON.print(file, sa_results)
	close(file)
end

sa_results_correct = JSON.parsefile(filename_correct; dicttype=OrderedCollections.OrderedDict, use_mmap=true)
Test.@testset "Sensitivity" begin
	Test.@test !in(Base.collect(Base.values(sa_results_correct["mes"]["of"])) - Base.collect(Base.values(sa_results["mes"]["of"])) .< 1e-6, false)
	Test.@test !in(Base.collect(Base.values(sa_results_correct["tes"]["of"])) - Base.collect(Base.values(sa_results["tes"]["of"])) .< 1e-6, false)
end

sa_results = Mads.saltelli(md; N=5, seed=2015, parallel=true, save=false)
sa_results = mktempdir() do output_dir::String
	cd(output_dir) do
		temporary_md::AbstractDict = deepcopy(md)
		temporary_md["Model"] = joinpath(dirname(String(md["Filename"])), String(md["Model"]))
		temporary_md["Filename"] = joinpath(output_dir, basename(md["Filename"]))
		Mads.saltellibruteparallel(temporary_md, 2; N=5, seed=2015)
		parallel_results::AbstractDict = Mads.saltelliparallel(temporary_md, 2; N=5, seed=2015)
		A::Matrix{Int} = [[1,2] [2,3]]
		Mads.savesaltellirestart(A, "A", output_dir)
		Mads.loadsaltellirestart!(A, "A", output_dir)
		return parallel_results
	end
end
# sa_results = Mads.saltellibrute(md; N=10, seed=2015)
# sa_results = Mads.saltelli(md; N=10, seed=2015)

Mads.stdoutcaptureon();

sad1 = Mads.printSAresults(md, sa_results)
Mads.printSAresults2(md, sa_results)

Mads.stdoutcaptureoff();

Mads.rmdir(joinpath(cwd, "sobol_restart"))

:passed