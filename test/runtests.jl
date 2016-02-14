import Mads
using Base.Test

mads_tests = ["optimization-lm.jl", "reading_instructions.jl", "../examples/sensitivity/runtests.jl", "../examples/anasol/anasol.jl"]

println("Running MADS tests:")

for test in mads_tests
    println(" * $(test)")
    include(test)
end
