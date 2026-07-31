import Mads
import JLD2

import Test

if haskey(ENV, "MADS_NO_BIGUQ") || !isdefined(Mads, :bigdt)
	@info("BIGUQ cannot be tested!")
else
	workdir::String = joinpath(Mads.dir, "examples", "bigdt")

	md::AbstractDict = Mads.loadmadsfile(joinpath(workdir, "source_termination.mads"); quiet=true)
	# md = Mads.loadmadsfile(joinpath(workdir, "source_termination_json.mads"); format="json", quiet=true) # for testing only

	nsample::Int = 10
	numhorizons::Int = 8
	progress_events::Vector{Tuple{Int,Int}} = Tuple{Int,Int}[]
	progress_callback::Function = (completed_choices::Int, total_choices::Int) -> begin
		push!(progress_events, (completed_choices, total_choices))
		nothing
	end
	Mads.seed!(20260731)
	bigdt_results::AbstractDict = Mads.bigdt(md, nsample; numhorizons=numhorizons, maxHorizon=0.8, numlikelihoods=2, progress_callback=progress_callback)
	maxfailureprobs::Matrix{Float64} = bigdt_results["maxfailureprobs"]
	horizons::Vector{Float64} = bigdt_results["horizons"]

	if !haskey(ENV, "MADS_NO_GADFLY") && !haskey(ENV, "MADS_NO_PLOT")
		mktempdir() do plotdir::String
			filenameroot::String = joinpath(plotdir, "source_termination-robustness-$(nsample)")
			Mads.plotrobustnesscurves(md, bigdt_results; filename=filenameroot)
			Test.@test isfile("$(filenameroot).svg")
		end
	end

	# If enabled, save output as test file
	if Mads.create_tests
		d::String = joinpath(workdir, "test_results")
		Mads.mkdir(d)
		JLD2.save(joinpath(d, "bigdt_results.jld2"), "bigdt_results", bigdt_results)
	end

	# Testing for bigdt
	Test.@testset "BIG-DT source termination" begin
		Test.@test size(maxfailureprobs) == (numhorizons, length(md["Choices"]))
		Test.@test length(horizons) == numhorizons
		Test.@test isapprox(first(horizons), 0.0; atol=eps(Float64))
		Test.@test isapprox(last(horizons), 0.8; atol=eps(Float64))
		Test.@test all(isfinite, horizons)
		Test.@test all(isfinite, maxfailureprobs)
		Test.@test all((0.0 .<= maxfailureprobs) .& (maxfailureprobs .<= 1.0))
		Test.@test all(diff(horizons) .> 0.0)
		Test.@test all(diff(maxfailureprobs; dims=1) .>= 0.0)
		Test.@test progress_events == [(index, length(md["Choices"])) for index::Int in 0:length(md["Choices"])]
	end
end
