import Mads

info("Bayesian sampling ...")
problemdir = string((dirname(Base.source_path()))) * "/"

md = Mads.loadmadsfile(problemdir * "internal-linearmodel.mads")
mcmcchain = Mads.bayessampling(md)
Mads.scatterplotsamples(md, mcmcchain.samples, problemdir * "mcmcchain1.svg")
mcmcchain = Mads.bayessampling(md; nsteps=5, burnin=2)
Mads.scatterplotsamples(md, mcmcchain.samples, problemdir * "mcmcchain2.svg")
# mcmcchain = Mads.bayessampling(md, 4; nsteps=25, burnin=0)
# Mads.scatterplotsamples(md, mcmcchain.samples, problemdir * "mcmcchain3.svg")
return