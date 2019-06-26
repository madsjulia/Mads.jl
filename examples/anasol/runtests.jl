import Mads
@Mads.tryimportmain OrderedCollections
import JLD2
import FileIO
import Random
import Test

Random.seed!(2017)

workdir = joinpath(Mads.madsdir, "examples", "anasol")
md = Mads.loadmadsfile(joinpath(workdir, "w01shortexpplus.mads"))
computeconcentrations = Mads.makecomputeconcentrations(md)
computeconcentrations()
Mads.calibrate(md; maxEval=1, maxJacobians=1, np_lambda=1, usenaive=true, save_results=false)
md = Mads.loadmadsfile(joinpath(workdir, "w01shortexp.mads"))
forward_results = Mads.forward(md, all=true)
paramrandom_true = Mads.getparamrandom(md, 5, init_dist=true)
paramrandom_false = Mads.getparamrandom(md, 5, init_dist=false)
md = Mads.loadmadsfile(joinpath(workdir, "w01short.mads"))
computeconcentrations = Mads.makecomputeconcentrations(md)
paramdict = Dict(zip(Mads.getparamkeys(md), Mads.getparamsinit(md)))
forward_preds = computeconcentrations(paramdict)
fp = Mads.forward(md; all=true)
rp = Mads.getoptparams(md)
sp = Mads.asinetransform(md, rp)
rp2 = Mads.sinetransform(md, sp)

if isdefined(Mads, :Gadfly) && !haskey(ENV, "MADS_NO_GADFLY")
	Mads.graphoff()
	Mads.plotmadsproblem(md, keyword="test")
	Mads.plotmatches(md; display=false)
	Mads.plotmatches(md, Mads.getparamdict(md); separate_files=true, display=false)
	Mads.plotmatches(md, Mads.getparamdict(md); separate_files=true, display=false, filename="w01short-match.svg")
	Mads.plotmatches(md, fp; noise=0.1, display=false)
	Mads.plotmatches(md, fp, r"w1a"; display=false)
	# Mads.display(joinpath(workdir, "w01short-match-w1a.svg"))
	Mads.rmfile(joinpath(workdir, "w01short-match-w1a.svg"))
	Mads.rmfile(joinpath(workdir, "w01short-match.svg"))
	Mads.spaghettiplots(md, 2)
	Mads.rmfile(joinpath(workdir, "w01short-ax-2-spaghetti.svg"))
	Mads.rmfile(joinpath(workdir, "w01short-vx-2-spaghetti.svg"))
	Mads.plotmass([1.,2.],[10.,20.],[5.,10.], joinpath(workdir, "plotmass-test.svg"))
	Mads.rmfile(joinpath(workdir, "plotmass-test.svg"))
	Mads.graphon()
end

Mads.montecarlo(md; N=2)
Mads.forwardgrid(md)
if isdefined(Mads, :plotgrid)
	try
		Mads.graphoff()
		Mads.plotgrid(md)
		Mads.plotgrid(md; title="Grid")
		global s = Mads.forwardgrid(md)
		delete!(md, "Grid")
		@Mads.stdouterrcapture Mads.plotgrid(md, s)
		@Mads.stdouterrcapture Mads.plotgrid(md)
		Mads.graphon()
	catch errmsg
		Mads.printerrormsg(errmsg)
		@warn("PyPlot problem!")
	end
end
madsOf = Mads.of(md)
residuals_results = Mads.residuals(md)
Mads.residuals(md, fp)
pd = Mads.getparamdict(md)
sk = Mads.getsourcekeys(md)
m1 = Mads.getparamsmin(md)
m2 = Mads.getparamsmax(md)
m3 = Mads.getparamsinit_min(md)
m4 = Mads.getparamsinit_max(md)
Mads.setparamsinit!(md, pd)
Mads.setallparamsoff!(md)
Mads.setallparamson!(md)
Mads.setparamoff!(md, "vx")
Mads.setparamon!(md, "vx")
tk = Mads.gettargetkeys(md)
Mads.settarget!(md["Observations"][tk[1]], 1)

o1 = Mads.indexkeys(md["Observations"], "o")
o2 = Mads.indexkeys(md["Observations"], r"o")

