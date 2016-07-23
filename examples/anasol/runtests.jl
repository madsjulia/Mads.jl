import Mads
import JLD
using Base.Test

workdir = Mads.madsdir * "/../examples/anasol"
md = Mads.loadmadsfile("$workdir/w01short.mads")
computeconcentrations = Mads.makecomputeconcentrations(md)
paramdict = Dict(zip(Mads.getparamkeys(md), Mads.getparamsinit(md)))
forward_preds = computeconcentrations(paramdict)
@JLD.load "$workdir/goodresults.jld" good_forward_preds
ssr = 0.
for obskey in union(Set(keys(forward_preds)), Set(keys(good_forward_preds)))
	ssr += (forward_preds[obskey] - good_forward_preds[obskey])^2
end
@test_approx_eq_eps ssr 0. 1e-8

if Mads.create_tests
	good_forward_preds = computeconcentrations(paramdict)
	@JLD.save "$workdir/goodresults.jld" good_forward_preds
end

Mads.forwardgrid(md)
Mads.of(md)
Mads.residuals(md)
pd = Mads.getparamdict(md)
sk = Mads.getsourcekeys(md)
m = Mads.getparamsmin(md)
m = Mads.getparamsmax(md)
m = Mads.getparamsinit_min(md)
m = Mads.getparamsinit_max(md)
Mads.setparamsinit!(md, pd)
Mads.setallparamsoff!(md)
Mads.setallparamson!(md)
Mads.setparamoff!(md, "vx")
Mads.setparamon!(md, "vx")
tk = Mads.gettargetkeys(md)
Mads.gettime(md["Observations"][tk[1]])
Mads.getweight(md["Observations"][tk[1]])
Mads.settarget!(md["Observations"][tk[1]], 1)
Mads.indexkeys(md["Observations"], "o")
Mads.indexkeys(md["Observations"], r"o")
Mads.setobstime!(md, "_")
Mads.setobstime!(md, r"[A-x]*_([0-9,.]+)")
Mads.invwellweights!(md, 1)
Mads.modwellweights!(md, 1)
Mads.setwellweights!(md, 1)
Mads.setobservationtargets!(md, forward_preds)
Mads.createmadsproblem("$workdir/w01short.mads", "$workdir/test.mads")
Mads.createmadsproblem(md, forward_preds, "$workdir/test.mads")
Mads.allwellsoff!(md)
Mads.allwellson!(md)
Mads.welloff!(md, "w1a")
Mads.wellon!(md, "w1a")
Mads.savemadsfile(md, "$workdir/test.mads")
Mads.savemadsfile(md, Mads.getparamdict(md), "$workdir/test.mads")
Mads.savemadsfile(md, Mads.getparamdict(md), "$workdir/test.mads", explicit=true)
run(`bash -c "rm -f $workdir/test.mads"`)
Mads.setmadsinputfile("test.mads")
f = Mads.getmadsinputfile()
e = Mads.getextension("test.mads")

originalSTDOUT = STDOUT;
(outRead, outWrite) = redirect_stdout();
Mads.showparameters(md)
Mads.showallparameters(md)
Mads.showallparameters(md)
Mads.showobservations(md)
close(outWrite);
close(outRead);
redirect_stdout(originalSTDOUT);

Mads.setparamsdistnormal!(md, fill(1, length(m)), fill(1, length(m)))
Mads.setparamsdistuniform!(md, fill(1, length(m)), fill(1, length(m)))
