import Mads
import Base.Test

# Test observations functions
function test_obs()
	test_dict = Dict("a"=>1)
	@Base.Test.test Mads.isobs(test_dict, Dict("a"=>1)) == true
	
	test_dict["b"] = 2
	@Base.Test.test Mads.isobs(test_dict, Dict("a"=>1)) == false
	
	obs_dict = Dict("Observations"=>Dict("a"=>Dict()))
	@Base.Test.test Mads.getobsdist(obs_dict) == String["Uniform(-1e6, 1e6)"]
	
	obs_dict["Observations"]["a"] = Dict("log"=>true)
	@Base.Test.test Mads.getobsdist(obs_dict) == String["Uniform(1e-6, 1e6)"]
	
	obs_dict = Dict("Observations"=>Dict("a"=>Dict("dist"=>"Uniform(14,15)")))
	@Base.Test.test Mads.getobsmin(obs_dict) == [14]
	@Base.Test.test Mads.getobsmax(obs_dict) == [15]
end

# Test parameter setting functions
function test_params(a=4,b=12,c=7)
	test_dict = Dict("a"=>1)
	
	Mads.settime!(test_dict, a)
	Mads.setweight!(test_dict, b)
	Mads.settarget!(test_dict, c)
	
	@Base.Test.test Mads.gettime(test_dict) == a
	@Base.Test.test Mads.getweight(test_dict) == b
	@Base.Test.test Mads.gettarget(test_dict) == c
end


@Base.Test.testset "Observations" begin
	test_obs()
	test_params()
end