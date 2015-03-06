using Mads
Logging.configure(level=Logging.OFF)

include("tests/optimization_rosenbrock.jl")

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

# internal execution test
include("tests/optimization_linear_problem.jl")
# senstivity
include("tests/saltelli_sensitvity_analysis.jl")
include("tests/saltelli_sensitvity_analysis_parallel.jl")
include("tests/bayesian_sampling.jl")
include("tests/gsl_call.jl")
