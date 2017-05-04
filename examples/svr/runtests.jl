import Mads
import Base.Test

workdir = joinpath(Mads.madsdir, "..", "examples", "model_analysis")
savedir = joinpath(Mads.madsdir, "..", "examples", "svr")

@Base.Test.testset "SVR" begin
	numberofsamples = 1000 # Set the number 

	md = Mads.loadmadsfile(joinpath(workdir,"models/internal-polynomial.mads"))
	paramdict = Mads.getparamrandom(md, numberofsamples, init_dist=true)
	paramarray = hcat(map(i->collect(paramdict[i]), keys(paramdict))...)

#	predictions = Mads.forward(md, paramdict)'
	svrmodel = Mads.svrtrain(md, 100)
	svrexec, svrread, svrsave, svrclean = Mads.makesvrmodel(md, 100)

	svrpredictions = svrexec(paramarray)
	model_predictions = Mads.svrpredict(svrmodel, paramarray)

	if Mads.create_tests
		d = joinpath(savedir, "test_results")
		Mads.mkdir(d)
	
		JLD.save(joinpath(d, "svrpredictions.jld"), "svrpredictions", svrpredictions)
		JLD.save(joinpath(d, "model_predictions.jld"), "model_predictions", model_predictions)
	end

	good_svrpredictions = JLD.load(joinpath(savedir, "test_results", "svrpredictions.jld"), "svrpredictions")
	good_predictions = JLD.load(joinpath(savedir, "test_results", "model_predictions.jld"), "model_predictions")

	@Base.Test.test abs(mean(svrpredictions .- good_svrpredictions)) < 20. # Test that predictions are 
	@Base.Test.test abs(mean(model_predictions .- good_predictions)) < 20. # within 10% (?) of each other
end