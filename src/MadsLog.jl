@doc "MADS output" ->
function madsoutput(message::String; level=0)
	if level <= verbositylevel
		print(message) # level 0
	end
end
@doc "MADS debug messages" ->
function madsdebug(message::String; level=0)
	if level <= debuglevel
		debug(message) # level 0
	end
end
@doc "MADS information/status messages" ->
function madsinfo(message::String)
	info(message) # level 1
end
@doc "MADS warning messages" ->
function madswarn(message::String)
	warn(message) # level 2
end
@doc "MADS error messages" ->
function madserr(message::String)
	err(message) # level 3
end
@doc "MADS critical error messages" ->
function madscrit(message::String)
	critical(message) # level 4
end
