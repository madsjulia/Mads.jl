"MADS output"
function madsoutput(message::AbstractString; level=0)
	if !quiet && level <= verbositylevel
		print(message) # level 0
	end
end

"MADS debug messages"
function madsdebug(message::AbstractString; level=0)
	if !quiet && level <= debuglevel
		Logging.debug(message) # level 0
	end
end

"MADS information/status messages"
function madsinfo(message::AbstractString)
	!quiet && Logging.info(message); # level 1
end

"MADS warning messages"
function madswarn(message::AbstractString)
	!quiet && Logging.warn(message); # level 2
end

"MADS error messages"
function madserr(message::AbstractString)
	Logging.madserr(message) # level 3
end

"MADS critical error messages"
function madscrit(message::AbstractString)
	Logging.critical(message) # level 4
	throw("Mads quits!")
end
