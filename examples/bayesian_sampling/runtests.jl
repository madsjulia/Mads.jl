import Mads

info("Bayesian sampling ...")
workdir = Mads.getmadsdir() # get the directory where the problem is executed
if workdir == ""
	workdir = Mads.madsdir * "/../examples/bayesian_sampling/"
end

md = Mads.loadmadsfile(workdir * "internal-linearmodel.mads")
rootname = Mads.getmadsrootname(md)
mcmcchain = Mads.bayessampling(md; nsteps=10, burnin=10, thinning=10)
Mads.scatterplotsamples(md, mcmcchain.samples, workdir * rootname * "-mcmcchain1.svg")
mcmcchain = Mads.bayessampling(md; nsteps=5, burnin=2)
Mads.scatterplotsamples(md, mcmcchain.samples, workdir * "mcmcchain2.svg")
mcmcchains = Mads.bayessampling(md, 2; nsteps=10, burnin=0)
Mads.scatterplotsamples(md, vcat(map(chain->chain.samples, mcmcchains)...), workdir * rootname * "mcmcchain3.svg")

md = Mads.loadmadsfile(workdir * "w01.mads")
rootname = Mads.getmadsrootname(md)
chain = Mads.bayessampling(md; nsteps=10, burnin=10, thinning=10)
# Lora.describe(chain)
Mads.scatterplotsamples(md, chain.samples, workdir * rootname * "-bayes-results.svg")
mcvalues = Mads.paramarray2dict(md, chain.samples) # convert the parameters in the chain samples to a parameter dictionary of arrays
Mads.spaghettiplots(md, mcvalues)

return
