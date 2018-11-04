import Mads
import JLD2
import FileIO
import Test

if haskey(ENV, "MADS_NO_BIGUQ") || !isdefined(Mads, :dobigdt)
	@info("BIGUQ cannot be tested!")
else
	problemdir = Mads.getmadsdir()
	workdir = joinpath(Mads.madsdir, "examples", "bigdt")

	md = Dict()
	if isdefined(Mads, :pyyaml) && Mads.pyyaml != PyCall.PyNULL()
		@Mads.stderrcapture md = Mads.loadmadsfile(joinpath(problemdir, "source_termination.mads"))
	else
		@Mads.stderrcapture md = Mads.loadmadsfile(joinpath(problemdir, "source_termination_json.mads"), format="json") # for testing only
	end

	nsample = 10
	bigdt_results = Mads.dobigdt(md, nsample; maxHorizon = 0.8, numlikelihoods = 2)

	if isdefined(Mads, :Gadfly) && !haskey(ENV, "MADS_NO_GADFLY")
		filenameroot = joinpath(problemdir, "source_termination-robustness-$nsample")
		Mads.plotrobustnesscurves(md, bigdt_results; filename=filenameroot)
		Mads.rmfile(joinpath(problemdir, "source_termination-robustness-10.svg"))
		Mads.plotrobustnesscurves(md, bigdt_results)
		Mads.rmfile(joinpath(problemdir, "source_termination-robustness.svg"))
	end

	# If enabled, save output as test file
	if Mads.create_tests
		d = joinpath(workdir, "test_results")
		Mads.mkdir(d)
		FileIO.save(joinpath(d, "bigdt_results.jld2"), "bigdt_results", bigdt_results)
	end

	good_bigdt_results = FileIO.load(joinpath(workdir, "test_results", "bigdt_results.jld2"), "bigdt_results")

	# Testing for bigdt
	@Test.testset "Bigdt" begin
		@Test.test isapprox(bigdt_results["maxfailureprobs"], good_bigdt_results["maxfailureprobs"], atol=1e-6)
		@Test.test isapprox(bigdt_results["horizons"], good_bigdt_results["horizons"], atol=1e-6)
	end
end