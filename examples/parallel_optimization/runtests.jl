import Mads
import Base.Test

workdir = Mads.getmadsdir() # get the directory where the problem is executed
if workdir == ""
	workdir = Mads.madsdir * "/../examples/parallel_optimization/"
end

md = Mads.loadmadsfile(workdir * "external-yaml.mads")
yparam, yresults = Mads.calibrate(md)
md = Mads.loadmadsfile(workdir * "external-jld.mads")
jparam, jresults = Mads.calibrate(md)

@test yparam == jparam