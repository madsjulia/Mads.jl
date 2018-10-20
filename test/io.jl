import Mads
import Base.Test

# If madsdir = '.' then joinpath, else madsdir
workdir = (Mads.getmadsdir() == ".") ? joinpath(Mads.madsdir, "test") : Mads.getmadsdir()
@Mads.stderrcapture function jpath(file::String)
	joinpath(workdir, file)
end

arr = Dict{String,Float64}("a"=>1, "b"=>1.6) # Define an arbitrary dictionary

# Parse extensions and dump/load data accordingly
@Mads.stderrcapture function test_IO(file, data, julia_flag::Bool=false)
	ext = Mads.getextension(jpath(file))

	if ext == "dat"
		Mads.dumpasciifile(jpath(file), data)
		loaded_data = Mads.loadasciifile(jpath(file))
		loaded_data = Dict{String,Float64}(zip((loaded_data[1], loaded_data[2]), (loaded_data[3], loaded_data[4])))
	elseif ext == "json"
		Mads.dumpjsonfile(jpath(file), data)
		loaded_data = Mads.loadjsonfile(jpath(file))
	elseif ext == "yaml"
		Mads.dumpyamlfile(jpath(file), data, julia=julia_flag)
		loaded_data = Mads.loadyamlfile(jpath(file))
	else
		println("Unrecognized filetype")
		Mads.rmfile(jpath(file))
		return
	end
	Mads.rmfile(jpath(file))

	return (data["a"] == loaded_data["a"]) && (data["b"] == loaded_data["b"])
end

df = DataFrames.DataFrame()
df[:Values] = rand(10) * realmax(Float64)
Mads.maxtorealmax!(df)

@Mads.stdouterrcapture Mads.gettime(Dict("o1"=>Dict("c"=>1)))
@Mads.stdouterrcapture resultshouldbenan = Mads.getweight(Dict("ww"=>10))

# Begin the main test block
@Base.Test.testset "IO" begin
	@Base.Test.test test_IO("a.dat", arr)
	@Base.Test.test test_IO("a.json", arr)
	@Base.Test.test test_IO("a.yaml", arr)
	@Base.Test.test test_IO("a.yaml", arr, true)

	# Test removal of files based on root/extension
	file = "root_testing.extension_testing"

	Mads.dumpasciifile(jpath(file), arr)
	@Base.Test.test isfile(jpath(file)) == true
	Mads.rmfiles_ext(String(Mads.getextension(file)); path=workdir)
	@Base.Test.test isfile(jpath(file)) == false
	Mads.dumpasciifile(jpath(file), arr)
	Mads.rmfiles(Regex(file); path=workdir)
	@Base.Test.test isfile(jpath(file)) == false

	Mads.dumpasciifile(jpath(file), arr)
	@Base.Test.test isfile(jpath(file)) == true
	Mads.rmfiles_root(String(Mads.getrootname(file)); path=workdir)
	@Base.Test.test isfile(jpath(file)) == false

	@Base.Test.test Mads.getrestartdir(Dict("Restart"=>"dummy_restart_directory")) == "dummy_restart_directory/"
	@Base.Test.test Mads.getrestartdir(Dict("RestartDir"=>"dummy_restart_directory")) == "dummy_restart_directory/"
	Mads.rmdir("dummy_restart_directory")

	@Base.Test.test Mads.getparamrandom(Dict(), "k") == nothing
	@Base.Test.test Mads.getparamrandom(Dict("Parameters"=>Dict("a"=>1)), "k") == nothing
	@Base.Test.test Mads.isopt(Dict("Parameters"=>Dict("k"=>Dict("init"=>1,"type"=>false))), "k") == false
	@Base.Test.test Mads.isopt(Dict("Parameters"=>Dict("k"=>Dict("init"=>1,"type"=>"opt"))), "k") == true
	@Base.Test.test Mads.setparamon!(Dict("Parameters"=>Dict("k"=>Dict{String,Any}("init"=>1,"type"=>false))), "k") == "opt"
	@Base.Test.test Mads.setparamoff!(Dict("Parameters"=>Dict("k"=>Dict{String,Any}("init"=>1,"type"=>false))), "k") == nothing
	Mads.getparamdistributions(Dict("Parameters"=>Dict("k"=>Dict("init"=>1,"init_dist"=>"Normal(0,1)"))); init_dist=true)

	@Base.Test.test Mads.settime!(Dict("t"=>1),2) == 2
	@Base.Test.test Mads.setweight!(Dict("w"=>1),2) == 2
	@Base.Test.test Mads.getweight(Dict("w"=>1)) == 1
	@Base.Test.test Mads.settarget!(Dict("c"=>1),2) == 2
	@Base.Test.test isnan(resultshouldbenan)

	srand(2017)
	@Base.Test.test isapprox(Mads.getparamrandom(Dict("Parameters"=>Dict("k"=>Dict("init"=>1,"log"=>true,"dist"=>"Normal(1,10)"))), "k")..., 0.107554; atol=1e-5)
end

:passed