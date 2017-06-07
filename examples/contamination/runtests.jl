import Mads
import Base.Test
import JLD

workdir = (Mads.getmadsdir() == ".") ? joinpath(Mads.madsdir, "..", "examples", "contamination") : Mads.getmadsdir()

md = Mads.loadmadsfile(joinpath(workdir, "w01-w13a_w20a.mads"))
rootname = Mads.getmadsrootname(md)

function plot_results(md, inverse_predictions, paramvalues)
	if isdefined(:Gadfly) && !haskey(ENV, "MADS_NO_GADFLY")
		
		Mads.plotmatches(md, inverse_predictions) # plot calibrated matches
		Mads.rmfile(joinpath(workdir, "w01-w13a_w20a-match.svg"))
		
		Mads.spaghettiplots(md, paramvalues, keyword="w13a_w20a")
		Mads.spaghettiplot(md, paramvalues, keyword="w13a_w20a")
		s = splitdir(rootname)
		for filesinadir in Mads.searchdir(Regex(string(s[2], "-w13a_w20a", "\.*", "spaghetti.svg")), path=s[1])
			Mads.rmfile(filesinadir, path=s[1])
		end
		
		sa_results = Mads.saltelli(md, N=5, seed=2015)
		Mads.plotwellSAresults(md, sa_results)
		Mads.plotobsSAresults(md, sa_results)
		Mads.plotobsSAresults(md, sa_results, separate_files=true)
		Mads.rmfile(joinpath(workdir, "w01-w13a_w20a-saltelli-5-main_effect.svg"))
		Mads.rmfile(joinpath(workdir, "w01-w13a_w20a-saltelli-5-total_effect.svg"))
		Mads.rmfile(joinpath(workdir, "w01-w13a_w20a-saltelli-5.svg"))
		Mads.rmfile(joinpath(workdir, "w01-w13a_w20a-w13a-saltelli-5.svg"))
		Mads.rmfile(joinpath(workdir, "w01-w13a_w20a-w20a-saltelli-5.svg"))
	end
end

@Base.Test.testset "Contamination" begin

	forward_predictions = Mads.forward(md) # Execute forward model simulation based on initial parameter guesses
	param_values = Mads.getoptparams(md) # Initial parameter values
	of = Mads.partialof(md, forward_predictions, r".*")
	inverse_parameters, inverse_results = Mads.calibrate(md, maxEval=1, np_lambda=1, maxJacobians=1) # perform model calibration
	param_values = Mads.getoptparams(md, collect(values(inverse_parameters)))

	# Test param_values
	@Base.Test.test isapprox(mean([abs(param_values[i] - [40.0,4.0,15.0][i]) for i=1:3]), 0, atol=1e-4)
		
	forward_predictions = Mads.forward(md, inverse_parameters)
	localsa_results = Mads.localsa(md, datafiles=false, imagefiles=false, par=collect(values(inverse_parameters)), obs=collect(values(forward_predictions)))
	samples, llhoods = Mads.sampling(param_values, localsa_results["jacobian"], 10, seed=2016, scale=0.5) # sampling for local uncertainty analysis
	
	# Arrays to test samples and llhoods against
	good_samples = [40.0 40.0 40.0 40.0 40.0 40.0 40.0 40.0 40.0 40.0; 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0; 15.0 15.0 15.0 15.0 15.0 15.0 15.0 15.0 15.0 15.0]
	good_llhoods = [9.60999,10.2521,9.26273,10.3345,10.222,9.79228,9.86957,9.73196,8.14828,9.90393]

	@Base.Test.test isapprox(mean([abs(samples[i] - good_samples[i]) for i=1:size(good_samples)[1]+20]), 0, atol=1e-4)
	@Base.Test.test isapprox(mean([abs(llhoods[i] - good_llhoods[i]) for i=1:size(good_llhoods)[1]]), 0, atol=1e-4)
	
	obs_samples = Mads.forward(md, samples)
	newllhoods = Mads.reweighsamples(md, obs_samples, llhoods) # Use importance sampling to the 95% of the solutions, keeping the most likely solutions
	goodoprime = Mads.getimportantsamples(obs_samples, newllhoods)
#	s_mean, s_var = Mads.weightedstats(obs_samples, newllhoods)

	good_newllhoods = [-421.756,-168.511,0.0,-258.981,-312.968,-397.366,-385.802,-405.832,-555.08,-380.357]
	@Base.Test.test isapprox(mean([abs(newllhoods[i] - good_newllhoods[i]) for i=1:size(newllhoods)[1]]), 0, atol=1e-3)

#	inverse_parameters, inverse_results = Mads.calibraterandom(md, 1; maxEval=1, np_lambda=1, maxJacobians=1, all=true)
	inverse_parameters, inverse_results = Mads.calibraterandom(md, 2; maxEval=1, np_lambda=1, maxJacobians=1)
	Mads.calibraterandom_parallel(md, 2; maxEval=1, np_lambda=1, maxJacobians=1)
	inverse_predictions = Mads.forward(md, inverse_parameters) # execute forward model simulation based on calibrated values

	# Use only two wells - w13a and w20a
	Mads.allwellsoff!(md) # turn off all wells
	Mads.wellon!(md, "w13a") # use well w13a
	Mads.wellon!(md, "w20a") # use well w20a
	
	@Base.Test.test all(Mads.getwellsdata(md) .== [1608.0 2113.0; 1491.0 1479.0; 3.0 3.0])
	
	welldata_time = Mads.getwellsdata(md; time=true)

	# Sensitivity analysis: spaghetti plots based on prior parameter uncertainty ranges
	paramvalues = Mads.getparamrandom(md, 10)

	Mads.setobstime!(md, r"_(.*)")
	Mads.setobstime!(md)

	Mads.dumpwelldata(md, "wells.dat")
	Mads.rmfile("wells.dat")

	#plot_results(md, inverse_predictions, paramvalues)

	@Base.Test.test isapprox(mean([abs(Mads.computemass(md; time=50.0)[i] - (760.3462420637113,0)[i]) for i=1:2]), 0, atol=1e-5)
	@Base.Test.test isapprox(mean([abs(Mads.computemass(md)[i] - (760.3462420637113,0)[i]) for i=1:2]), 0, atol=1e-5)

	if Mads.create_tests
		d = joinpath(workdir, "test_results")
		Mads.mkdir(d)

		JLD.save(joinpath(d, "welldata_time.jld"), "welldata_time", welldata_time)
		JLD.save(joinpath(d, "inverse_predictions.jld"), "inverse_predictions", inverse_predictions)
	end

	good_welldata_time = JLD.load(joinpath(workdir, "test_results", "welldata_time.jld"), "welldata_time")
	good_inverse_preds = JLD.load(joinpath(workdir, "test_results", "inverse_predictions.jld"), "inverse_predictions")

	# Testing time-based well data against itself
	ssr = 0.
	for i=1:size(good_welldata_time)[1]
		for j=1:size(good_welldata_time)[2]
			ssr += (welldata_time[i*j] - good_welldata_time[i*j])^2
		end
	end
	@Base.Test.test isapprox(ssr, 0., atol=1e-8)

	# Testing inverse predictions against itself
	ssr = 0.
	for obskey in union(Set(keys(inverse_predictions)), Set(keys(good_inverse_preds)))
		ssr += (inverse_predictions[obskey] - good_inverse_preds[obskey])^2
	end
	@Base.Test.test isapprox(ssr, 0., atol=1e-8)

	@Mads.stdouterrcapture Mads.addsource!(md)
	@Mads.stdouterrcapture Mads.removesource!(md)
end
	
Mads.rmdir("w01-w13a_w20a_restart")