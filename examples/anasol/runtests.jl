import Mads
import JLD
import Base.Test

srand(2017)

workdir = joinpath(Mads.madsdir, "..", "examples", "anasol")
md = Mads.loadmadsfile(joinpath(workdir, "w01shortexp.mads"))
forward_results = Mads.forward(md, all=true)
paramrandom_true = Mads.getparamrandom(md, 5, init_dist=true)
paramrandom_false = Mads.getparamrandom(md, 5, init_dist=false)
md = Mads.loadmadsfile(joinpath(workdir, "w01short.mads"))
computeconcentrations = Mads.makecomputeconcentrations(md)
paramdict = Dict(zip(Mads.getparamkeys(md), Mads.getparamsinit(md)))
forward_preds = computeconcentrations(paramdict)

if isdefined(:Gadfly)
	fp = Mads.forward(md; all=true)
	Mads.plotmadsproblem(md, keyword="test")
	Mads.plotmatches(md)
	Mads.plotmatches(md, Mads.getparamdict(md); separate_files=true)
	Mads.plotmatches(md, fp)
	Mads.plotmatches(md, fp, r"w1a")
	Mads.rmfile(joinpath(workdir, "w01short-match-w1a.svg"))
	Mads.rmfile(joinpath(workdir, "w01short-match.svg"))
	Mads.spaghettiplots(md, 2)
	Mads.rmfile(joinpath(workdir, "w01short-ax-2-spaghetti.svg"))
	Mads.rmfile(joinpath(workdir, "w01short-vx-2-spaghetti.svg"))
end

Mads.forwardgrid(md)
if isdefined(Mads, :plotgrid)
	Mads.plotgrid(md)
end
madsOf = Mads.of(md)
residuals_results = Mads.residuals(md)
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
@Base.Test.test Mads.gettime(md["Observations"][tk[1]]) == 1
@Base.Test.test Mads.getweight(md["Observations"][tk[1]]) == 1
Mads.settarget!(md["Observations"][tk[1]], 1)
o1 = Mads.indexkeys(md["Observations"], "o")
o2 = Mads.indexkeys(md["Observations"], r"o")
@Base.Test.test o1 == o2
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
Mads.savemadsfile(md, Mads.getparamdict(md), joinpath(workdir, "test.mads"))
Mads.savemadsfile(md, Mads.getparamdict(md), joinpath(workdir, "test.mads"), explicit=true)
Mads.rmfile(joinpath(workdir, "test.mads"))
Mads.setmadsinputfile("test.mads")
f = Mads.getmadsinputfile()
@Base.Test.test f == "test.mads"
e = Mads.getextension("test.mads")
@Base.Test.test e == "mads"

Mads.stdoutcaptureon()
Mads.showparameters(md)
Mads.showallparameters(md)
Mads.showallparameters(md)
Mads.showobservations(md)
Mads.stdoutcaptureoff();

Mads.setparamsdistnormal!(md, fill(1, length(m1)), fill(1, length(m1)))
Mads.setparamsdistuniform!(md, fill(1, length(m1)), fill(1, length(m1)))

Mads.computemass("w01lambda", time=50, path=workdir)
Mads.rmdir(joinpath(workdir, "mass_reduced.svg"))

if Mads.create_tests
	d = joinpath(workdir, "test_results")
	Mads.mkdir(d)
	
	JLD.save(joinpath(d, "goodresults.jld"), "forward_preds", forward_preds)
	JLD.save(joinpath(d, "forward_results.jld"), "forward_results", forward_results)
	JLD.save(joinpath(d, "paramrandom_true.jld"), "paramrandom_true", paramrandom_true)
	JLD.save(joinpath(d, "paramrandom_false.jld"), "paramrandom_false", paramrandom_false)
	JLD.save(joinpath(d, "residuals.jld"), "residuals_results", residuals_results)
	JLD.save(joinpath(d, "paramdict.jld"), "pd", pd)
	JLD.save(joinpath(d, "params_min.jld"), "m1", m1)
	JLD.save(joinpath(d, "params_max.jld"), "m2", m2)
	JLD.save(joinpath(d, "params_init_min.jld"), "m3", m3)
	JLD.save(joinpath(d, "params_init_max.jld"), "m4", m4)
	JLD.save(joinpath(d, "targetkeys.jld"), "tk", tk)
