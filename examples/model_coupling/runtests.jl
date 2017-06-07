import Mads
import Base.Test

workdir = Mads.getmadsdir() # get the directory where the problem is executed
if workdir == "."
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
forwardpredresults = Mads.forward(md, pdict)

if isdefined(:Gadfly) && !haskey(ENV, "MADS_NO_GADFLY")
	Mads.spaghettiplots(md, pdict)
	Mads.spaghettiplot(md, forwardpredresults)
	Mads.rmfile(joinpath(workdir, "internal-linearmodel-5-spaghetti.svg"))
	Mads.rmfile(joinpath(workdir, "internal-linearmodel-a-5-spaghetti.svg"))
	Mads.rmfile(joinpath(workdir, "internal-linearmodel-b-5-spaghetti.svg"))
end

Mads.madsinfo("Internal coupling using `Julia command` and `Templates` ...")
md = Mads.loadmadsfile(joinpath(workdir,  "internal-linearmodel+template.mads"))
tifor = Mads.forward(md)
Mads.madsinfo("Internal coupling using `Julia command`, `Templates` and respecting template space...")
Mads.addkeyword!(md, "respect_space")
tifor = Mads.forward(md)
Mads.deletekeyword!(md, "respect_space")
Mads.madsinfo("Internal coupling using `MADS model` ...")
md = Mads.loadmadsfile(joinpath(workdir, "internal-linearmodel-mads.mads"))
mfor = Mads.forward(md)
Mads.madsinfo("External coupling using `Command`, `Templates` and `Instructions` ...")
md = Mads.loadmadsfile(joinpath(workdir, "external-linearmodel+template+instruction+l1.mads"))
teforl1 = Mads.forward(md)
Mads.madsinfo("External coupling using `Command`, `Templates` and `Instructions` ...")
md = Mads.loadmadsfile(joinpath(workdir, "external-linearmodel+template+instruction.mads"))
tefor = Mads.forward(md)

cd(workdir)
md = Mads.loadmadsfile(joinpath("external-linearmodel+template+instruction+path",  "external-linearmodel+template+instruction+path.mads"))
Mads.savemadsfile(md, joinpath("external-linearmodel+template+instruction+path",  "external-linearmodel+template+instruction+path2.mads"))

Mads.createmadsproblem(joinpath("external-linearmodel+template+instruction+path",  "external-linearmodel+template+instruction+path.mads"), joinpath("external-linearmodel+template+instruction+path",  "external-linearmodel+template+instruction+path2.mads"))
Mads.rmfile(joinpath("external-linearmodel+template+instruction+path",  "external-linearmodel+template+instruction+path2.mads"))
pfor = Mads.forward(md)

@Base.Test.testset "Internal" begin
	@Base.Test.test ifor == tifor
	@Base.Test.test ifor == mfor
	@Base.Test.test ifor == tefor
	@Base.Test.test ifor == teforl1
	@Base.Test.test ifor == pfor
end

Mads.readyamlpredictions(joinpath(workdir, "internal-linearmodel-mads.mads"); julia=true)
Mads.readasciipredictions(joinpath(workdir, "readasciipredictions.dat"))

Mads.madsinfo("External coupling using `Command` and JLD ...")
md = Mads.loadmadsfile(joinpath(workdir, "external-jld.mads"))
jfor = Mads.forward(md)
Mads.set_nprocs_per_task(2)
@Mads.stdouterrcapture Mads.forward(md)
Mads.set_nprocs_per_task(1)
Mads.madsinfo("External coupling using `Command` and JSON ...")
md = Mads.loadmadsfile(joinpath(workdir, "external-json.mads"))
sfor = Mads.forward(md)
Mads.madsinfo("External coupling using `Command` and JSON ...")
md = Mads.loadmadsfile(joinpath(workdir, "external-json-exp.mads"))
efor = Mads.forward(md)

if !haskey(ENV, "MADS_NO_PYTHON") && isdefined(Mads, :yaml)
	Mads.madsinfo("External coupling using `Command` and YAML ...")
	md = Mads.loadmadsfile(joinpath(workdir, "external-yaml.mads"))
	yfor = Mads.forward(md)
	@Base.Test.test yfor == jfor
end
# TODO ASCII does NOT work; `parameters` are not required to be Ordered Dictionary
Mads.madsinfo("External coupling using ASCII ...")
md = Mads.loadmadsfile(joinpath(workdir, "external-ascii.mads"))
aparam, aresults = Mads.calibrate(md; maxEval=1, np_lambda=1, maxJacobians=1)
afor = Mads.forward(md)

@Base.Test.testset "External" begin
	@Base.Test.test jfor == sfor
	@Base.Test.test efor == sfor
	@Base.Test.test jfor == ifor
end

Mads.rmdir(joinpath(workdir, "external-jld_restart"))
Mads.rmdir(joinpath(workdir, "external-json-exp_restart"))
Mads.rmdir(joinpath(workdir, "external-json_restart"))
Mads.rmdir(joinpath(workdir, "external-linearmodel+template+instruction+path_restart"))
Mads.rmdir(joinpath(workdir, "internal-linearmodel+template_restart"))
Mads.rmdir(joinpath(workdir, "internal-linearmodel_restart"))
Mads.rmdir("external-linearmodel+template+instruction_restart")
Mads.rmdir("internal-linearmodel+template_restart")
Mads.rmdir("internal-linearmodel-mads_restart")
Mads.rmdir("internal-linearmodel_restart")
