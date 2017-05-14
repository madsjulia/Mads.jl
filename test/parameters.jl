import Mads
import Base.Test

@Base.Test.testset "Parameters" begin
	test_dict = Dict("a"=>1)
	@Base.Test.test Mads.isparam(test_dict, Dict("a"=>1)) == true
	test_dict["b"] = 1
	@Base.Test.test Mads.isparam(test_dict, Dict("a"=>1)) == false
	
	param_dict = Dict("Parameters"=>Dict("a"=>Dict()))
	@Base.Test.test Mads.getparamsmin(param_dict) == [-1.0e6]
	@Base.Test.test Mads.getparamsmax(param_dict) == [+1.0e6]
	
	param_dict["Parameters"]["a"] = Dict("log"=>true)
	@Base.Test.test Mads.getparamsmin(param_dict) == [1.0e-6]
	@Base.Test.test Mads.getparamsmax(param_dict) == [1.0e+6]
	@Base.Test.test Mads.getparamsinit_min(param_dict) == [1.0e-6]
	@Base.Test.test Mads.getparamsinit_max(param_dict) == [1.0e+6]
	
	param_dict["Parameters"]["a"] = Dict("init_min"=>14)
	@Base.Test.test Mads.getparamsinit_min(param_dict) == [14]
	param_dict["Parameters"]["a"] = Dict("init_max"=>16)
	@Base.Test.test Mads.getparamsinit_max(param_dict) == [16]
	
	dist_dict = Dict("Parameters"=>Dict("a"=>Dict("log"=>true, "type"=>"opt", "dist"=>"Uniform(14,15)")))
	@Base.Test.test isapprox(Mads.getparamrandom(dist_dict, "a")[1], 14.5, atol=0.5)
	#dist_dict["Parameters"]["a"]["dist"] = "Normal(14,7)"
	#println(Mads.getparamrandom(dist_dict, "a"))
	@Base.Test.test Mads.void2nan!(Dict("a"=>Dict{Any,Any}("a"=>nothing))) == nothing
	@Base.Test.test Mads.void2nan!(Dict("a"=>Dict{Any,Any}("a"=>Dict{Any,Any}("a"=>nothing)))) == nothing
	
	basic_dict = Dict("a"=>1)
	@Base.Test.test Mads.filterkeys(basic_dict, "a") == String["a"]
	@Base.Test.test Mads.filterkeys(basic_dict, r"a") == String["a"]
	@Base.Test.test Mads.getdictvalues(basic_dict, "a")[1][2] == 1
	@Base.Test.test Mads.getdictvalues(basic_dict, r"a")[1][2] == 1
	
	# TODO: Verify that maxtorealmax! is working correctly...returns `nothing` currently
	#@Base.Test.test 4 == Mads.maxtorealmax!(convert(DataFrames.DataFrame, [1:4 1:4]))
	#@Base.Test.test realmax(Float32) == Mads.maxtorealmax!(convert(DataFrames.DataFrame, [[1,2] [1,realmax(Float64)]]))
end