end

good_forward_preds = JLD.load(joinpath(workdir, "test_results", "goodresults.jld"), "forward_preds")
good_forward_results = JLD.load(joinpath(workdir, "test_results", "forward_results.jld"), "forward_results")
good_paramrandom_true = JLD.load(joinpath(workdir, "test_results", "paramrandom_true.jld"), "paramrandom_true")
good_paramrandom_false = JLD.load(joinpath(workdir, "test_results", "paramrandom_false.jld"), "paramrandom_false")
good_residuals = JLD.load(joinpath(workdir, "test_results", "residuals.jld"), "residuals_results")
good_pd = JLD.load(joinpath(workdir, "test_results", "paramdict.jld"), "pd")
good_params_min = JLD.load(joinpath(workdir, "test_results", "params_min.jld"), "m1")
good_params_max = JLD.load(joinpath(workdir, "test_results", "params_max.jld"), "m2")
good_params_init_min = JLD.load(joinpath(workdir, "test_results", "params_init_min.jld"), "m3")
good_params_init_max = JLD.load(joinpath(workdir, "test_results", "params_init_max.jld"), "m4")
good_targetkeys = JLD.load(joinpath(workdir, "test_results", "targetkeys.jld"), "tk")

# Test Mads.forward(md, all=true)
ssr = 0.
for obskey in union(Set(keys(forward_results)), Set(keys(good_forward_results)))
	ssr += (forward_results[obskey] - good_forward_results[obskey])^2
end
@Base.Test.test_approx_eq_eps ssr 0. 1e-8

# Test Mads.getparamrandom(md, 5, init_dist=true)
for obskey in union(Set(keys(paramrandom_true)), Set(keys(good_paramrandom_true)))
	@Base.Test.test_approx_eq_eps paramrandom_true[obskey] good_paramrandom_true[obskey] 1e-8
end

# Test Mads.getparamrandom(md, 5, init_dist=false)
for obskey in union(Set(keys(paramrandom_false)), Set(keys(good_paramrandom_false)))
	@Base.Test.test_approx_eq_eps paramrandom_false[obskey] good_paramrandom_false[obskey] 1e-8
end

# Test Mads.getparamdict(md)
ssr = 0.
for obskey in union(Set(keys(pd)), Set(keys(good_pd)))
	ssr += (pd[obskey] - good_pd[obskey])^2
end
@Base.Test.test_approx_eq_eps ssr 0. 1e-8

# Test computeconcentrations(paramdict)
ssr = 0.
for obskey in union(Set(keys(forward_preds)), Set(keys(good_forward_preds)))
	ssr += (forward_preds[obskey] - good_forward_preds[obskey])^2
end
@Base.Test.test_approx_eq_eps ssr 0. 1e-8

# Test Mads.of(md)
@Base.Test.test_approx_eq_eps madsOf 628789.775106828 1e-8 #test

# Test Mads.residuals(md)
@Base.Test.test_approx_eq_eps good_residuals residuals_results 1e-8

# Test Mads.getsourcekeys(md)
@Base.Test.test sk == ["Source1_dz", "Source1_f", "Source1_t0", "Source1_x", "Source1_dy", "Source1_dx", "Source1_z", "Source1_t1", "Source1_y"]

# Test Mads.getparamsmin(md), getparamsmax, getparamsinit_min, getparamsinit_max
@Base.Test.test_approx_eq_eps m1 good_params_min 1e-8
@Base.Test.test_approx_eq_eps m2 good_params_max 1e-8
@Base.Test.test_approx_eq_eps m3 good_params_init_min 1e-8
@Base.Test.test_approx_eq_eps m4 good_params_init_max 1e-8

# Test Mads.gettargetkeys(md)
@Base.Test.test tk == good_targetkeys

Mads.rmdir("w01-w13a_w20a_restart")