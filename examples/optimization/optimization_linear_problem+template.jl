using Mads

info("Levenberg-Marquardt optimization of an internal call problem using templates and Julia script to parse the model outputs:")
problemdir = string((dirname(Base.source_path()))) * "/"
md = Mads.loadmadsfile(problemdir * "internal-linearmodel+template.mads")
results = Mads.calibrate(md, maxEval=2, maxIter=1, maxJacobians=1, np_lambda=2)
