import Mads

# external execution test using ASCII files
Mads.madsinfo("Levenberg-Marquardt optimization of an external problem using ASCII files ...")
workdir = Mads.getmadsdir() # get the directory where the problem is executed
if workdir == "."
	workdir = joinpath(Mads.madsdir, "examples", "optimization")
end
md = Mads.loadmadsfile(joinpath(workdir, "external-ascii.mads"))
results = Mads.calibrate(md, maxEval=2, maxJacobians=1, np_lambda=2)
