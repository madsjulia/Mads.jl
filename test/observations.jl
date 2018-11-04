import Mads
import Test

# Test observations functions
@Test.testset "Observations" begin
	test_dict = Dict("a"=>1)
	@Test.test Mads.isobs(test_dict, Dict("a"=>1)) == true

	test_dict["b"] = 2
	@Test.test Mads.isobs(test_dict, Dict("a"=>1)) == false

	obs_dict = Dict("Observations"=>Dict("a"=>Dict()))
	@Test.test Mads.getobsdist(obs_dict) == String["Uniform(-1e6, 1e6)"]

	obs_dict["Observations"]["a"] = Dict("log"=>true)
	@Test.test Mads.getobsdist(obs_dict) == String["Uniform(1e-6, 1e6)"]

	obs_dict = Dict("Observations"=>Dict("a"=>Dict("dist"=>"Uniform(14,15)")))
	@Test.test Mads.getobsmin(obs_dict) == [14]
	@Test.test Mads.getobsmax(obs_dict) == [15]

	global a=4; b=12; c=7
	test_dict = Dict("a"=>1)

	Mads.settime!(test_dict, a)
	Mads.setweight!(test_dict, b)
	Mads.settarget!(test_dict, c)

	@Test.test Mads.gettime(test_dict) == a
	@Test.test Mads.getweight(test_dict) == b
	@Test.test Mads.gettarget(test_dict) == c
end