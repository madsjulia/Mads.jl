# Bayesian Information Gap Decision Theory examples

The [contaminant source-termination decision example](./source_termination.md) compares four remediation schedules under probabilistic and non-probabilistic uncertainty.

Run the standard deterministic example from an activated Mads environment:

```julia
import Mads
include(joinpath(Mads.dir, "examples", "bigdt", "source_termination.jl"))
results::AbstractDict = run_source_termination()
```

Use a smaller sample and horizon count for a quick calculation without writing plots:

```julia
quick_results::AbstractDict = run_source_termination(
	nsample=200,
	numhorizons=40,
	numlikelihoods=3,
	write_plots=false,
)
```

The returned dictionary preserves the `maxfailureprobs` and `horizons` arrays and adds a ranked `decision_summary` plus reproducible `run_settings`.

When a failure threshold is not reached within the tested uncertainty range, its summary uses `robustness_horizon = nothing` and `threshold_reached = false` instead of reporting the maximum tested horizon as an exact crossing.

An interactive version of this workflow is available in the [EnviCloud decision-support demo](https://cloud.envitrace.com/demos/decision-support).
