using Mads

#run(`rm -R tests/restart`)

info("Optimization ...")

include("optimization/optimization_rosenbrock.jl")

if isdefined(ARGS) && ARGS[1] == "doslowtests"
	cd("wells")
	include("optimization_wells.jl")
	cd("..")

	# Optimization of external YAML problem
	cd("optimization")
	include("optimization_external_yaml_problem.jl") # WORKS but slow
	cd("..")

	# external execution test using ASCII files
	cd("optimization")
	include("optimization_external_ascii_problem.jl")
	cd("..")
else
	Mads.madswarn("skipping slow tests")
end

include("optimization/optimization_linear_problem.jl")
include("optimization/optimization_linear_problem+template.jl")
# include("optimization/optimization_linear_problem_nlopt.jl") NLopt is currently disabled
info("Sensitivity ...")
include("sensitivity/saltelli_sensitivity_analysis.jl")
include("sensitivity/saltelli_sensitivity_analysis_parallel.jl")
info("Bayesian sampling ...")
include("bayesian_sampling/bayesian_sampling.jl")
info("Monte Carlo analysis ...")
include("montecarlo/montecarlo.jl")
info("Call of a GSL function ...")
include("gsl_call/gsl_call.jl")
info("Analytical contaminant transport solver (anasol) ...")
include("anasol/anasol.jl")
