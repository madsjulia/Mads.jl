#!/usr/bin/env julia -q
import Mads
if VERSION < v"0.4.0-dev"
	using Dates
end

if length(ARGS) > 0
	madscommand = ARGS[1] # TODO flip cmd and file? allow for more cmd's (keywords)?
	if isfile(joinpath(Mads.madsdir, "cmdline", string(madscommand, ".jl")))
		include(joinpath(Mads.madsdir, "cmdline", string(madscommand, ".jl")))
	elseif length(ARGS) == 2
		madsfile = ARGS[2]
		println(pwd())
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

if !isfile(madsfile)
	Mads.madserr("""Mads input file: $(madsfile) is missing; quit!""")
	error("$(madsfile) is missing")
end

Mads.madsinfo("""Mads input file: $(madsfile)""")

madsdirname = string((dirname(Base.source_path())))
Mads.madsinfo("""Mads working directory: $(madsdirname)""")
Mads.setmadsinputfile(madsfile)

f = open(madsdirname * "madsjl_cmdline_hist", "a+")
write(f, join(["$(now()) :";"madsjl"; ARGS; "\n"], " "))
close(f)
