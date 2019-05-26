import Mads
import Test
import JLD2
import FileIO
import DataStructures

@Mads.tryimportmain JLD2
@Mads.tryimportmain FileIO
@Mads.tryimportmain OrderedCollections
@Mads.tryimportmain DataStructures

Mads.veryquieton()
Mads.graphoff()

Mads.madsinfo("Monte Carlo analysis ...")
workdir = Mads.getmadsdir() # get the directory where the problem is executed
if workdir == "."
	workdir = joinpath(Mads.madsdir, "examples", "montecarlo")
end

@Mads.stderrcapture function run_monte_carlo()
	md = Mads.loadmadsfile(joinpath(workdir, "internal-linearmodel.mads"))
	Random.seed!(2015)
	results = Mads.montecarlo(md; N=10)
	if Mads.create_tests
		d = joinpath(workdir, "test_results")
		Mads.mkdir(d)
		FileIO.save(joinpath(d, "montecarlo.jld2"), "results", results)
	end
	return results
end

# Test Mads.montecarlo(md; N=10) against saved results
@Test.testset "Monte Carlo" begin
	resultsmcmc = run_monte_carlo()
	good_results = FileIO.load(joinpath(workdir, "test_results", "montecarlo.jld2"), "results")
	@Test.test resultsmcmc == good_results
end

Mads.rmdir(joinpath(workdir, "..", "model_coupling", "internal-linearmodel_restart"))

Mads.veryquietoff()
Mads.graphon()

:passed