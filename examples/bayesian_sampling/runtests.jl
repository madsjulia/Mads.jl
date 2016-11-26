import Mads

Mads.madsinfo("Bayesian sampling ...")

workdir = Mads.getmadsdir() # get the directory where the problem is executed
if workdir == ""
	workdir = Mads.madsdir * "/../examples/bayesian_sampling/"
end

md = Mads.loadmadsfile(workdir * "internal-linearmodel.mads")
rootname = Mads.getmadsrootname(md)
mcmcchain = Mads.bayessampling(md; nsteps=10, burnin=1, thinning=1, seed=2016)
Mads.savemcmcresults(mcmcchain.value', rootname * "-test-mcmcchain1.json")
rm(rootname * "-test-mcmcchain1.json")
Mads.forward(md, mcmcchain.value)

mcmcchains = Mads.emceesampling(md; numwalkers=2, nsteps=10, burnin=2, thinning=1, seed=2016)
mcmcchains = Mads.bayessampling(md, 2; nsteps=10, burnin=1, thinning=1, seed=2016)

md = Mads.loadmadsfile(workdir * "w01.mads")
rootname = Mads.getmadsrootname(md)
mcmcchain = Mads.bayessampling(md; nsteps=10, burnin=1, thinning=1, seed=2016)
mcmcvalues = Mads.paramarray2dict(md, mcmcchain.value') # convert the parameters in the chain to a parameter dictionary of arrays
Mads.forward(md, mcmcchain.value)
if isdefined(:Gadfly)
	Mads.scatterplotsamples(md, mcmcchain.value', rootname * "-test-bayes-results.svg")
	Mads.spaghettiplots(md, mcmcvalues, keyword="test", obs_plot_dots=true)
	Mads.spaghettiplot(md, mcmcvalues, keyword="test")
	Mads.spaghettiplots(md, 3, keyword="test")
	Mads.spaghettiplot(md, 3, keyword="test")
	s = rootname
	run(`bash -c "rm -f $(s)*-test-*.svg"`)
end