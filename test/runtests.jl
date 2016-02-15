import Mads
using Base.Test

# "../examples/model_coupling/runtests.jl", 
mads_tests = ["optimization-lm.jl", "../examples/reading_instructions/runtests.jl", "../examples/restart/runtests.jl", "../examples/sensitivity/runtests.jl", "../examples/restart/runtests.jl", "../examples/anasol/anasol.jl", "../examples/bayesian_sampling/bayesian_sampling.jl"]

println("Running MADS tests:")

for test in mads_tests
    println(" * $(test) ...")
    include(test)
end
