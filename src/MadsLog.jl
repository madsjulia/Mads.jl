"MADS output (controlled by quiet` and `verbositylevel`)"
function madsoutput(message::String, level::Int=0)
	if !quiet && level < verbositylevel
		print(message)
		flush(STDOUT)
	end
end

"MADS debug messages (controlled by `quiet` and `debuglevel`)"
function madsdebug(message::String, level::Int=0)
	if !quiet && level < debuglevel
		print_with_color(:green,  "DEBUG: " * Libc.strftime("%Y-%m-%d %H:%M:%S", time()) * " " * message * "\n")
		flush(STDOUT)
	end
end

"MADS information/status messages (controlled by quiet` and `verbositylevel`)"
function madsinfo(message::String, level::Int=0)
	if !quiet && level < verbositylevel
		print_with_color(:blue, "INFO: " * Libc.strftime("%Y-%m-%d %H:%M:%S", time()) * " " * message * "\n");
		flush(STDOUT)
	end
end

"MADS warning messages"
function madswarn(message::String)
	print_with_color(:red, "WARNING: " * Libc.strftime("%Y-%m-%d %H:%M:%S", time()) * " " * message  * "\n");
	flush(STDOUT)
	flush(STDERR)
end

"MADS error messages"
function madserror(message::String)
	error(Libc.strftime("%Y-%m-%d %H:%M:%S", time()) * " " * message)
	flush(STDOUT)
	flush(STDERR)
end

"MADS critical error messages"
function madscritical(message::String)
	error(Libc.strftime("%Y-%m-%d %H:%M:%S", time()) * " " * message)
	throw("Mads quits!")
end
