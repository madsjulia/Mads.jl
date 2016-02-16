import Mads
using Base.Test

# "../examples/anasol/anasol.jl"

mads_tests = ["optimization-lm.jl", "../examples/reading_instructions/runtests.jl", "../examples/restart/runtests.jl", "../examples/sensitivity/runtests.jl", "../examples/gsl/runtests.jl", "../examples/model_coupling/runtests.jl", "../examples/bigdt/runtests.jl", "../examples/contamination/runtests.jl", "../examples/bayesian_sampling/runtests.jl", "../examples/montecarlo/runtests.jl"]

println("Running MADS tests:")

for test in mads_tests
    println(" * $(test) ...")
    include(test)
end
