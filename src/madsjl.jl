#!/usr/bin/env julia -q --color=yes

if length(ARGS) < 2
	println("Usage: madsjl.jl {mads_dictionary_file}.mads commands ...")
	println("Example: madsjl.jl my_mads_yaml_file.mads forward efast")
	warn("Command line error!")
	quit()
end

import Mads
import JLD

madsfile = ARGS[1]
if isfile(madsfile)
	info("Reading $madsfile ...")
	md = Mads.loadmadsfile(madsfile)
	dir = Mads.getmadsproblemdir(md)
	root = Mads.getmadsrootname(md)
else
	println("Provided first argument $madsfile is not an existing file!")
	warn("Command line error!")
	quit()
end
for i = 2:length(ARGS)
	madscommand = ARGS[i]
	info("""Executing $madscommand ...""")
	if isfile(joinpath(Mads.madsdir, "/Mads/scripts/", string(madscommand, ".jl")))
		include(joinpath(Mads.madsdir, "/Mads/scripts/", string(madscommand, ".jl")))
	end
	result = eval(parse("Mads.$(madscommand)(md)"))
	JLD.save("$(dir)/$(root)-$(madscommand)-results.jld", result)
	display(result)
	println("\ndone.\n")
end

f = open("madsjl.cmdline_hist", "a+")
write(f, join(["$(Dates.now()) :"; "madsjl.jl"; ARGS; "\n"], " ") )
close(f)