#!/usr/bin/env julia -q --color=yes

if length(ARGS) < 2
	println("Usage: madsjl.jl {mads_dictionary_file}.mads commands ...")
	println("Examples: madsjl.jl my_mads_yaml_file.mads forward efast")
	println("          madsjl.jl diff my_mads_yaml_file1.mads my_mads_yaml_file2.mads")
	println("          madsjl.jl help")
	warn("Command line error!")
	quit()
end

import JLD
import Mads

madsfile = ARGS[1]
if isfile(madsfile)
	info("Reading $madsfile ...")
	md = Mads.loadmadsfile(madsfile)
	dir = Mads.getmadsproblemdir(md)
	root = Mads.getmadsrootname(md)
	start = 2
else
	start = 1
end
for i = start:length(ARGS)
	madscommand = ARGS[i]
	if isfile(joinpath(Mads.madsdir, "../scripts/", string(madscommand, ".jl")))
		s = joinpath(Mads.madsdir, "../scripts/", string(madscommand, ".jl"))
		info("Executing script $(s) ...")
		include(s)
		if start == 1
			info("done.")
			quit()
		end 
	elseif isfile(string(madscommand, ".jl"))
		s = string(madscommand, ".jl")
		info("Executing script $(s) ...")
		include(s)
		if start == 1
			info("done.")
			quit()
		end 
	else
		if start == 2
			info("Executing Mads command $madscommand ...")
			result = eval(parse("Mads.$(madscommand)(md)"))
			JLD.save("$(dir)/$(root)-$(madscommand)-results.jld", result)
			display(result)
			println("")
		end
	end
	info("done.")
end

f = open("madsjl.cmdline_hist", "a+")
write(f, join(["$(Dates.now()) :"; "madsjl.jl"; ARGS; "\n"], " ") )
close(f)