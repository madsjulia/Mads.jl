import Mads
import Lora

info("Bayesian sampling of contaminant transport problem ...")
problemdir = string((dirname(Base.source_path()))) * "/"

md = Mads.loadmadsfile(problemdir * "w01.mads")
chain = Mads.bayessampling(md; nsteps=1000, burnin=100, thinning=10)
Lora.describe(chain)
rootname = Mads.getmadsrootname(md)
Mads.scatterplotsamples(md, chain.samples, rootname * "-bayes-results.svg")
mcvalues = Mads.paramarray2dict(md, chain.samples) # convert the parameters in the chain samples to a parameter dictionary of arrays
Mads.spaghettiplots(md, mcvalues)
return