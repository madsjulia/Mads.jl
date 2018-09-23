import Mads

Mads.madsinfo("Levenberg-Marquardt optimization of an external problem using YAML files ...")
workdir = Mads.getmadsdir() # get the directory where the problem is executed
if workdir == "."
	workdir = joinpath(Mads.madsdir, "examples", "optimization")
end
md = Mads.loadmadsfile(joinpath(workdir, "external-yaml.mads"))
results = Mads.calibrate(md, maxEval=2, maxJacobians=1, np_lambda=1)
