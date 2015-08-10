import Mads

filenames = readdir(joinpath(Mads.madsdir, "cmdline"))
println("Usage: madsjl command filename.mads ...")
println("Example: madsjl forward test-internal-linearmodel.mads")
println("Some available commands:")
for filename in filenames
	if filename[end-2:end] == ".jl"
		println(filename[1:end-3])
	end
end
