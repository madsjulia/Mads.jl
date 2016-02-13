using Mads
using Base.Test

mads_tests = ["optim-lm.jl", "instruction_test.jl", "sa-efast.jl", "../examples/anasol/test_anasol.jl"]

println("Running MADS tests:")

for test in mads_tests
    println(" * $(test)")
    include(test)
end
