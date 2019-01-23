import Mads
import FileIO
import JLD2
import Test

Mads.veryquieton()
Mads.graphoff()

using Distributed
import DataStructures

@Mads.tryimportmain JLD2
@Mads.tryimportmain FileIO
@Mads.tryimportmain OrderedCollections
@Mads.tryimportmain DataStructures

workdir = joinpath(Mads.madsdir, "examples", "model_analysis")
savedir = joinpath(Mads.madsdir, "examples", "svr")
goodresultsfile = "sasvr.jld2"

Random.seed!(2017)

numberofsamples = 1000 # Set the number

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
	FileIO.save(joinpath(d, "svrpredictions.jld2"), "svrpredictions", svrpredictions)
end

good_svrpredictions = FileIO.load(joinpath(savedir, "test_results", "svrpredictions.jld2"), "svrpredictions")

Random.seed!(2017)

mdsvr = deepcopy(md)
mdsvr["Julia model"] = svrexec
sasvr = Mads.efast(mdsvr)

sasvr_mes = hcat(map(i->collect(i), values.(collect(values(sasvr["mes"]))))...)
sasvr_tes = hcat(map(i->collect(i), values.(collect(values(sasvr["tes"]))))...)
sasvr_var = hcat(map(i->collect(i), values.(collect(values(sasvr["var"]))))...)

if Mads.create_tests
	d = joinpath(savedir, "test_results")
	Mads.mkdir(d)
	FileIO.save(joinpath(d, goodresultsfile), "sasvr", sasvr)
end

good_sasvr = FileIO.load(joinpath(savedir, "test_results", goodresultsfile), "sasvr")

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