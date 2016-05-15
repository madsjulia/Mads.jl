using Mads

Mads.madsinfo("Levenberg-Marquardt optimization of an internal problem:")
problemdir = string((dirname(Base.source_path())))*"/"

md = Mads.loadmadsfile(problemdir*"internal-linearmodel.mads")
results = Mads.calibrate(md, maxEval=2, maxJacobians=1, np_lambda=1)
return