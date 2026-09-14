import Mads
import Test
import Gadfly
import Distributed

Mads.veryquieton()
Mads.graphoff()

Test.@testset "SVG plotting" begin
	mktempdir() do output_dir::String
		output_file::String = joinpath(output_dir, "mads-test.svg")
		Gadfly.draw(Gadfly.SVG(output_file, 2Gadfly.inch, 1Gadfly.inch), Gadfly.plot(x=[1.0, 2.0], y=[1.0, 4.0], Gadfly.Geom.line))
		Test.@test filesize(output_file) > 0
	end
end

Test.@testset "Spaghetti plot without wells" begin
	mktempdir() do output_dir::String
		output_file::String = joinpath(output_dir, "spaghetti.svg")
		madsdata::Dict{String,Any} = Mads.createproblem(Float64[1.0, 2.0], Float64[1.0, 2.0], identity; obstime=Float64[1.0, 2.0])
		predictions::Matrix{Float64} = Float64[1.0 1.1; 2.0 1.9]
		Mads.spaghettiplot(madsdata, predictions; filename=output_file, format="SVG", quiet=true, hsize=2Gadfly.inch, vsize=1Gadfly.inch)
		Test.@test filesize(output_file) > 0
	end
end

Test.@testset "Dynamically imported functions" begin
	mktempdir() do source_directory::String
		source_file::String = joinpath(source_directory, "dynamic_function.jl")
		write(source_file, "function mads_importeverywhere_test(value::Int; offset::Int=1)::Int\n\treturn value + offset\nend\n")
		dynamic_function::Function = Mads.importeverywhere(source_file)
		Test.@test dynamic_function isa Function
		Test.@test dynamic_function(1; offset=2) == 3
		Test.@test Distributed.pmap(dynamic_function, Int[1, 2]) == Int[2, 3]
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
