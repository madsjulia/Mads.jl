import Mads

const SourceTerminationDecisionSummary = NamedTuple{
    (:choice_index, :choice_name, :termination_year, :robustness_horizon, :threshold_reached, :rank),
    Tuple{Int, String, Int, Union{Float64, Nothing}, Bool, Int}
}

function validate_source_termination_settings(
    nsample::Int,
    numhorizons::Int,
    max_horizon::Real,
    numlikelihoods::Int,
    acceptable_failure_probability::Real,
    seed::Int,
    problemdir::AbstractString,
    outputdir::AbstractString,
    write_plots::Bool
)::Nothing
    nsample > 0 || throw(ArgumentError("nsample must be greater than zero."))
    numhorizons >= 2 || throw(ArgumentError("numhorizons must be at least two."))
    isfinite(max_horizon) && max_horizon > 0 || throw(ArgumentError("max_horizon must be finite and greater than zero."))
    numlikelihoods > 0 || throw(ArgumentError("numlikelihoods must be greater than zero."))
    isfinite(acceptable_failure_probability) && 0 <= acceptable_failure_probability <= 1 || throw(ArgumentError("acceptable_failure_probability must be between zero and one."))
    seed >= 0 || throw(ArgumentError("seed must be non-negative."))
    isfile(joinpath(problemdir, "source_termination.mads")) || throw(ArgumentError("problemdir must contain source_termination.mads."))
    if write_plots
        isempty(strip(outputdir)) && throw(ArgumentError("outputdir cannot be empty when write_plots is true."))
    end
    return nothing
end

function source_termination_robustness_horizon(
    horizons::AbstractVector{<:Real},
    failure_probabilities::AbstractVector{<:Real},
    acceptable_failure_probability::Real
)::Union{Float64, Nothing}
    horizon_values::Vector{Float64} = Float64.(horizons)
    failure_probability_values::Vector{Float64} = Float64.(failure_probabilities)
    acceptable_probability::Float64 = Float64(acceptable_failure_probability)

    length(horizon_values) == length(failure_probability_values) || throw(ArgumentError("horizons and failure_probabilities must have the same length."))
    length(horizon_values) >= 2 || throw(ArgumentError("at least two horizon values are required."))
    all(isfinite, horizon_values) || throw(ArgumentError("horizons must be finite."))
    all(isfinite, failure_probability_values) || throw(ArgumentError("failure_probabilities must be finite."))
    first(horizon_values) >= 0.0 || throw(ArgumentError("horizons must be non-negative."))
    all(diff(horizon_values) .> 0) || throw(ArgumentError("horizons must be strictly increasing."))
    all((0.0 .<= failure_probability_values) .& (failure_probability_values .<= 1.0)) || throw(ArgumentError("failure_probabilities must be between zero and one."))
    all(diff(failure_probability_values) .>= 0) || throw(ArgumentError("failure_probabilities must be non-decreasing."))
    0 <= acceptable_probability <= 1 || throw(ArgumentError("acceptable_failure_probability must be between zero and one."))

    if acceptable_probability <= first(failure_probability_values)
        return first(horizon_values)
    end

    upper_index::Union{Nothing, Int} = findfirst(
        (probability::Float64) -> probability >= acceptable_probability,
        failure_probability_values
    )
    if isnothing(upper_index)
        return nothing
    end

    upper::Int = upper_index::Int
    lower::Int = upper - 1
    lower_probability::Float64 = failure_probability_values[lower]
    upper_probability::Float64 = failure_probability_values[upper]
    if upper_probability == lower_probability
        return horizon_values[upper]
    end

    fraction::Float64 = (acceptable_probability - lower_probability) / (upper_probability - lower_probability)
    return horizon_values[lower] + fraction * (horizon_values[upper] - horizon_values[lower])
end

