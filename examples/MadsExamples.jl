import Mads

@info("Optimization ...")

include("optimization/optimization_rosenbrock.jl")
#include("wells/optimization_wells.jl")
include("optimization/optimization_external_yaml_problem.jl")
include("optimization/optimization_external_ascii_problem.jl")
include("optimization/optimization_linear_problem.jl")
include("optimization/optimization_linear_problem+template.jl")

@info("Sensitivity ...")
include("sensitivity/sensitivity_analysis.jl")
include("sensitivity/sensitivity_analysis_parallel.jl")

@info("Bayesian sampling ...")
include("bayesian_sampling/bayesian_sampling.jl")

@info("Monte Carlo analysis ...")
include("montecarlo/montecarlo.jl")

@info("Call of a GSL function ...")
include("gsl/runtests.jl")

@info("Analytical contaminant transport solver (anasol) ...")
include("anasol/runtests.jl")
