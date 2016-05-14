import Mads
using Base.Test

workdir = Mads.getmadsdir() # get the directory where the problem is executed
if workdir == ""
	workdir = Mads.madsdir * "/../examples/model_coupling"
end

Mads.madsinfo("Internal coupling using `Model` ...")
md = Mads.loadmadsfile(workdir * "internal-linearmodel.mads")
ifor = Mads.forward(md)
Mads.madsinfo("Internal coupling using `Julia command` ...")
md = Mads.loadmadsfile(workdir * "internal-linearmodel+template.mads")
tfor = Mads.forward(md)
Mads.madsinfo("Internal coupling using `MADS model` ...")
md = Mads.loadmadsfile(workdir * "internal-linearmodel-mads.mads")
mfor = Mads.forward(md)

@test ifor == tfor
@test ifor == mfor

Mads.madsinfo("External coupling using `Command` and JLD ...")
md = Mads.loadmadsfile(workdir * "external-jld.mads")
# jparam, jresults = Mads.calibrate(md)
jfor = Mads.forward(md)
Mads.madsinfo("External coupling using `Command` and JSON ...")
md = Mads.loadmadsfile(workdir * "external-json.mads")
# sparam, sresults = Mads.calibrate(md)
sfor = Mads.forward(md)
if !haskey(ENV, "MADS_NO_PYTHON")
	Mads.madsinfo("External coupling using `Command` and YAML ...")
	md = Mads.loadmadsfile(workdir * "external-yaml.mads")
	# yparam, yresults = Mads.calibrate(md)
	yfor = Mads.forward(md)
	@test yfor == jfor
end
# TODO ASCII does NOT work; `parameters` are not required to be Ordered Dictionary
# info("External coupling using ASCII ...")
# md = Mads.loadmadsfile(workdir * "external-ascii.mads")
# aparam, aresults = Mads.calibrate(md)
# afor = Mads.forward(md)

@test jfor == sfor
@test jfor == ifor