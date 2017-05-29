import Mads
import Base.Test
import DataStructures

workdir = joinpath(Mads.madsdir, "..", "examples", "model_analysis")
savedir = joinpath(Mads.madsdir, "..", "examples", "svr")

@Base.Test.testset "SVR" begin
	srand(2017)

	numberofsamples = 1000 # Set the number

	md = Mads.loadmadsfile(joinpath(workdir, "models", "internal-polynomial.mads"))
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

	@Base.Test.test sum((svrpredictions .- good_svrpredictions).^2) < 0.1
	@Base.Test.test sum((svrpredictionsdict .- good_svrpredictions).^2) < 0.1

	srand(2017)

	mdsvr = deepcopy(md)
	mdsvr["Julia model"] = svrexec
	sasvr = Mads.efast(mdsvr)

	if Mads.create_tests
		d = joinpath(savedir, "test_results")
		Mads.mkdir(d)
		JLD.save(joinpath(d, "sasvr.jld"), "sasvr", sasvr)
	end

	good_sasvr = JLD.load(joinpath(savedir, "test_results", "sasvr.jld"), "sasvr")

	# @Base.Test.test sasvr == good_sasvr

	Mads.makesvrmodel(md, 100, loadsvr=true)

	svrsave()
	svrclean()
	svrread()
	svrclean()
end

Mads.rmdir(joinpath(workdir, "svrmodels"))

:passed