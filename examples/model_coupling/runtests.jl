import Mads
import Base.Test

workdir = Mads.getmadsdir() # get the directory where the problem is executed
if workdir == ""
    workdir = joinpath(Mads.madsdir, "..", "examples", "model_coupling")
end

Mads.madsinfo("Internal coupling using `Model` ...")
md = Mads.loadmadsfile(joinpath(workdir, "internal-linearmodel.mads"))
ifor = Mads.forward(md)
Mads.forward(md, Dict())
pdict = Mads.getparamrandom(md, 5)
parray = Mads.paramdict2array(pdict)
Mads.forward(md, parray)
Mads.setobstime!(md, "o")
f = Mads.forward(md, pdict)
if isdefined(:Gadfly)
    Mads.spaghettiplots(md, pdict)
    Mads.spaghettiplot(md, f)
end

Mads.madsinfo("Internal coupling using `Julia command` and `Templates` ...")
md = Mads.loadmadsfile(joinpath(workdir,  "internal-linearmodel+template.mads"))
tfor = Mads.forward(md)
Mads.madsinfo("Internal coupling using `Julia command`, `Templates` and `Instructions` ...")
md = Mads.loadmadsfile(joinpath(workdir, "internal-linearmodel+template+instruction.mads"))
tifor = Mads.forward(md)
Mads.madsinfo("Internal coupling using `MADS model` ...")
md = Mads.loadmadsfile(joinpath(workdir, "internal-linearmodel-mads.mads"))
mfor = Mads.forward(md)

@Base.Test.test ifor == tfor
@Base.Test.test ifor == tifor
@Base.Test.test ifor == mfor

Mads.readyamlpredictions("$workdir/internal-linearmodel-mads.mads"; julia=true)
Mads.readasciipredictions("$workdir/readasciipredictions.dat")

Mads.madsinfo("External coupling using `Command` and JLD ...")
md = Mads.loadmadsfile(joinpath(workdir, "external-jld.mads"))
# jparam, jresults = Mads.calibrate(md)
jfor = Mads.forward(md)
Mads.madsinfo("External coupling using `Command` and JSON ...")
md = Mads.loadmadsfile(joinpath(workdir, "external-json.mads"))
# sparam, sresults = Mads.calibrate(md)
sfor = Mads.forward(md)
Mads.madsinfo("External coupling using `Command` and JSON ...")
md = Mads.loadmadsfile(joinpath(workdir, "external-json-exp.mads"))
# sparam, sresults = Mads.calibrate(md)
efor = Mads.forward(md)
if !haskey(ENV, "MADS_NO_PYTHON")
	Mads.madsinfo("External coupling using `Command` and YAML ...")
	md = Mads.loadmadsfile(joinpath(workdir, "external-yaml.mads"))
	# yparam, yresults = Mads.calibrate(md)
	yfor = Mads.forward(md)
	@Base.Test.test yfor == jfor
end
# TODO ASCII does NOT work; `parameters` are not required to be Ordered Dictionary
# info("External coupling using ASCII ...")
# md = Mads.loadmadsfile(workdir * "external-ascii.mads")
# aparam, aresults = Mads.calibrate(md)
# afor = Mads.forward(md)

@Base.Test.test jfor == sfor
@Base.Test.test efor == sfor
@Base.Test.test jfor == ifor