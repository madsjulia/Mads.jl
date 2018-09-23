import Mads
import Base.Test

workdir = joinpath(Mads.madsdir, "examples", "model_analysis")
savedir = joinpath(Mads.madsdir, "examples", "svr")
goodresultsfile = "sasvr.jld"

srand(2017)

numberofsamples = 1000 # Set the number

@Mads.stdouterrcapture md = Mads.loadmadsfile(joinpath(workdir, "models", "internal-polynomial.mads"))
paramdict = Mads.getparamrandom(md, numberofsamples, init_dist=true)
paramarray = hcat(map(i->collect(paramdict[i]), keys(paramdict))...)
paramdict1 = Dict(zip(Mads.getparamkeys(md), Mads.getparamsinit(md)))

svrexec, svrread, svrsave, svrclean = Mads.makesvrmodel(md, 100)

svrexec(paramdict1)
svrpredictionsdict = svrexec(paramdict)
svrpredictions = svrexec(paramarray)

if Mads.create_tests
	d = joinpath(savedir, "test_results")
	Mads.mkdir(d)
	FileIO.save(joinpath(d, "svrpredictions.jld"), "svrpredictions", svrpredictions)
end

good_svrpredictions = FileIO.load(joinpath(savedir, "test_results", "svrpredictions.jld"), "svrpredictions")

srand(2017)

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

@Base.Test.testset "SVR" begin
	@Base.Test.test sum((svrpredictions .- good_svrpredictions).^2) < 0.1
	@Base.Test.test sum((svrpredictionsdict .- good_svrpredictions).^2) < 0.1

	@Base.Test.test sum((sasvr_mes .- good_sasvr_mes).^2) < 0.1
	@Base.Test.test sum((sasvr_tes .- good_sasvr_tes).^2) < 0.1
	@Base.Test.test sum((sasvr_var .- good_sasvr_var).^2) < 0.1
end

Mads.makesvrmodel(md, 100, loadsvr=true)

svrsave()
svrclean()
svrread()
svrclean()

Mads.rmdir(joinpath(workdir, "svrmodels"))
Mads.rmdir("svrmodels")

:passed