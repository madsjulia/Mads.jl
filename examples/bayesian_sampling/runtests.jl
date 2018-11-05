import Mads
import JLD2
import FileIO
import Test
using Distributed

Mads.veryquieton()
Mads.graphoff()

Mads.madsinfo("Bayesian sampling ...")

workdir = Mads.getmadsdir() # get the directory where the problem is executed
if workdir == "."
	workdir = joinpath(Mads.madsdir, "examples", "bayesian_sampling")
end

md = Mads.loadmadsfile(joinpath(workdir, "internal-linearmodel.mads"))
rootname = Mads.getmadsrootname(md)

mcmcchains_emcee = Mads.emceesampling(md; numwalkers=2, nsteps=10, burnin=2, thinning=2, seed=2016)

if Mads.create_tests
	d = joinpath(workdir, "test_results")
	Mads.mkdir(d)
	FileIO.save(joinpath(d, "mcmcchains_emcee.jld2"), "mcmcchains_emcee", mcmcchains_emcee)
end

if !haskey(ENV, "MADS_NO_KLARA") && isdefined(Mads, :Klara) && isdefined(Klara, :BasicContMuvParameter)
	Mads.bayessampling(md, 1; nsteps=1, burnin=1, thinning=1)
	mcmcchains_bayes = Mads.bayessampling(md, 2; nsteps=10, burnin=1, thinning=1, seed=2016)
	mcmcchain = Mads.bayessampling(md; nsteps=10, burnin=1, thinning=1, seed=2016)
	Mads.savemcmcresults(mcmcchain.value', rootname * "-test-mcmcchain1.json")
	rm(rootname * "-test-mcmcchain1.json")
	Mads.forward(md, mcmcchain.value; all=true)
end

md = Mads.loadmadsfile(joinpath(workdir, "w01.mads"))
rootname = Mads.getmadsrootname(md)
if !haskey(ENV, "MADS_NO_KLARA") && isdefined(Mads, :Klara) && isdefined(Klara, :BasicContMuvParameter)
	mcmcchain = Mads.bayessampling(md; nsteps=10, burnin=1, thinning=1, seed=2016)
	mcmcvalues = Mads.paramarray2dict(md, mcmcchain.value') # convert the parameters in the chain to a parameter dictionary of arrays
	mcmcvalues_array = hcat(vcat(map(i->collect(mcmcvalues[i]), keys(mcmcvalues)))...)
	Mads.forward(md, mcmcchain.value)
	if isdefined(Mads, :Gadfly) && !haskey(ENV, "MADS_NO_GADFLY")
		Mads.scatterplotsamples(md, mcmcchain.value', rootname * "-test-bayes-results.svg")
		Mads.rmfile(rootname * "-test-bayes-results.svg")
		Mads.spaghettiplots(md, mcmcvalues; keyword="", obs_plot_dots=false)
		Mads.spaghettiplot(md, mcmcvalues; keyword="test")
		Mads.spaghettiplots(md, 3; keyword="test", grayscale=true)
		Mads.spaghettiplot(md, 3; keyword="test", grayscale=true)
		s = splitdir(rootname)
		for filesinadir in Mads.searchdir(Regex(string(s[2], "-", "[.]*", "spaghetti.svg")), path=s[1])
			Mads.rmfile(filesinadir, path=s[1])
		end
	end
	if Mads.create_tests
		d = joinpath(workdir, "test_results")
		Mads.mkdir(d)
		FileIO.save(joinpath(d, "mcmcvalues.jld2"), "mcmcvalues", mcmcvalues)
	end
	good_mcmcvalues = FileIO.load(joinpath(workdir, "test_results", "mcmcvalues.jld2"), "mcmcvalues")
	good_mcmcvalues_array = hcat(vcat(map(i->collect(good_mcmcvalues[i]), keys(good_mcmcvalues)))...)
end

good_mcmcchains_emcee = FileIO.load(joinpath(workdir, "test_results", "mcmcchains_emcee.jld2"), "mcmcchains_emcee")

@Test.testset "Bayesian" begin
	@Test.testset "bayes" begin
		isdefined(Mads, :mcmcvalues_array) && @Test.test isapprox(good_mcmcvalues_array, mcmcvalues_array, atol=1e-8)
	end
	@Test.testset "emcee" begin
		@Test.test good_mcmcchains_emcee == mcmcchains_emcee
	end

end

Mads.rmdir(joinpath(workdir, "..", "model_coupling", "internal-linearmodel_restart"))

Mads.veryquietoff()
Mads.graphon()

:passed