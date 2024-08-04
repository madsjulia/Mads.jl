import Mads
import JLD2
import Test
import Distributed
import Random

Mads.veryquieton()
Mads.graphoff()

Mads.madsinfo("Bayesian sampling ...")

workdir = Mads.getproblemdir() # get the directory where the problem is executed
if workdir == "."
	workdir = joinpath(Mads.dir, "examples", "bayesian_sampling")
end

md = Mads.loadmadsfile(joinpath(workdir, "internal-linearmodel.mads"))
rootname = Mads.getmadsrootname(md)

mcmcchains_emcee = Mads.emceesampling(md; numwalkers=2, nexecutions=10, burnin=2, thinning=2, seed=2016, rng=Random.MersenneTwister)

if Mads.create_tests
	d = joinpath(workdir, "test_results")
	Mads.mkdir(d)
	JLD2.save(joinpath(d, "mcmcchains_emcee.jld2"), "mcmcchains_emcee", mcmcchains_emcee)
end

md = Mads.loadmadsfile(joinpath(workdir, "w01.mads"))
rootname = Mads.getmadsrootname(md)

good_mcmcchains_emcee = JLD2.load(joinpath(workdir, "test_results", "mcmcchains_emcee.jld2"), "mcmcchains_emcee")

Test.@testset "Bayesian" begin
	Test.@testset "bayes" begin
		isdefined(Mads, :mcmcvalues_array) && Test.@test isapprox(good_mcmcvalues_array, mcmcvalues_array, atol=1e-8)
	end
	Test.@testset "emcee" begin
		Test.@test good_mcmcchains_emcee == mcmcchains_emcee
	end

end

Mads.rmdir(joinpath(workdir, "..", "model_coupling", "internal-linearmodel_restart"))

Mads.veryquietoff()
Mads.graphon()

:passed