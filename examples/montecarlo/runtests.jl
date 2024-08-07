import Mads
import Test
import JLD2

import Random
import OrderedCollections

Mads.@tryimportmain JLD2
Mads.@tryimportmain OrderedCollections

Mads.veryquieton()
Mads.graphoff()

Mads.madsinfo("Monte Carlo analysis ...")
workdir = Mads.getproblemdir() # get the directory where the problem is executed
if workdir == "."
	workdir = joinpath(Mads.dir, "examples", "montecarlo")
end

Mads.@stderrcapture function run_monte_carlo()
	md = Mads.loadmadsfile(joinpath(workdir, "internal-linearmodel.mads"))
	Mads.setseed(2015; rng=Random.MersenneTwister)
	results = Mads.montecarlo(md; N=10)
	if Mads.create_tests
		d = joinpath(workdir, "test_results")
		Mads.mkdir(d)
		JLD2.save(joinpath(d, "montecarlo.jld2"), "results", results)
	end
	return results
end

Test.@testset "Monte Carlo" begin
	resultsmcmc = run_monte_carlo()
	good_results = JLD2.load(joinpath(workdir, "test_results", "montecarlo.jld2"), "results")
	Test.@test size(resultsmcmc) == size(good_results)
end

Mads.rmdir(joinpath(workdir, "..", "model_coupling", "internal-linearmodel_restart"))

Mads.veryquietoff()
Mads.graphon()

:passed