using Mads
using Base.Test

mads_tests = ["optim-lm.jl", "insttest.jl"]

println("Running MADS tests:")

for test in mads_tests
    println(" * $(test)")
    include(test)
end
