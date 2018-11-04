println("Usage: madsjl.jl {mads_dictionary_file}.mads commands ...")
println("Examples: madsjl.jl my_mads_yaml_file.mads forward efast")
println("          madsjl.jl diff my_mads_yaml_file1.mads my_mads_yaml_file2.mads")
println("          madsjl.jl help")
println("")

filenames = readdir(joinpath(Mads.madsdir, "scripts"))
@info("Some available commands:")
for filename in filenames
	if filename[end-2:end] == ".jl"
		println(filename[1:end-3])
	end
end
