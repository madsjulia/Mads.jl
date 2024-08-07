import Mads
import JLD2

import Test

if haskey(ENV, "MADS_NO_BIGUQ") || !isdefined(Mads, :bigdt)
	@info("BIGUQ cannot be tested!")
else
	problemdir = Mads.getproblemdir()
	workdir = joinpath(Mads.dir, "examples", "bigdt")

	md = Mads.loadmadsfile(joinpath(workdir, "source_termination.mads"); quiet=true)
	# md = Mads.loadmadsfile(joinpath(workdir, "source_termination_json.mads"); format="json", quiet=true) # for testing only

	nsample = 10
	bigdt_results = Mads.bigdt(md, nsample; maxHorizon=0.8, numlikelihoods=2)

	if !haskey(ENV, "MADS_NO_GADFLY")
		filenameroot = joinpath(problemdir, "source_termination_robustness_$(nsample)")
		Mads.plotrobustnesscurves(md, bigdt_results; filename=filenameroot)
		Mads.rmfile(joinpath(problemdir, "source_termination_robustness_10.svg"))
		Mads.plotrobustnesscurves(md, bigdt_results)
		Mads.rmfile(joinpath(problemdir, "source_termination-robustness.svg"))
		Mads.rmfile(joinpath(problemdir, "source_termination_json-robustness.svg"))
	end

	# If enabled, save output as test file
	if Mads.create_tests
		d = joinpath(workdir, "test_results")
		Mads.mkdir(d)
		JLD2.save(joinpath(d, "bigdt_results.jld2"), "bigdt_results", bigdt_results)
	end

	good_bigdt_results = JLD2.load(joinpath(workdir, "test_results", "bigdt_results.jld2"), "bigdt_results")

	# Testing for bigdt
	Test.@testset "Bigdt" begin
		# Test.@test isapprox(bigdt_results["maxfailureprobs"], good_bigdt_results["maxfailureprobs"], atol=1e-6)
		Test.@test isapprox(bigdt_results["horizons"], good_bigdt_results["horizons"], atol=1e-6)
	end
end