import DocumentFunction

"""
MADS output (controlled by `quiet` and `verbositylevel`)

$(DocumentFunction.documentfunction(madsoutput;
argtext=Dict("message"=>"output message",
            "level"=>"[default=`0`]")))
"""
function madsoutput(message::String, level::Int=0)
	if !quiet && level < verbositylevel
		print(message)
		flush(STDOUT)
	end
end

"""
MADS debug messages (controlled by `quiet` and `debuglevel`)

$(DocumentFunction.documentfunction(madsdebug;
argtext=Dict("message"=>"debug message",
            "level"=>"[default=`0`]")))
"""
function madsdebug(message::String, level::Int=0)
	if !quiet && level < debuglevel
		print_with_color(:green,  "DEBUG: " * Libc.strftime("%Y-%m-%d %H:%M:%S", time()) * " " * message * "\n")
		flush(STDOUT)
	end
end

"""
MADS information/status messages (controlled by quiet` and `verbositylevel`)

$(DocumentFunction.documentfunction(madsinfo;
argtext=Dict("message"=>"information/status message",
            "level"=>"[default=`0`]")))
"""
function madsinfo(message::String, level::Int=0)
	if !quiet && level < verbositylevel
		print_with_color(:blue, "INFO: " * Libc.strftime("%Y-%m-%d %H:%M:%S", time()) * " " * message * "\n");
		flush(STDOUT)
	end
end

"""
MADS warning messages

$(DocumentFunction.documentfunction(madswarn;
argtext=Dict("message"=>"warning message")))
"""
function madswarn(message::String)
	print_with_color(:red, "WARNING: " * Libc.strftime("%Y-%m-%d %H:%M:%S", time()) * " " * message  * "\n");
	flush(STDOUT)
	flush(STDERR)
end

"""
MADS error messages

$(DocumentFunction.documentfunction(madserror;
argtext=Dict("message"=>"error message")))
"""
function madserror(message::String)
	error(Libc.strftime("%Y-%m-%d %H:%M:%S", time()) * " " * message)
	flush(STDOUT)
	flush(STDERR)
end

"""
MADS critical error messages

$(DocumentFunction.documentfunction(madscritical;
argtext=Dict("message"=>"critical error message")))
"""
function madscritical(message::String)
	error(Libc.strftime("%Y-%m-%d %H:%M:%S", time()) * " " * message)
	throw("Mads quits!")
end
