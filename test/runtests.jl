import Mads
import Base.Test

info("Running MADS tests:")

print_with_color(:cyan, "* miscellaneous ...\n")
tic()
include("miscellaneous.jl")
toc()

print_with_color(:cyan,"* io ...\n")
tic()
include("io.jl")
toc()

print_with_color(:cyan, "* file naming ...\n")
tic()
include("filename.jl")
toc()

print_with_color(:cyan, "* test functions ...\n")
tic()
include("test_functions.jl")
toc()

print_with_color(:cyan, "* parameters ...\n")
tic()
include("parameters.jl")
toc()

print_with_color(:cyan, "* observations ...\n")
tic()
include("observations.jl")
toc()

examples = readdir(joinpath(Mads.madsdir, "examples"))

for madstest in examples
	file = joinpath(Mads.madsdir, "examples", madstest, "runtests.jl")
	if isfile(file)
		print_with_color(:cyan, "* $(madstest) ...\n")
        tic()
		include(file)
        toc()
	end
end
:passed