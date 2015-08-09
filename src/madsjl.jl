#!/usr/bin/env julia -q
import Mads

f = open("madsjl_cmdline_hist", "a+")
write(f, join(["madsjl"; ARGS; "\n"], " "))
close(f)
if length(ARGS) > 0
	madscommand = ARGS[1]
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
	end
else
	println("Usage: madsjl command filename.mads ...")
	println("Example: madsjl forward test-internal-linearmodel.mads")
end
