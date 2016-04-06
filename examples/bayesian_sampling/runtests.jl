import Mads

info("Bayesian sampling ...")

workdir = Mads.getmadsdir() # get the directory where the problem is executed
if workdir == ""
	workdir = Mads.madsdir * "/../examples/bayesian_sampling/"
end

md = Mads.loadmadsfile(workdir * "internal-linearmodel.mads")
rootname = Mads.getmadsrootname(md)
mcmcchain = Mads.bayessampling(md; nsteps=10, burnin=1, thinning=1)
Mads.savemcmcresults(mcmcchain, rootname * "-test-mcmcchain1.json")
if !haskey(ENV, "MADS_NO_PLOT")
	Mads.scatterplotsamples(md, mcmcchain.value', rootname * "-test-mcmcchain1.svg")
end
mcmcchains = Mads.bayessampling(md, 2; nsteps=10, burnin=1, thinning=1)
values = vcat(map(chain->chain.value', mcmcchains)...)
if !haskey(ENV, "MADS_NO_PLOT")
	Mads.scatterplotsamples(md, values, rootname * "-test-mcmcchain3.svg")
end

md = Mads.loadmadsfile(workdir * "w01.mads")
rootname = Mads.getmadsrootname(md)
mcmcchain = Mads.bayessampling(md; nsteps=10, burnin=1, thinning=1)
if !haskey(ENV, "MADS_NO_PLOT")
	Mads.scatterplotsamples(md, mcmcchain.value', rootname * "-test-bayes-results.svg")
	mcmcvalues = Mads.paramarray2dict(md, mcmcchain.value') # convert the parameters in the chain to a parameter dictionary of arrays
	Mads.spaghettiplots(md, mcmcvalues, keyword="test")
	Mads.spaghettiplot(md, mcmcvalues, keyword="test")
	Mads.spaghettiplots(md, 3, keyword="test")
	Mads.spaghettiplot(md, 3, keyword="test")
	s = rootname
	run(`bash -c "rm -f $(s)*-test-*.svg"`)
end
return
