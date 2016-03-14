"MADS output"
function madsoutput(message::AbstractString; level=0)
	if !quiet && level <= verbositylevel
		print(message)
	end
end

"MADS debug messages"
function madsdebug(message::AbstractString; level=0)
	if !quiet && level <= debuglevel
		println("DEBUG: " * Libc.strftime("%Y-%m-%d %H:%M:%S", time()) * " " * message)
	end
end

"MADS information/status messages"
function madsinfo(message::AbstractString)
	!quiet && info(Libc.strftime("%Y-%m-%d %H:%M:%S", time()) * " " * message);
end

"MADS warning messages"
function madswarn(message::AbstractString)
	warn(Libc.strftime("%Y-%m-%d %H:%M:%S", time()) * " " * message);
end

"MADS error messages"
function madserror(message::AbstractString)
	error(Libc.strftime("%Y-%m-%d %H:%M:%S", time()) * " " * message)
end

"MADS critical error messages"
function madscritical(message::AbstractString)
	error(Libc.strftime("%Y-%m-%d %H:%M:%S", time()) * " " * message)
	throw("Mads quits!")
end
