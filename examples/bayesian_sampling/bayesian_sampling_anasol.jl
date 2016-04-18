import Mads

problemdir = Mads.getmadsdir() # get the directory where the problem is executed
if problemdir == ""
	problemdir = Mads.madsdir * "/../examples/bayesian_sampling/"
end

md = Mads.loadmadsfile(problemdir * "w01.mads")

info("Bayesian sampling of contaminant transport problem ...")
mcmcchain = Mads.bayessampling(md)
info("Bayesian scatter plots ...")
Mads.scatterplotsamples(md, chain.value', rootname * "-bayes-results.svg")
mcmcvalues = Mads.paramarray2dict(md, chain.value') # convert the parameters in the chain to a parameter dictionary of arrays
info("Bayesian spaghetti plots ...")
Mads.spaghettiplots(md, mcmcvalues)

return