Mads.setobstime!(md, "_")
Mads.setobstime!(md, r"[A-x]*_([0-9,.]+)")
Mads.invwellweights!(md, 1)
Mads.modwellweights!(md, 1)
Mads.setwellweights!(md, 1)
Mads.setobservationtargets!(md, forward_preds)
Mads.createmadsproblem(joinpath(workdir, "w01short.mads"), joinpath(workdir, "test.mads"))
Mads.createmadsproblem(md, forward_preds, joinpath(workdir, "test.mads"))
Mads.createmadsproblem(md, joinpath(workdir, "test.mads"))
Mads.allwellsoff!(md)
Mads.allwellson!(md)
Mads.welloff!(md, "w1a")
Mads.wellon!(md, "w1a")
Mads.savemadsfile(md, joinpath(workdir, "test.mads"))
Mads.savemadsfile(md, Mads.getparamdict(md))
Mads.savemadsfile(md, Mads.getparamdict(md), joinpath(workdir, "test.mads"))
Mads.savemadsfile(md, Mads.getparamdict(md), joinpath(workdir, "test.mads"), explicit=true)
Mads.rmfile(joinpath(workdir, "w01shortexp-rerun.mads"))
Mads.rmfile(joinpath(workdir, "test.mads"))
Mads.setmadsinputfile("test.mads")

@Test.testset "Observations" begin
	@Test.test isapprox(rp, rp2)
	@Test.test Mads.gettime(md["Observations"][tk[1]]) == 1
	@Test.test Mads.getweight(md["Observations"][tk[1]]) == 1

	@Test.test o1 == o2

	@Test.test Mads.getmadsinputfile() == "test.mads"
	@Test.test Mads.getextension("test.mads") == "mads"

	@Test.test Mads.getrootname("w01short3-rerun.mads"; version=true) == "w01short3"
end

Mads.stdoutcaptureon()
Mads.showparameters(md)
Mads.showallparameters(md)
Mads.showallparameters(md)
Mads.showobservations(md)
Mads.stdoutcaptureoff();

mdbad = deepcopy(md)
Mads.setparamsdistnormal!(mdbad, fill(1, length(m1)), fill(2, length(m1)))
Mads.setparamsdistuniform!(mdbad, fill(1, length(m1)), fill(2, length(m1)))

Mads.computemass("w01lambda", time=50, path=workdir)
Mads.rmdir(joinpath(workdir, "mass_reduced.svg"))

d = joinpath(workdir, "test_results")

if Mads.create_tests
	@info "save"
	Mads.mkdir(d)
	FileIO.save(joinpath(d, "goodresults.jld2"), "forward_preds", forward_preds)
	FileIO.save(joinpath(d, "forward_results.jld2"), "forward_results", forward_results)
	FileIO.save(joinpath(d, "paramrandom_true.jld2"), "paramrandom_true", paramrandom_true)
	FileIO.save(joinpath(d, "paramrandom_false.jld2"), "paramrandom_false", paramrandom_false)
	FileIO.save(joinpath(d, "residuals.jld2"), "residuals_results", residuals_results)
	FileIO.save(joinpath(d, "paramdict.jld2"), "pd", pd)
	FileIO.save(joinpath(d, "params_min.jld2"), "m1", m1)
	FileIO.save(joinpath(d, "params_max.jld2"), "m2", m2)
	FileIO.save(joinpath(d, "params_init_min.jld2"), "m3", m3)
	FileIO.save(joinpath(d, "params_init_max.jld2"), "m4", m4)
	FileIO.save(joinpath(d, "targetkeys.jld2"), "tk", tk)
end

good_forward_preds = FileIO.load(joinpath(d, "goodresults.jld2"), "forward_preds")
good_forward_results = FileIO.load(joinpath(d, "forward_results.jld2"), "forward_results")
good_paramrandom_true = FileIO.load(joinpath(d, "paramrandom_true.jld2"), "paramrandom_true")
good_paramrandom_false = FileIO.load(joinpath(d, "paramrandom_false.jld2"), "paramrandom_false")
good_residuals = FileIO.load(joinpath(d, "residuals.jld2"), "residuals_results")
good_pd = FileIO.load(joinpath(d, "paramdict.jld2"), "pd")
good_params_min = FileIO.load(joinpath(d, "params_min.jld2"), "m1")
good_params_max = FileIO.load(joinpath(d, "params_max.jld2"), "m2")
good_params_init_min = FileIO.load(joinpath(d, "params_init_min.jld2"), "m3")
good_params_init_max = FileIO.load(joinpath(d, "params_init_max.jld2"), "m4")
good_targetkeys = FileIO.load(joinpath(d, "targetkeys.jld2"), "tk")

