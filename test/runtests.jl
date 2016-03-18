import Mads
using Base.Test

examples = readdir(Pkg.dir("Mads") * "/examples/")

println("Running MADS tests:")

for madstest in examples
    file = Pkg.dir("Mads") * "/examples/" * madstest * "/runtests.jl"
    if isfile(file)
    	println(" * $(madstest) ...")
    	include(file)
    end
end
