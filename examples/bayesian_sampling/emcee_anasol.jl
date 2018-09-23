import Mads

# setup the directory for the current Mads problem
workdir = Mads.getmadsdir() # get the directory where the problem is executed
if workdir == "."
	workdir = joinpath(Mads.madsdir, "examples", "bayesian_sampling")
end

# load Mads problem
md = Mads.loadmadsfile(joinpath(workdir, "w01.mads"))
rootname = Mads.getmadsrootname(md)

# calibrate the model to reproduce the observations
opt_param, opt_results = Mads.calibrate(md)

# set initial parameters based on the optimized values
Mads.setparamsinit!(md, opt_param)

Mads.madsinfo("Bayesian sampling of contaminant transport problem ...")
chain, llhoods = Mads.emcee(md)

Mads.madsinfo("Bayesian scatter plots ...")
Mads.scatterplotsamples(md, chain', rootname * "-emcee-results.svg")

return
