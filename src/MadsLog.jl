@doc "MADS output" ->
function madsoutput(message::AbstractString; level=0)
	if level <= verbositylevel
		print(message) # level 0
	end
end
@doc "MADS debug messages" ->
function madsdebug(message::AbstractString; level=0)
	if level <= debuglevel
		Logging.debug(message) # level 0
	end
end
@doc "MADS information/status messages" ->
function madsinfo(message::AbstractString)
	Logging.info(message) # level 1
end
@doc "MADS warning messages" ->
function madswarn(message::AbstractString)
	Logging.warn(message) # level 2
end
@doc "MADS error messages" ->
function madserr(message::AbstractString)
	Logging.err(message) # level 3
end
@doc "MADS critical error messages" ->
function madscrit(message::AbstractString)
	Logging.critical(message) # level 4
	throw("Mads quits!")
end
