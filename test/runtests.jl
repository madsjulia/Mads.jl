import Mads
import Base.Test

println("Running MADS tests:")

println("* miscellaneous ...")
include("miscellaneous.jl")

println("* io ...")
include("io.jl")

println("* test functions ...")
include("test_functions.jl")

println("* parameters ...")
include("parameters.jl")

println("* observations ...")
include("observations.jl")

examples = readdir(joinpath(Pkg.dir("Mads"), "examples"))

for madstest in examples
	file = joinpath(Pkg.dir("Mads"), "examples", madstest, "runtests.jl")
	if isfile(file)
		println("* $(madstest) ...")
		include(file)
	end
end
:passed