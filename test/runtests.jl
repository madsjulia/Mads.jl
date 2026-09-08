import Mads
import Test
import Gadfly

Mads.veryquieton()
Mads.graphoff()

Test.@testset "SVG plotting" begin
	mktempdir() do output_dir::String
		output_file::String = joinpath(output_dir, "mads-test.svg")
		Gadfly.draw(Gadfly.SVG(output_file, 2Gadfly.inch, 1Gadfly.inch), Gadfly.plot(x=[1.0, 2.0], y=[1.0, 4.0], Gadfly.Geom.line))
		Test.@test filesize(output_file) > 0
	end
end

@info("Running MADS tests:")

printstyled("* miscellaneous ...\n"; color=:cyan)
@elapsed include("miscellaneous.jl")

printstyled("* io ...\n"; color=:cyan)
@elapsed include("io.jl")

printstyled("* file naming ...\n"; color=:cyan)
@elapsed include("filename.jl")

printstyled("* test functions ...\n"; color=:cyan)
@elapsed include("test_functions.jl")

printstyled("* create problem ...\n"; color=:cyan)
@elapsed include("createproblem.jl")

printstyled("* parameters ...\n"; color=:cyan)
@elapsed include("parameters.jl")

printstyled("* observations ...\n"; color=:cyan)
@elapsed include("observations.jl")

for madstest in Mads.examples()
	if !occursin(r"_[1-9]", madstest) # skip restarts
		file = joinpath(Mads.dir, "examples", madstest, "runtests.jl")
		if isfile(file)
			Mads.graphoff()
			printstyled("* $(madstest) ...\n"; color=:cyan)
			@elapsed include(file)
		end
	end
end

Mads.veryquietoff()
Mads.graphon()

:passed
