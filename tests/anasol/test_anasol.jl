import Mads
import JLD
using Base.Test

codedir = dirname(Base.source_path())
md = Mads.loadyamlmadsfile("$codedir/w01short.mads")
computeconcentrations = Mads.makecomputeconcentrations(md)
paramdict = Dict(Mads.getparamkeys(md), Mads.getparamsinit(md))
forward_preds = computeconcentrations(paramdict)
@JLD.load "$codedir/goodresults.jld" good_forward_preds
ssr = 0.
for obskey in union(Set(keys(forward_preds)), Set(keys(good_forward_preds)))
	ssr += (forward_preds[obskey] - good_forward_preds[obskey]) ^ 2
end
@test_approx_eq ssr 0.
#good_forward_preds = computeconcentrations(paramdict)
#@JLD.save "goodresults.jld" good_forward_preds
