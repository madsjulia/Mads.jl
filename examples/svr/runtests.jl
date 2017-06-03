import Mads
import Base.Test
import DataStructures

workdir = joinpath(Mads.madsdir, "..", "examples", "model_analysis")
savedir = joinpath(Mads.madsdir, "..", "examples", "svr")

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
	JLD.save(joinpath(d, "svrpredictions.jld"), "svrpredictions", svrpredictions)
end

good_svrpredictions = JLD.load(joinpath(savedir, "test_results", "svrpredictions.jld"), "svrpredictions")

@Base.Test.testset "SVR" begin
	import DataStructures

	@Base.Test.test sum((svrpredictions .- good_svrpredictions).^2) < 0.1
	@Base.Test.test sum((svrpredictionsdict .- good_svrpredictions).^2) < 0.1

	srand(2017)

	mdsvr = deepcopy(md)
	mdsvr["Julia model"] = svrexec
	sasvr = Mads.efast(mdsvr)

	sasvr_mes = hcat(map(i->collect(i), values.(vcat(collect(values(sasvr["mes"])))))...)
	sasvr_tes = hcat(map(i->collect(i), values.(vcat(collect(values(sasvr["tes"])))))...)


	if Mads.create_tests
		d = joinpath(savedir, "test_results")
		Mads.mkdir(d)
		JLD.save(joinpath(d, "sasvr.jld"), "sasvr", sasvr)
	end

	good_sasvr = JLD.load(joinpath(savedir, "test_results", "sasvr.jld"), "sasvr")

	good_sasvr_mes = hcat(map(i->collect(i), values.(vcat(collect(values(good_sasvr["mes"])))))...)
	good_sasvr_tes = hcat(map(i->collect(i), values.(vcat(collect(values(good_sasvr["tes"])))))...)

	@Base.Test.test sasvr_mes == good_sasvr_mes
	@Base.Test.test sasvr_tes == good_sasvr_tes
end

Mads.makesvrmodel(md, 100, loadsvr=true)

svrsave()
svrclean()
svrread()
svrclean()

Mads.rmdir(joinpath(workdir, "svrmodels"))

:passed