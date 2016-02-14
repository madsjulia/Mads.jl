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
	ssr += (forward_preds[obskey] - good_forward_preds[obskey]) ^ 2
end
@test_approx_eq ssr 0.

#good_forward_preds = computeconcentrations(paramdict)
#@JLD.save "$workdir/goodresults.jld" good_forward_preds
