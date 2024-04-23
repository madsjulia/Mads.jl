import Mads
import Test

import JLD2
import DataStructures
import OrderedCollections
import Distributed
import Random

@Mads.tryimportmain JLD2
@Mads.tryimportmain OrderedCollections
@Mads.tryimportmain DataStructures

Mads.veryquieton()
Mads.graphoff()

workdir = joinpath(Mads.dir, "examples", "model_analysis")
savedir = joinpath(Mads.dir, "examples", "svr")
goodresultsfile = "sasvr.jld2"

Mads.seed!(2017, Random.MersenneTwister)

numberofsamples = 1000

@Mads.stdouterrcapture md = Mads.loadmadsfile(joinpath(workdir, "..", "models", "internal-polynomial-model", "internal-polynomial.mads"))
paramdict = Mads.getparamrandom(md, numberofsamples, init_dist=true)
paramarray = hcat(map(i->collect(paramdict[i]), collect(keys(paramdict)))...)
paramdict1 = Dict(zip(Mads.getparamkeys(md), Mads.getparamsinit(md)))

svrexec, svrread, svrsave, svrclean = Mads.makesvrmodel(md, 100)

svrexec(paramdict1)
svrpredictionsdict = svrexec(paramdict)
svrpredictions = svrexec(paramarray)

if Mads.create_tests
	d = joinpath(savedir, "test_results")
	Mads.mkdir(d)
	JLD2.save(joinpath(d, "svrpredictions.jld2"), "svrpredictions", svrpredictions)
end

good_svrpredictions = JLD2.load(joinpath(savedir, "test_results", "svrpredictions.jld2"), "svrpredictions")

mdsvr = deepcopy(md)
mdsvr["Julia model"] = svrexec
sasvr = Mads.efast(mdsvr; N=100, seed=2017, rng=Random.MersenneTwister)

sasvr_mes = hcat(map(i->collect(i), values.(collect(values(sasvr["mes"]))))...)
sasvr_tes = hcat(map(i->collect(i), values.(collect(values(sasvr["tes"]))))...)
sasvr_var = hcat(map(i->collect(i), values.(collect(values(sasvr["var"]))))...)

if Mads.create_tests
	d = joinpath(savedir, "test_results")
	Mads.mkdir(d)
	JLD2.save(joinpath(d, goodresultsfile), "sasvr", sasvr)
end

good_sasvr = JLD2.load(joinpath(savedir, "test_results", goodresultsfile), "sasvr")

good_sasvr_mes = hcat(map(i->collect(i), values.(collect(values(good_sasvr["mes"]))))...)
good_sasvr_tes = hcat(map(i->collect(i), values.(collect(values(good_sasvr["tes"]))))...)
good_sasvr_var = hcat(map(i->collect(i), values.(collect(values(good_sasvr["var"]))))...)

@Test.testset "SVR" begin
	@Test.test sum((svrpredictions .- good_svrpredictions).^2) < 0.1
	@Test.test sum((svrpredictionsdict .- good_svrpredictions).^2) < 0.1

	@Test.test sum((sasvr_mes .- good_sasvr_mes).^2) < 0.1
	@Test.test sum((sasvr_tes .- good_sasvr_tes).^2) < 0.1
	@Test.test sum((sasvr_var .- good_sasvr_var).^2) < 0.1
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