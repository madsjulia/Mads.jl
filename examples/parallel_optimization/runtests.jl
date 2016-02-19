import Mads
import Base.Test

workdir = Mads.getmadsdir() # get the directory where the problem is executed
if workdir == ""
	workdir = Mads.madsdir * "/../examples/parallel_optimization/"
end

info("External optimization ...")

md = Mads.loadmadsfile(workdir * "external-jld.mads")
jparam, jresults = Mads.calibrate(md, maxIter=2, maxJacobians=2)
# md = Mads.loadmadsfile(workdir * "external-yaml.mads")
# yparam, yresults = Mads.calibrate(md, maxIter=2, maxJacobians=2)

@test yparam == jparam