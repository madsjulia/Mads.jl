import Mads
import Base.Test

workdir = joinpath(Mads.madsdir, "..", "examples", "model_analysis")
savedir = joinpath(Mads.madsdir, "..", "examples", "svr")

@Base.Test.testset "SVR" begin
	srand(2017)

	numberofsamples = 1000 # Set the number

	md = Mads.loadmadsfile(joinpath(workdir, "models", "internal-polynomial.mads"))
	paramdict = Mads.getparamrandom(md, numberofsamples, init_dist=true)
	paramarray = hcat(map(i->collect(paramdict[i]), keys(paramdict))...)

	svrexec, svrread, svrsave, svrclean = Mads.makesvrmodel(md, 100)

	svrpredictions = svrexec(paramarray)

	if Mads.create_tests
		d = joinpath(savedir, "test_results")
		Mads.mkdir(d)
		JLD.save(joinpath(d, "svrpredictions.jld"), "svrpredictions", svrpredictions)
	end

	good_svrpredictions = JLD.load(joinpath(savedir, "test_results", "svrpredictions.jld"), "svrpredictions")

	@Base.Test.test sum((svrpredictions .- good_svrpredictions).^2) < 0.1

	svrsave()
	svrclean()
	svrread()
	svrclean()
end

Mads.rmdir(joinpath(workdir, "svrmodels"))

:passed