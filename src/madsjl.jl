#!/usr/bin/env julia -q --color
import Mads

if length(ARGS) > 0
	if length(ARGS) > 1
		madsfile = ARGS[1]
		if isfile(madsfile)
			md = Mads.loadmadsfile(madsfile)
		else
			Mads.err("""Provided argument $madsfile is not an existing file!""")
		end
	elseif length(ARGS) == 2
		madscommand = ARGS[2]
		if isfile(joinpath(Mads.madsdir, "cmdline", string(madscommand, ".jl")))
		include(joinpath(Mads.madsdir, "cmdline", string(madscommand, ".jl")))
		madsfile = ARGS[2]
		md = Mads.loadmadsfile(madsfile)
		result = eval(parse("Mads.$(madscommand)(md)"))
		println(result)
	else
		println("Usage: madsjl.jl filename.mads commands ...")
		println("Example: madsjl.jl test-internal-linearmodel.mads forward efast")
		error("Command line error!")
	end
else
	println("Usage: madsjl.jl filename.mads commands ...")
	println("Example: madsjl.jl test-internal-linearmodel.mads forward efast")
	error("Command line error!")
end

#=
if !isfile(madsfile)
	Mads.madserr("""Mads input file: $(madsfile) is missing; quit!""")
	error("$(madsfile) is missing")
end

Mads.madsinfo("""Mads input file: $(madsfile)""")

madsdirname = string((dirname(Base.source_path())))
Mads.madsinfo("""Mads working directory: $(madsdirname)""")
Mads.setmadsinputfile(madsfile)
=#

# Should we put this at the top? I would like to keep the history even if there is an error.
f = open("madsjl_cmdline_hist", "a+")
write(f, join(["$(Dates.now()) :";"madsjl"; ARGS; "\n"], " "))
close(f)
