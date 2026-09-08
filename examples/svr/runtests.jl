import Mads
import Test

import OrderedCollections
import Distributed
import Random

Mads.@tryimportmain OrderedCollections

Mads.veryquieton()
Mads.graphoff()

workdir = joinpath(Mads.dir, "examples", "model_analysis")

Mads.seed!(2017, Random.MersenneTwister)

numberofsamples = 1000

Mads.@stdouterrcapture md = Mads.loadmadsfile(joinpath(workdir, "..", "models", "internal-polynomial-model", "internal-polynomial.mads"))
paramdict = Mads.getparamrandom(md, numberofsamples; init_dist=true)
paramarray = hcat(map(i->collect(paramdict[i]), collect(keys(paramdict)))...)
paramdict1 = Dict(zip(Mads.getparamkeys(md), Mads.getparamsinit(md)))
directpredictions::Matrix{Float64} = Mads.forward(md, paramdict)

svrexec, svrread, svrsave, svrclean = Mads.makesvrmodel(md, 100)

svrexec(paramdict1)
svrpredictionsdict = svrexec(paramdict)
svrpredictions = svrexec(paramarray)

prediction_ranges::Matrix{Float64} = maximum(directpredictions; dims=2) .- minimum(directpredictions; dims=2)
normalized_rmse::Matrix{Float64} = sqrt.(sum(abs2, svrpredictions .- directpredictions; dims=2) ./ size(directpredictions, 2)) ./ prediction_ranges

mdsvr = deepcopy(md)
mdsvr["Julia model"] = svrexec
sasvr = Mads.efast(mdsvr; N=100, seed=2017, rng=Random.MersenneTwister, save=false)

sasvr_mes = hcat(map(i->collect(i), values.(collect(values(sasvr["mes"]))))...)
sasvr_tes = hcat(map(i->collect(i), values.(collect(values(sasvr["tes"]))))...)
sasvr_var = hcat(map(i->collect(i), values.(collect(values(sasvr["var"]))))...)

Test.@testset "SVR" begin
	Test.@test isapprox(svrpredictionsdict, svrpredictions; atol=1e-8, rtol=1e-8)
	Test.@test all(normalized_rmse .< 0.1)
	Test.@test size(sasvr_mes) == (length(Mads.getoptparamkeys(md)), length(Mads.getobskeys(md)))
	Test.@test size(sasvr_tes) == size(sasvr_mes)
	Test.@test size(sasvr_var) == size(sasvr_mes)
	Test.@test all(isfinite, sasvr_mes)
	Test.@test all(isfinite, sasvr_tes)
	Test.@test all(isfinite, sasvr_var)
	Test.@test all((0.0 .<= sasvr_mes) .& (sasvr_mes .<= 1.0))
	Test.@test all((0.0 .<= sasvr_tes) .& (sasvr_tes .<= 1.0))
	Test.@test all(sasvr_var .>= 0.0)
end

Mads.makesvrmodel(md, 100, loadsvr=true)

svrsave()
svrclean()
svrread()
svrclean()

Mads.rmdir(joinpath(workdir, "svrmodels"))
Mads.rmdir("svrmodels")

Mads.veryquietoff()
Mads.graphon()

:passed