@Test.testset "Anasol" begin
	# Test Mads.forward(md, all=true)
	ssr = 0.
	for obskey in union(Set(keys(forward_results)), Set(keys(good_forward_results)))
		ssr += (forward_results[obskey] - good_forward_results[obskey])^2
	end
	@Test.test isapprox(ssr, 0., atol=1e-8)

	# Test Mads.getparamrandom(md, 5, init_dist=true)
	for obskey in union(Set(keys(paramrandom_true)), Set(keys(good_paramrandom_true)))
		@Test.test isapprox(paramrandom_true[obskey], good_paramrandom_true[obskey], atol=1e-8)
	end

	# Test Mads.getparamrandom(md, 5, init_dist=false)
	for obskey in union(Set(keys(paramrandom_false)), Set(keys(good_paramrandom_false)))
		@Test.test isapprox(paramrandom_false[obskey], good_paramrandom_false[obskey], atol=1e-8)
	end

	# Test Mads.getparamdict(md)
	ssr = 0.
	for obskey in union(Set(keys(pd)), Set(keys(good_pd)))
		ssr += (pd[obskey] - good_pd[obskey])^2
	end
	@Test.test isapprox(ssr, 0., atol=1e-8)

	# Test computeconcentrations(paramdict)
	ssr = 0.
	for obskey in union(Set(keys(forward_preds)), Set(keys(good_forward_preds)))
		ssr += (forward_preds[obskey] - good_forward_preds[obskey])^2
	end
	@Test.test isapprox(ssr, 0., atol=1e-8)

	# Test Mads.of(md)
	@Test.test isapprox(madsOf, 628963.6972820368, atol=1e-8) #test

	# Test Mads.residuals(md)
	@Test.test isapprox(good_residuals, residuals_results, atol=1e-8)

	# Test Mads.getsourcekeys(md)
	@Test.test sk == ["Source1_dz", "Source1_f", "Source1_t0", "Source1_x", "Source1_dy", "Source1_dx", "Source1_z", "Source1_t1", "Source1_y"]

	# Test Mads.getparamsmin(md), getparamsmax, getparamsinit_min, getparamsinit_max
	@Test.test isapprox(m1, good_params_min, atol=1e-8)
	@Test.test isapprox(m2, good_params_max, atol=1e-8)
	@Test.test isapprox(m3, good_params_init_min, atol=1e-8)
	@Test.test isapprox(m4, good_params_init_max, atol=1e-8)

	# Test Mads.gettargetkeys(md)
	@Test.test tk == good_targetkeys
end

md = Mads.loadmadsfile(joinpath(workdir, "w01shortexp.mads"))
md["Restart"] = true
Mads.localsa(md, filename="w01shortexp.mads", par=Mads.getparamsinit(md, Mads.getoptparamkeys(md)))
if isdefined(Mads, :Gadfly) && !haskey(ENV, "MADS_NO_GADFLY")
	Mads.graphoff()
	Mads.plotlocalsa("w01shortexp")
	Mads.graphon()
end
@Mads.stdouterrcapture Mads.calibrate(md, localsa=true, show_trace=true)
Mads.rmfiles_ext("svg"; path=workdir)
Mads.rmfiles_ext("dat"; path=workdir)
Mads.rmfiles_root("w01shortexp-"; path=pwd())
Mads.rmfile("w01short-match-w1a.svg")
Mads.rmfiles_ext("iterationresults"; path=workdir)
Mads.rmdir("w01shortexp_restart")
Mads.rmdir("w01shortexp_restart"; path=workdir)

Mads.rmdir("w01-w13a_w20a_restart"; path=pwd())
Mads.rmfile("w01short-rerun.mads")

Mads.createobservations!(md, collect(0:0.1:50))
Mads.createobservations!(md, collect(0:0.1:50), weight_type="inverse")