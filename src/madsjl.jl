#!/usr/bin/env julia -q --color
import Mads
if VERSION < v"0.4.0-dev"
	using Dates
end

if length(ARGS) > 0
	madscommand = ARGS[1] # TODO flip cmd and file? allow for more cmd's (keywords)?; It might be good to have command first. Some commands don't have a file (e.g., "help"), others may have two (e.g., "diff"). I suggest we have a command then the information needed to execute the command (files, keywords, etc) coming after the command.
	if isfile(joinpath(Mads.madsdir, "cmdline", string(madscommand, ".jl")))
		include(joinpath(Mads.madsdir, "cmdline", string(madscommand, ".jl")))
	elseif length(ARGS) == 2
		madsfile = ARGS[2]
		md = Mads.loadyamlmadsfile(madsfile)
		result = eval(parse("Mads.$(madscommand)(md)"))
		println(result)
	else
		println("Usage: madsjl command filename.mads ...")
		println("Example: madsjl forward test-internal-linearmodel.mads")
		error("Command line error!")
	end
else
	println("Usage: madsjl command filename.mads ...")
	println("Example: madsjl forward test-internal-linearmodel.mads")
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
write(f, join(["$(now()) :";"madsjl"; ARGS; "\n"], " "))
close(f)
