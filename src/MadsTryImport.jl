"Try to import a module in Mads"
macro tryimport(s::Symbol, domain::Symbol=:Mads)
	mname = string(s)
	if !ispkgavailable(mname)
		try
			Pkg.add(mname)
		catch
			@info("Module $(mname) is not available!")
			return nothing
		end
	end
	if !isdefined(domain, s)
		importq = string(:(import $(s)))
		warnstring = "Module $(mname) cannot be imported!"
		q = quote
			try
				Core.eval($(eval(domain)), Meta.parse($(importq)))
			catch errmsg
				printerrormsg(errmsg)
				@warn($(warnstring))
			end
		end
		return :($(esc(q)))
	end
end

"Try to import a module in Main"
macro tryimportmain(s::Symbol)
	quote
		Mads.@tryimport $(s) Main
	end
end