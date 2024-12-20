import Mads
import Test
import OrderedCollections
import JSON
import JLD2
import JLD

if !Mads.createlinks
	@warn("Links cannot be created on Windows if not executed with admin privileges or in a developers mode!")
else
	Mads.@tryimportmain OrderedCollections
	Mads.@tryimportmain JSON
	Mads.@tryimportmain JLD2
	Mads.@tryimportmain YAML

	workdir = Mads.getproblemdir() # get the directory where the problem is executed
	if workdir == "."
		workdir = joinpath(Mads.dir, "examples", "model_coupling")
	end
	cwd = pwd()
	cd(workdir)

	Mads.madsinfo("Internal coupling using `Model` ...")
	mdof = Mads.loadmadsfile(joinpath(workdir, "internal-linearmodel-observations-filename.mads"))
	ffor = Mads.forward(mdof)
	mdos = Mads.loadmadsfile(joinpath(workdir, "internal-linearmodel-observations-script.mads"))
	sfor = Mads.forward(mdos)
	mdb = Mads.loadmadsfile(joinpath(workdir, "internal-linearmodel.mads"); bigfile=true)
	bfor = Mads.forward(mdb)
	md = Mads.loadmadsfile(joinpath(workdir, "internal-linearmodel.mads"))
	ifor = Mads.forward(md)
	Mads.forward(md, Dict())
	ip = Mads.getparamdict(md)
	pdict = Mads.getparamrandom(md, 5)
	Mads.setparamsinit!(md, pdict, 1)
	Mads.setparamsinit!(md, ip)
	parray = Mads.paramdict2array(pdict)
	Mads.forward(md, parray)
	Mads.setobstime!(md, "o")
	forwardpredresults = Mads.forward(md, pdict)

	if !haskey(ENV, "MADS_NO_GADFLY")
		Mads.graphoff()
		Mads.spaghettiplots(md, pdict)
		Mads.spaghettiplot(md, forwardpredresults)
		Mads.rmfile(joinpath(workdir, "..", "models", "internal-linear-model", "internal-linearmodel.finalresults"))
		Mads.rmfile(joinpath(workdir, "..", "models", "internal-linear-model", "internal-linearmodel.initialresults"))
		Mads.rmfile(joinpath(workdir, "..", "models", "internal-linear-model", "internal-linearmodel.iterationresults"))
		Mads.rmfiles_ext("jld2"; path=joinpath(workdir, "..", "models", "internal-linear-model"))
		Mads.rmfiles_ext("svg"; path=joinpath(workdir, "..", "models", "internal-linear-model"))
		Mads.rmdir(joinpath(workdir, "..", "models", "internal-linear-model", "internal-linearmodel_restart"))
		Mads.rmfiles_ext("svg"; path=joinpath(workdir, "external-linearmodel+template+instruction+path"))
		Mads.graphon()
	end

	Mads.madsinfo("Internal coupling using `Julia command` and `Templates` ...")
	md = Mads.loadmadsfile(joinpath(workdir, "internal-linearmodel+template.mads"))
	tifor = Mads.forward(md)

	Mads.madsinfo("Internal coupling using `Julia command`, `Templates` and respecting template space...")
	Mads.addkeyword!(md, "respect_space")
	tifor = Mads.forward(md)
	Mads.deletekeyword!(md, "respect_space")

	Mads.madsinfo("Internal coupling with `LogLikelihood` ...")
	md = Mads.loadmadsfile(joinpath(workdir, "internal-linearmodel-loglikelihood.mads"))
	chain, llhoods = Mads.emceesampling(md; numwalkers=5, nexecutions=25, burnin=1, thinning=1, seed=2018, sigma=0.01)

	Mads.madsinfo("Internal coupling with `ConditionalLogLikelihood` ...")
	md = Mads.loadmadsfile(joinpath(workdir, "internal-linearmodel-loglikelihood-conditional.mads"))
	chain, llhoods = Mads.emceesampling(md; numwalkers=5, nexecutions=25, burnin=1, thinning=1, seed=2018, sigma=0.01)

	Mads.madsinfo("External coupling using `MADS model`, `Templates` and `Instructions` ...")
	md = Mads.loadmadsfile(joinpath(workdir, "internal-linearmodel-madsmodel.mads"))
	mfor = Mads.forward(md)

	Mads.madsinfo("External coupling using `Command`, `Templates` and `Instructions` ...")
	md = Mads.loadmadsfile(joinpath(workdir, "external-linearmodel+template+instruction-l1.mads"))
	teforl1 = Mads.forward(md)

	Mads.madsinfo("External coupling using `Command`, `Templates` and `Instructions` ...")
	md = Mads.loadmadsfile(joinpath(workdir, "external-linearmodel+template+instruction.mads"))
	Mads.writeparameters(md)
	tefor = Mads.forward(md)

	md = Mads.loadmadsfile(joinpath("external-linearmodel+template+instruction+path", "external-linearmodel+template+instruction+path.mads"))
	Mads.forward(md)
	Mads.localsa(md; par=[1.,2.])
	# Mads.calibrate(md; maxEval=1, maxJacobians=1, np_lambda=1, localsa=true)
	Mads.savemadsfile(md, joinpath("external-linearmodel+template+instruction+path", "external-linearmodel+template+instruction+path2.mads"))

	Mads.createproblem(joinpath("external-linearmodel+template+instruction+path", "external-linearmodel+template+instruction+path.mads"), joinpath("external-linearmodel+template+instruction+path", "external-linearmodel+template+instruction+path2.mads"))
	Mads.rmfile(joinpath("external-linearmodel+template+instruction+path", "external-linearmodel+template+instruction+path2.mads"))
	pfor = Mads.forward(md)

	Test.@testset "Internal" begin
		Test.@test ifor == ffor
		Test.@test ifor == sfor
		Test.@test ifor == bfor
		Test.@test ifor == tifor
		Test.@test ifor == mfor
		Test.@test ifor == tefor
		Test.@test ifor == teforl1
		Test.@test ifor == pfor
	end

	Mads.readyamlpredictions(joinpath(workdir, "internal-linearmodel-madsmodel.mads"))
	Mads.readasciipredictions(joinpath(workdir, "readasciipredictions.dat"))

	Mads.madsinfo("External coupling using `Command` and JLD ...")
	md = Mads.loadmadsfile(joinpath(workdir, "external-linearmodel-jld.mads"))
	jfor = Mads.forward(md)

	Mads.madsinfo("External coupling using `Command` and JLD2 ...")
	md = Mads.loadmadsfile(joinpath(workdir, "external-linearmodel-jld2.mads"))
	j2for = Mads.forward(md)
	Mads.set_nprocs_per_task(2)
	Mads.forward(md)
	Mads.set_nprocs_per_task(1)

	Mads.madsinfo("External coupling using `Command` and JSON ...")
	md = Mads.loadmadsfile(joinpath(workdir, "external-linearmodel-json.mads"))
	sfor = Mads.forward(md)

	Mads.madsinfo("External coupling using `Command` and JSON ...")
	md = Mads.loadmadsfile(joinpath(workdir, "external-linearmodel-json-exp.mads"))
	efor = Mads.forward(md)

	Mads.madsinfo("External coupling using `Command` and YAML ...")
	md = Mads.loadmadsfile(joinpath(workdir, "external-linearmodel-yaml.mads"))
	yfor = Mads.forward(md)
	Test.@test yfor == j2for

	Mads.madsinfo("External coupling using ASCII ...")
	md = Mads.loadmadsfile(joinpath(workdir, "external-linearmodel-ascii.mads"))
	afor = Mads.forward(md)
	# aparam, aresults = Mads.calibrate(md; maxEval=1, np_lambda=1, maxJacobians=1)

	md = Mads.loadmadsfile(joinpath(workdir, "external-linearmodel-matrix.mads"))
	md["Instructions"] = [Dict("ins"=>"external-linearmodel-matrix.inst", "read"=>"model_coupling_matrix.dat")]
	md["Observations"] = Mads.createobservations(10, 2, pretext="l4\n", prestring="!dum! !dum!", filename=joinpath(workdir, "external-linearmodel-matrix.inst"))
	ro1 = Mads.readobservations(md)
	md["Observations"] = Mads.createobservations(10, 2, pretext="\n\n\n\n", prestring="!dum! !dum!", filename=joinpath(workdir, "external-linearmodel-matrix.inst"))
	ro2 = Mads.readobservations(md)
	Mads.rmfile("external-linearmodel-matrix.inst")

	Test.@testset "External" begin
		Test.@test afor == sfor
		Test.@test j2for == sfor
		# Test.@test j2for == jfor
		Test.@test efor == sfor
		Test.@test j2for == ifor
		Test.@test ro1 == ro2
	end

	function juliafunction(parameters::AbstractVector)
		f(t) = parameters[1] * t - parameters[2] # a * t - b
		times = 1:4
		predictions = map(f, times)
		return predictions
	end

	md = Mads.createproblem([1,2], [1,2,3,4], juliafunction; parammin=[-10,-10], parammax=[10,10])
	Mads.forward(md)
	Mads.calibrate(md)

	include(joinpath(workdir, "internal-linearmodel-juliafunction.jl"))
	md = Mads.loadmadsfile(joinpath(workdir, "internal-linearmodel-juliafunction.mads"))
	if typeof(md["Julia function"]) <: Function
		Mads.forward(md)
		Mads.calibrate(md)
	end

	@info("Deleting files and directories created during the tests...")
	Mads.rmdir(joinpath(workdir, "external-jld_restart"))
	Mads.rmdir(joinpath(workdir, "external-json-exp_restart"))
	Mads.rmdir(joinpath(workdir, "external-json_restart"))
	Mads.rmdir(joinpath(workdir, "external-linearmodel+template+instruction+path_restart"))
	Mads.rmdir(joinpath(workdir, "internal-linearmodel+template_restart"))
	Mads.rmdir(joinpath(workdir, "internal-linearmodel_restart"))
	Mads.rmdir(joinpath(workdir, "external-linearmodel+template+instruction_restart"))
	Mads.rmdir(joinpath(workdir, "internal-linearmodel+template_restart"))
	Mads.rmdir(joinpath(workdir, "internal-linearmodel-mads_restart"))
	Mads.rmdir(joinpath(workdir, "internal-linearmodel_restart"))
	Mads.rmfiles_ext("svg"; path=joinpath(workdir, "external-linearmodel+template+instruction+path"))
	Mads.rmfiles_ext("dat"; path=joinpath(workdir, "external-linearmodel+template+instruction+path"))
	Mads.rmfiles_ext("iterationresults"; path=joinpath(workdir, "external-linearmodel+template+instruction+path"))
	Mads.rmfiles_ext("jld2"; path=joinpath(workdir, "..", "models", "internal-polynomial-model"))
	Mads.rmfiles_ext("jld2"; path=joinpath(workdir, "..", "models", "internal-linear-model"))
	@info("Model coupling tests done!")
	cd(cwd)
end

:done