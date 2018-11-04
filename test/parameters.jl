import Mads
import Test

@Test.testset "Parameters" begin
	test_dict = Dict("a"=>1)
	@Test.test Mads.isparam(test_dict, Dict("a"=>1)) == true
	test_dict["b"] = 1
	@Test.test Mads.isparam(test_dict, Dict("a"=>1)) == false

	param_dict = Dict("Parameters"=>Dict("a"=>Dict()))
	@Test.test Mads.getparamsmin(param_dict) == [-1.0e6]
	@Test.test Mads.getparamsmax(param_dict) == [+1.0e6]

	param_dict["Parameters"]["a"] = Dict("log"=>true)
	@Test.test Mads.getparamsmin(param_dict) == [1.0e-6]
	@Test.test Mads.getparamsmax(param_dict) == [1.0e+6]
	@Test.test Mads.getparamsinit_min(param_dict) == [1.0e-6]
	@Test.test Mads.getparamsinit_max(param_dict) == [1.0e+6]

	param_dict["Parameters"]["a"] = Dict("init_min"=>14)
	@Test.test Mads.getparamsinit_min(param_dict) == [14]
	param_dict["Parameters"]["a"] = Dict("init_max"=>16)
	@Test.test Mads.getparamsinit_max(param_dict) == [16]

	dist_dict = Dict("Parameters"=>Dict("a"=>Dict("log"=>true, "type"=>"opt", "dist"=>"Uniform(14,15)")))
	@Test.test isapprox(Mads.getparamrandom(dist_dict, "a")[1], 14.5, atol=0.5)
	#dist_dict["Parameters"]["a"]["dist"] = "Normal(14,7)"
	#println(Mads.getparamrandom(dist_dict, "a"))
	@Test.test Mads.void2nan!(Dict("a"=>Dict{Any,Any}("a"=>nothing))) == nothing
	@Test.test Mads.void2nan!(Dict("a"=>Dict{Any,Any}("a"=>Dict{Any,Any}("a"=>nothing)))) == nothing

	basic_dict = Dict("a"=>1)
	@Test.test Mads.filterkeys(basic_dict, "a") == String["a"]
	@Test.test Mads.filterkeys(basic_dict, r"a") == String["a"]
	@Test.test Mads.getdictvalues(basic_dict, "a")[1][2] == 1
	@Test.test Mads.getdictvalues(basic_dict, r"a")[1][2] == 1

	# TODO: Verify that maxtofloatmax! is working correctly...returns `nothing` currently
	#@Test.test 4 == Mads.maxtofloatmax!(convert(DataFrames.DataFrame, [1:4 1:4]))
	#@Test.test floatmax(Float32) == Mads.maxtofloatmax!(convert(DataFrames.DataFrame, [[1,2] [1,floatmax(Float64)]]))
end