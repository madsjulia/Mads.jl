using Mads
Logging.configure(level=Logging.OFF)

#run(`rm -R tests/restart`)

include("../tests/optimization_rosenbrock.jl")

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
include("../tests/optimization_linear_problem.jl")
#include("tests/optimization_linear_problem_nlopt.jl") NLopt is currently disabled
# senstivity
include("../tests/saltelli_sensitvity_analysis.jl")
include("../tests/saltelli_sensitvity_analysis_parallel.jl")
cd("tests")
include("../tests/bayesian_sampling.jl")
include("../tests/montecarlo.jl")
cd("..")
include("../tests/gsl_call.jl")
