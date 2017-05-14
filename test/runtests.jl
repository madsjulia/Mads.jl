import Mads
import Base.Test

info("Running MADS tests:")

print_with_color(:cyan, "* miscellaneous ...\n")
include("miscellaneous.jl")

print_with_color(:cyan,"* io ...\n")
include("io.jl")

print_with_color(:cyan, "* file naming ...\n")
include("filename.jl")

print_with_color(:cyan, "* test functions ...\n")
include("test_functions.jl")

print_with_color(:cyan, "* parameters ...\n")
include("parameters.jl")

print_with_color(:cyan, "* observations ...\n")
include("observations.jl")

examples = readdir(joinpath(Pkg.dir("Mads"), "examples"))

for madstest in examples
	file = joinpath(Pkg.dir("Mads"), "examples", madstest, "runtests.jl")
	if isfile(file)
		print_with_color(:cyan, "* $(madstest) ...\n")
		include(file)
	end
end
:passed