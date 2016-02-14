import Mads
import Base.Test

workdir = Mads.getmadsdir() # get the directory where the problem is executed
if workdir == ""
	workdir = Mads.madsdir * "/../examples/model_coupling"
end

md = Mads.loadmadsfile(workdir * "external-yaml.mads")
yparam, yresults = Mads.calibrate(md)
md = Mads.loadmadsfile(workdir * "external-jld.mads")
jparam, jresults = Mads.calibrate(md)
md = Mads.loadmadsfile(workdir * "external-ascii.mads")
aparam, aresults = Mads.calibrate(md)
md = Mads.loadmadsfile(workdir * "external-json.mads")
sparam, sresults = Mads.calibrate(md)

@test yparam == jparam