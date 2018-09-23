import Mads
import JLD2
import FileIO
import JLD

import Base.Test

Mads.madsinfo("Monte Carlo analysis ...")
workdir = Mads.getmadsdir() # get the directory where the problem is executed
if workdir == "."
	workdir = joinpath(Mads.madsdir, "examples", "montecarlo")
end

@Mads.stderrcapture function run_monte_carlo()
	md = Mads.loadmadsfile(joinpath(workdir, "internal-linearmodel.mads"))
	srand(2015)
	results = Mads.montecarlo(md; N=10)
	if Mads.create_tests
		d = joinpath(workdir, "test_results")
		Mads.mkdir(d)
		FileIO.save(joinpath(d, "montecarlo.jld"), "results", results)
	end
	return results
end

# Test Mads.montecarlo(md; N=10) against saved results
@Base.Test.testset "Monte Carlo" begin
	results = run_monte_carlo()
	good_results = FileIO.load(joinpath(workdir, "test_results", "montecarlo.jld"), "results")
	@Base.Test.test results == good_results
end

Mads.rmdir(joinpath(workdir, "..", "model_coupling", "internal-linearmodel_restart"))