import Mads

workdir = Mads.getmadsdir() # get the directory where the problem is executed
if workdir == ""
	workdir = joinpath(Mads.madsdir, "..", "examples", "contamination")
end

md = Mads.loadmadsfile(joinpath(workdir, "w01-w13a_w20a.mads")) # load Mads input file into Julia Dictionary
rootname = Mads.getmadsrootname(md) # get problem rootname

if isdefined(:Gadfly)
	Mads.plotmadsproblem(md) # display the well locations and the initial source location
end

forward_predictions = Mads.forward(md) # execute forward model simulation based on initial parameter guesses

param_values = Mads.getoptparams(md) # inital parameter values

of = Mads.partialof(md, forward_predictions, r".*")

if isdefined(:Gadfly)
	Mads.plotmatches(md, forward_predictions) # plot initial matches
	Mads.rmfile(joinpath(workdir, "w01-w13a_w20a-match.svg"))
end

inverse_parameters, inverse_results = Mads.calibrate(md, maxEval=1, np_lambda=1, maxJacobians=1) # perform model calibration

param_values = Mads.getoptparams(md, collect(values(inverse_parameters)))
forward_predictions = Mads.forward(md, inverse_parameters) # execute forward model simulation based on optimal model parameter estimates

localsa_results = Mads.localsa(md, datafiles=false, imagefiles=false, par=collect(values(inverse_parameters)), obs=collect(values(forward_predictions))) # perform local sensitivity analysis

Mads.stdoutcaptureon()

Mads.modelinformationcriteria(md)

Mads.stdoutcaptureoff();

samples, llhoods = Mads.sampling(param_values, localsa_results["jacobian"], 10, seed=2016, scale=0.5) # sampling for local uncertainty analysis

obs_samples = Mads.forward(md, samples)

newllhoods = Mads.reweighsamples(md, obs_samples, llhoods) # Use importance sampling to the 95% of the solutions, keeping the most likely solutions
goodoprime = Mads.getimportantsamples(obs_samples, newllhoods)
s_mean, s_var = Mads.weightedstats(obs_samples, newllhoods)

inverse_parameters, inverse_results = Mads.calibraterandom(md, 1; maxEval=1, np_lambda=1, maxJacobians=1)
Mads.calibraterandom_parallel(md, 1; maxEval=1, np_lambda=1, maxJacobians=1)

inverse_predictions = Mads.forward(md, inverse_parameters) # execute forward model simulation based on calibrated values

if isdefined(:Gadfly)
	Mads.plotmatches(md, inverse_predictions) # plot calibrated matches
	Mads.rmfile(joinpath(workdir, "w01-w13a_w20a-match.svg"))
end

# use only two wells
Mads.allwellsoff!(md) # turn off all wells
Mads.wellon!(md, "w13a") # use well w13a
Mads.wellon!(md, "w20a") # use well w20a
Mads.getwellsdata(md)
Mads.getwellsdata(md; time=true)

# Sensitivity analysis: spaghetti plots based on prior parameter uncertainty ranges
paramvalues = Mads.getparamrandom(md, 10)

if isdefined(:Gadfly)
	Mads.spaghettiplots(md, paramvalues, keyword="w13a_w20a")
	Mads.spaghettiplot(md, paramvalues, keyword="w13a_w20a")
	s = splitdir(rootname)
	for f in Mads.searchdir(Regex(string(s[2], "-w13a_w20a", "\.*", "spaghetti.svg")), path=s[1])
		Mads.rmfile(f, path=s[1])
	end

end

Mads.setobstime!(md, r"_(.*)")
Mads.setobstime!(md)

Mads.dumpwelldata(md, "wells.dat")
Mads.rmfile("wells.dat")

if isdefined(:Gadfly)
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

Mads.computemass(md; time=50.0)

Mads.addsource!(md)