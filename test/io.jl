import Mads
import Base.Test

# If madsdir = '.' then joinpath, else madsdir 
workdir = (Mads.getmadsdir() == ".") ? joinpath(Mads.madsdir, "..", "test") : Mads.getmadsdir()
jpath(file::String) = joinpath(workdir, file) # A small function for condensing join path

arr = Dict{String,Float64}("a"=>1, "b"=>1.6) # Define an arbitrary dictionary

# Parse extensions and dump/load data accordingly
function test_IO(file, data, julia_flag=false)
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

	@Base.Test.test (data["a"] == loaded_data["a"]) && (data["b"] == loaded_data["b"])

	Mads.rmfile(jpath(file))
end

# Test removal of files based on root/extension
function test_filename_parse(file)
	Mads.dumpasciifile(jpath(file), arr)
	@Base.Test.test isfile(jpath(file)) == true
	Mads.rmfiles_ext(String(Mads.getextension(file)); path=workdir)
	@Base.Test.test isfile(jpath(file)) == false

	Mads.dumpasciifile(jpath(file), arr)
	@Base.Test.test isfile(jpath(file)) == true
	Mads.rmfiles_root(String(Mads.getrootname(file)); path=workdir)
	@Base.Test.test isfile(jpath(file)) == false
end

# Begin the main test block
@Base.Test.testset "IO" begin
	test_IO("a.dat", arr)
	test_IO("a.json", arr)
	test_IO("a.yaml", arr)
	test_IO("a.yaml", arr, true)
	test_filename_parse("root_testing.extension_testing")
end