import Mads
import JLD2

import Test

if haskey(ENV, "MADS_NO_BIGUQ") || !isdefined(Mads, :bigdt)
    @info("BIGUQ cannot be tested!")
else
    workdir::String = joinpath(Mads.dir, "examples", "bigdt")
    include(joinpath(workdir, "source_termination.jl"))

    md::AbstractDict = Mads.loadmadsfile(joinpath(workdir, "source_termination.mads"); quiet=true)
    # md = Mads.loadmadsfile(joinpath(workdir, "source_termination_json.mads"); format="json", quiet=true) # for testing only

    nsample::Int = 10
    numhorizons::Int = 8
    progress_events::Vector{Tuple{Int, Int}} = Tuple{Int, Int}[]
    progress_callback::Function = (completed_choices::Int, total_choices::Int) -> begin
        push!(progress_events, (completed_choices, total_choices))
        nothing
    end
    Mads.seed!(20260731)
    bigdt_results::AbstractDict = Mads.bigdt(md, nsample; numhorizons=numhorizons, maxHorizon=0.8, numlikelihoods=2, progress_callback=progress_callback)
    maxfailureprobs::Matrix{Float64} = bigdt_results["maxfailureprobs"]
    horizons::Vector{Float64} = bigdt_results["horizons"]
    acceptable_failure_probability::Float64 = 0.05
    decision_summary::Vector{SourceTerminationDecisionSummary} = summarize_source_termination(
        md,
        bigdt_results;
        acceptable_failure_probability=acceptable_failure_probability
    )
    synthetic_robustness_horizon::Union{Float64, Nothing} = source_termination_robustness_horizon(
        [0.0, 0.2, 0.4],
        [0.0, 0.04, 0.08],
        acceptable_failure_probability
    )
    beyond_range_robustness_horizon::Union{Float64, Nothing} = source_termination_robustness_horizon(
        [0.0, 0.2, 0.4],
        [0.0, 0.01, 0.02],
        acceptable_failure_probability
    )
    synthetic_maxfailureprobs::Matrix{Float64} = fill(0.0, 3, length(md["Choices"]))
    synthetic_maxfailureprobs[:, 1] = [0.0, 0.01, 0.02]
    for choice_index::Int = 2:length(md["Choices"])
        synthetic_maxfailureprobs[:, choice_index] = [0.0, 0.05, 0.10]
    end
    synthetic_bigdt_results::Dict{String, Any} = Dict{String, Any}(
        "maxfailureprobs" => synthetic_maxfailureprobs,
        "horizons" => [0.0, 0.2, 0.4]
    )
    synthetic_decision_summary::Vector{SourceTerminationDecisionSummary} = summarize_source_termination(
        md,
        synthetic_bigdt_results;
        acceptable_failure_probability=acceptable_failure_probability
    )

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
        Test.@test progress_events == [(index, length(md["Choices"])) for index::Int = 0:length(md["Choices"])]
        Test.@test length(decision_summary) == length(md["Choices"])
        Test.@test [item.choice_index for item::SourceTerminationDecisionSummary in decision_summary] == collect(1:length(md["Choices"]))
        Test.@test sort([item.rank for item::SourceTerminationDecisionSummary in decision_summary]) == collect(1:length(md["Choices"]))
        Test.@test all(
            isnothing(item.robustness_horizon) || isfinite(item.robustness_horizon)
            for item::SourceTerminationDecisionSummary in decision_summary
        )
        Test.@test all(
            isnothing(item.robustness_horizon) || 0.0 <= item.robustness_horizon <= last(horizons)
            for item::SourceTerminationDecisionSummary in decision_summary
        )
        Test.@test all(
            item.threshold_reached == !isnothing(item.robustness_horizon)
            for item::SourceTerminationDecisionSummary in decision_summary
        )
        Test.@test !isnothing(synthetic_robustness_horizon)
        Test.@test isapprox(synthetic_robustness_horizon::Float64, 0.25; atol=eps(Float64))
        Test.@test isnothing(beyond_range_robustness_horizon)
        Test.@test_throws ArgumentError source_termination_robustness_horizon(
            [-0.1, 0.0, 0.1],
            [0.0, 0.01, 0.02],
            acceptable_failure_probability
        )
        Test.@test_throws ArgumentError source_termination_robustness_horizon(
            [0.0, 0.1, 0.2],
            [0.0, 0.01, 1.01],
            acceptable_failure_probability
        )
        Test.@test isnothing(synthetic_decision_summary[1].robustness_horizon)
        Test.@test !synthetic_decision_summary[1].threshold_reached
        Test.@test synthetic_decision_summary[1].rank == 1
    end
end
