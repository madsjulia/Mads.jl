using Mads

mads_tests = ["sa-efast.jl", "optim-lm.jl"]

println("Running MADS tests:")

for test in mads_tests
    println(" * $(test)")
    include(test)
end