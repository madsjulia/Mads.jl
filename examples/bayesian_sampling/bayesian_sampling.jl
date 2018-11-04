import Mads

workdir = Mads.getmadsdir() # get the directory where the problem is executed
if workdir == "."
	workdir = joinpath(Mads.madsdir, "examples", "bayesian_sampling")
end

md = Mads.loadmadsfile(joinpath(workdir, "internal-linearmodel.mads"))
rootname = Mads.getmadsrootname(md)

@info("Bayesian sampling ...")
mcmcchain = Mads.bayessampling(md; nsteps=10000, burnin=1000, thinning=1, seed=2016)
Mads.scatterplotsamples(md, mcmcchain.value', rootname * "-bayes.png")
Mads.savemcmcresults(mcmcchain.value', rootname * "-bayes.json")

@info("Parallel Bayesian sampling ...")
mcmcchains = Mads.bayessampling(md, 2; nsteps=5000, burnin=500, thinning=1, seed=2016)
chain_array = vcat(map(chain->chain.value', mcmcchains)...)
Mads.scatterplotsamples(md, chain_array, rootname * "-parallel-bayes.png")
Mads.savemcmcresults(chain_array, rootname * "-parallel-bayes.json")

md = Mads.loadmadsfile(joinpath(workdir, "w01.mads"))
rootname = Mads.getmadsrootname(md)

@info("Calibrate a contaminant transport problem (anasol) ...")
param, results = Mads.calibrate(md)
f = Mads.forward(md, param)

@info("Plot matches for a contaminant transport problem (anasol) ...")
Mads.plotmatches(md, f)

Mads.setparamsinit!(md, param)

@info("Bayesian sampling of a contaminant transport problem (anasol) ...")
mcmcchain = Mads.bayessampling(md; nsteps=1000, burnin=100, thinning=1, seed=2016)
Mads.savemcmcresults(mcmcchain.value', rootname * "-bayes.json")

@info("Bayesian scatter plots ...")
Mads.scatterplotsamples(md, mcmcchain.value', rootname * "-bayes.png")

# convert the parameters in the chain to a parameter dictionary of arrays
mcmcvalues = Mads.paramarray2dict(md, mcmcchain.value')

@info("Posterior (Bayesian) spaghetti plots ...")
Mads.spaghettiplots(md, mcmcvalues; keyword="posterior", format="PNG", xtitle="Time", ytitle="Concentration [ppb]")
Mads.spaghettiplot(md, mcmcvalues; keyword="posterior", format="PNG", xtitle="Time", ytitle="Concentration [ppb]")

@info("Prior spaghetti plots ...")
Mads.spaghettiplots(md, 100; keyword="prior", format="PNG", xtitle="Time", ytitle="Concentration [ppb]")
Mads.spaghettiplot(md, 100; keyword="prior", format="PNG", xtitle="Time", ytitle="Concentration [ppb]")

return