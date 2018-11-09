import Mads
import Test

Mads.veryquieton()
Mads.graphoff()

try
	Gadfly.draw(Gadfly.PNG("test.png", 2Gadfly.inch, 1Gadfly.inch, dpi=100), Gadfly.plot(x=rand(10), Gadfly.Geom.histogram()))
	Mads.rmfile("test.png")
catch
	ENV["MADS_NO_GADFLY"] = ""
	ENV["MADS_NO_PYPLOT"] = ""
	ENV["MADS_NO_DISPLAY"] = ""
	@warn("Mads plotting is disabled; Gadfly fails!")
end

@info("Running MADS tests:")

printstyled("* miscellaneous ...\n", color=:cyan)
@elapsed include("miscellaneous.jl")

printstyled("* io ...\n", color=:cyan)
@elapsed include("io.jl")

printstyled("* file naming ...\n", color=:cyan)
@elapsed include("filename.jl")

printstyled("* test functions ...\n", color=:cyan)
@elapsed include("test_functions.jl")

printstyled("* parameters ...\n", color=:cyan)
@elapsed include("parameters.jl")

printstyled("* observations ...\n", color=:cyan)
@elapsed include("observations.jl")

examples = readdir(joinpath(Mads.madsdir, "examples"))

for madstest in examples
	file = joinpath(Mads.madsdir, "examples", madstest, "runtests.jl")
	if isfile(file)
		printstyled("* $(madstest) ...\n", color=:cyan)
		@elapsed include(file)
	end
end

Mads.veryquietoff()
Mads.graphon()

:passed