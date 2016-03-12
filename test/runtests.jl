import Mads
using Base.Test

# mads_tests = ["../examples/optimization/runtests.jl", "../examples/reading_instructions/runtests.jl", "../examples/restart/runtests.jl", "../examples/sensitivity/runtests.jl", "../examples/gsl/runtests.jl", "../examples/model_coupling/runtests.jl", "../examples/bigdt/runtests.jl", "../examples/contamination/runtests.jl", "../examples/bayesian_sampling/runtests.jl", "../examples/montecarlo/runtests.jl"]

examples = readdir(Pkg.dir("Mads") * "/examples/")

println("Running MADS tests:")

for madstest in examples
    file = Pkg.dir("Mads") * "/examples/" * madstest * "/runtests.jl"
    if isfile(file)
    	println(" * $(madstest) ...")
    	include(file)
    end
end
