using Mads
Logging.configure(level=Logging.OFF)

#run(`rm -R tests/restart`)

include("optimization_rosenbrock.jl")

if isdefined(ARGS) && ARGS[1] == "doslowtests"
	cd("examples/wells-short")
	include("optimization_wells.jl")
	cd("../..")

	# Optimization of external YAML problem
	cd("tests")
	include("optimization_external_yaml_problem.jl") # WORKS but slow
	cd("..")

	# external execution test using ASCII files
	cd("tests")
	include("optimization_external_ascii_problem.jl")
	cd("..")
else
	Mads.madswarn("skipping slow tests")
end

# internal execution test
include("optimization/optimization_linear_problem.jl")
include("optimization/optimization_linear_problem+template.jl")
# include("optimization/optimization_linear_problem_nlopt.jl") NLopt is currently disabled
# senstivity
#include("saltelli_sensitvity_analysis.jl")
#include("saltelli_sensitvity_analysis_parallel.jl")
include("bayesian_sampling/bayesian_sampling.jl")
include("montecarlo/montecarlo.jl")
include("gsl_call/gsl_call.jl")
include("anasol/anasol.jl")
