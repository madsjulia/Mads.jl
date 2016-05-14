using Mads

Mads.madsinfo("Levenberg-Marquardt optimization of an internal call problem using templates and Julia script to parse the model outputs:")
problemdir = string((dirname(Base.source_path()))) * "/"

md = Mads.loadmadsfile(problemdir * "internal-linearmodel+template.mads")
results = Mads.calibrate(md, maxEval=2, maxJacobians=1, np_lambda=2)
return