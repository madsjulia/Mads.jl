import Mads

Mads.madsinfo("Levenberg-Marquardt optimization of an internal call problem using templates and Julia script to parse the model outputs:")
workdir = Mads.getmadsdir() # get the directory where the problem is executed
if workdir == ""
	workdir = joinpath(Mads.madsdir, "..", "examples", "optimization")
end
md = Mads.loadmadsfile(joinpath(workdir, "internal-linearmodel+template.mads"))
results = Mads.calibrate(md, maxEval=2, maxJacobians=1, np_lambda=2)
return