function summarize_source_termination(
    md::AbstractDict,
    bigdtresults::AbstractDict;
    acceptable_failure_probability::Real=0.05
)::Vector{SourceTerminationDecisionSummary}
    maxfailureprobs::Matrix{Float64} = bigdtresults["maxfailureprobs"]
    horizons::Vector{Float64} = bigdtresults["horizons"]
    choice_count::Int = length(md["Choices"])
    size(maxfailureprobs, 1) == length(horizons) || throw(ArgumentError("BIG-DT result dimensions do not match the horizon vector."))
    size(maxfailureprobs, 2) == choice_count || throw(ArgumentError("BIG-DT result columns do not match the decision choices."))

    choice_names::Vector{String} = Vector{String}(undef, choice_count)
    termination_years::Vector{Int} = Vector{Int}(undef, choice_count)
    robustness_horizons::Vector{Union{Float64, Nothing}} = Vector{Union{Float64, Nothing}}(undef, choice_count)
    for choice_index::Int = 1:choice_count
        choice::AbstractDict = md["Choices"][choice_index]
        choice_name::String = String(choice["name"])
        termination_year_value::Real = choice["Parameters"]["source1_t1"]
        choice_names[choice_index] = choice_name
        termination_years[choice_index] = round(Int, termination_year_value)
        robustness_horizons[choice_index] = source_termination_robustness_horizon(
            horizons,
            view(maxfailureprobs, :, choice_index),
            acceptable_failure_probability
        )
    end

    choice_indices::Vector{Int} = collect(1:choice_count)
    ranking_order::Vector{Int} = sort(
        choice_indices;
        by=(choice_index::Int) -> begin
            robustness_horizon::Union{Float64, Nothing} = robustness_horizons[choice_index]
            return isnothing(robustness_horizon) ? (0, 0.0, choice_index) : (1, -robustness_horizon, choice_index)
        end
    )
    ranks::Vector{Int} = Vector{Int}(undef, choice_count)
    for rank::Int in eachindex(ranking_order)
        choice_index::Int = ranking_order[rank]
        ranks[choice_index] = rank
    end

    summary::Vector{SourceTerminationDecisionSummary} = SourceTerminationDecisionSummary[]
    for choice_index::Int = 1:choice_count
        robustness_horizon::Union{Float64, Nothing} = robustness_horizons[choice_index]
        push!(summary, (
            choice_index=choice_index,
            choice_name=choice_names[choice_index],
            termination_year=termination_years[choice_index],
            robustness_horizon=robustness_horizon,
            threshold_reached=(!isnothing(robustness_horizon)),
            rank=ranks[choice_index]
        ))
    end
    return summary
end

function run_source_termination(;
    nsample::Int=1000,
    numhorizons::Int=100,
    max_horizon::Real=0.8,
    numlikelihoods::Int=5,
    acceptable_failure_probability::Real=0.05,
    seed::Int=20260804,
    write_plots::Bool=true,
    problemdir::AbstractString=@__DIR__,
    outputdir::AbstractString=problemdir,
    progress_callback::Union{Nothing, Function}=nothing
)::AbstractDict
    validate_source_termination_settings(
        nsample,
        numhorizons,
        max_horizon,
        numlikelihoods,
        acceptable_failure_probability,
        seed,
        problemdir,
        outputdir,
        write_plots
    )

    Mads.seed!(seed)
    md::AbstractDict = Mads.loadmadsfile(joinpath(problemdir, "source_termination.mads"); quiet=true)
    bigdtresults::AbstractDict = Mads.bigdt(
        md,
        nsample;
        numhorizons=numhorizons,
        maxHorizon=max_horizon,
        numlikelihoods=numlikelihoods,
        progress_callback=progress_callback
    )
    decision_summary::Vector{SourceTerminationDecisionSummary} = summarize_source_termination(
        md,
        bigdtresults;
        acceptable_failure_probability=acceptable_failure_probability
    )

    if write_plots
        mkpath(outputdir)
        robustness_root::String = joinpath(outputdir, "source_termination-robustness-$(nsample)")
        robustness_zoom_root::String = joinpath(outputdir, "source_termination-robustness-zoom-$(nsample)")
        Mads.plotrobustnesscurves(md, bigdtresults; filename=robustness_root, format="SVG")
        Mads.plotrobustnesscurves(md, bigdtresults; filename=robustness_root, format="PNG")
        Mads.plotrobustnesscurves(
            md,
            bigdtresults;
            filename=robustness_zoom_root,
            format="PNG",
            maxhoriz=min(0.4, Float64(max_horizon)),
            maxprob=0.1
        )
    end

    run_settings::Dict{String, Any} = Dict{String, Any}(
        "nsample" => nsample,
        "numhorizons" => numhorizons,
        "max_horizon" => Float64(max_horizon),
        "numlikelihoods" => numlikelihoods,
        "acceptable_failure_probability" => Float64(acceptable_failure_probability),
        "seed" => seed,
        "write_plots" => write_plots
    )
    return Dict{String, Any}(
        "maxfailureprobs" => bigdtresults["maxfailureprobs"],
        "horizons" => bigdtresults["horizons"],
        "decision_summary" => decision_summary,
        "run_settings" => run_settings
    )
end

if abspath(PROGRAM_FILE) == @__FILE__
    run_source_termination()
end
