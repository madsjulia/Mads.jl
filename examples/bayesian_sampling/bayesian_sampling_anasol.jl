import Mads

# setup the directory for the current Mads problem
workdir = Mads.getmadsdir() # get the directory where the problem is executed
if workdir == "."
	workdir = joinpath(Mads.madsdir, "examples", "bayesian_sampling")
end

# load Mads problem
md = Mads.loadmadsfile(joinpath(workdir, "w01.mads"))
rootname = Mads.getmadsrootname(md)
Mads.plotmadsproblem(md)

# calibrate the model to reproduce the observations
opt_param, opt_results = Mads.calibrate(md)

# set initial parameters based on the optimized values
Mads.setparamsinit!(md, opt_param)

# plot the matches between model predictions and observations
Mads.plotmatches(md)

Mads.madsinfo("Bayesian sampling of contaminant transport problem ...")
mcmcchains = Mads.bayessampling(md, seed=2016)

Mads.madsinfo("Bayesian scatter plots ...")
Mads.scatterplotsamples(md, mcmcchains.value', rootname * "-bayes-results.svg")
mcmcvalues = Mads.paramarray2dict(md, mcmcchains.value') # convert the parameters in the chain to a parameter dictionary of arrays

Mads.madsinfo("Bayesian spaghetti plots ...")
Mads.spaghettiplots(md, mcmcvalues)

return