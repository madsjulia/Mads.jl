import Mads
import Test

function identity_observations(parameters::AbstractVector{<:Real})::Vector{Float64}
	return Float64.(parameters)
end

@Test.testset "Create problem from parameter and observation files" begin
	mktempdir() do temporary_directory::String
		parameter_file::String = joinpath(temporary_directory, "parameters.txt")
		observation_file::String = joinpath(temporary_directory, "observations.txt")
		write(parameter_file, "name value dist\np1 1.5 \"Uniform(1, 2)\"\np2 2.5 \"Uniform(2, 3)\"\n")
		write(observation_file, "target weight dist\n1.5 1 \"Uniform(1, 2)\"\n2.5 0 \"\"\n")

		madsdata::Dict{String,Any} = Mads.createproblem(parameter_file, observation_file, identity_observations; problemname="file_problem")

		@Test.test madsdata["Filename"] == "file_problem.mads"
		@Test.test Mads.getparamkeys(madsdata) == ["p1", "p2"]
		@Test.test Mads.getparamsinit(madsdata) == [1.5, 2.5]
		@Test.test collect(values(Mads.forward(madsdata))) == [1.5, 2.5]
	end

	random_problem::Dict{String,Any} = Mads.createproblem(2, 2, identity_observations)
	@Test.test length(Mads.getparamkeys(random_problem)) == 2
	@Test.test length(Mads.getobskeys(random_problem)) == 2

	callback_problem::Dict{String,Any} = Mads.createproblem(
		Float64[1.0],
		Float64[2.0],
		identity_observations;
		paramkey=String["p1"],
		paramdist=String["Uniform(0, 3)"],
		obsweight=Float64[1.0],
	)
	callback_count::Base.RefValue{Int} = Ref(0)
	iteration_callback::Function = (
		best_parameters::AbstractVector,
		objective::Number,
		current_lambda::Number,
	) -> begin
		callback_count[] += 1
		return nothing
	end
	Mads.calibrate(
		callback_problem;
		maxEval=20,
		maxIter=3,
		maxJacobians=3,
		np_lambda=2,
		quiet=true,
		store_optimization_progress=false,
		parallel_optimization=false,
		callbackiteration=iteration_callback,
	)
	@Test.test callback_count[] > 0
end

:passed
