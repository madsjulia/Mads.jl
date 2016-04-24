import Mads

problemdir = Mads.getmadsdir() # get the directory where the problem is executed
if problemdir == ""
	problemdir = Mads.madsdir * "/../examples/bayesian_sampling/"
end

md = Mads.loadmadsfile(problemdir * "internal-linearmodel.mads")
rootname = Mads.getmadsrootname(md)

info("Bayesian sampling ...")
mcmcchain = Mads.bayessampling(md; nsteps=10000, burnin=1000, thinning=1, seed=2016)
Mads.scatterplotsamples(md, mcmcchain.value', rootname * "-bayes.svg")
Mads.savemcmcresults(mcmcchain, rootname * "-bayes.json")

info("Parallel Bayesian sampling ...")
mcmcchains = Mads.bayessampling(md, 2; nsteps=5000, burnin=500, thinning=1, seed=2016)
Mads.scatterplotsamples(md, vcat(map(chain->chain.value', mcmcchains)...), rootname * "-parallel-bayes.svg")
Mads.savemcmcresults(mcmcchains, rootname * "-parallel-bayes.json")

md = Mads.loadmadsfile(problemdir * "w01.mads")
rootname = Mads.getmadsrootname(md)

info("Calibrate a contaminant transport problem (anasol) ...")
param, results = Mads.calibrate(md)
f = Mads.forward(md, param)

info("Plot matches for a contaminant transport problem (anasol) ...")
Mads.plotmatches(md, f)

Mads.setparamsinit!(md, param)

info("Bayesian sampling of a contaminant transport problem (anasol) ...")
mcmcchain = Mads.bayessampling(md; nsteps=1000, burnin=100, thinning=1, seed=2016)
Mads.savemcmcresults(mcmcchain, rootname * "-bayes.json")

info("Bayesian scatter plots ...")
Mads.scatterplotsamples(md, mcmcchain.value', rootname * "-bayes.svg")

# convert the parameters in the chain to a parameter dictionary of arrays
mcmcvalues = Mads.paramarray2dict(md, mcmcchain.value') 

info("Posterior (Bayesian) spaghetti plots ...")
Mads.spaghettiplots(md, mcmcvalues, keyword="posterior")
Mads.spaghettiplot(md, mcmcvalues, keyword="posterior")

info("Prior spaghetti plots ...")
Mads.spaghettiplots(md, 100, keyword="prior")
Mads.spaghettiplot(md, 100, keyword="prior")

return