"MADS output"
function madsoutput(message::AbstractString; level=0)
	if !quiet && level <= verbositylevel
		print(message) # level 0
	end
end

"MADS debug messages"
function madsdebug(message::AbstractString; level=0)
	if !quiet && level <= debuglevel
		info(message) # level 0
	end
end

"MADS information/status messages"
function madsinfo(message::AbstractString)
	!quiet && info(message); # level 1
end

"MADS warning messages"
function madswarn(message::AbstractString)
	!quiet && warn(message); # level 2
end

"MADS error messages"
function madserr(message::AbstractString)
	warn(message) # level 3
end

"MADS critical error messages"
function madscrit(message::AbstractString)
	warn(message) # level 4
	throw("Mads quits!")
end
