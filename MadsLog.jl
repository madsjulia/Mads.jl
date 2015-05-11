function madsoutput(message::String; level=0)
	if level <= madsverbositylevel
		print(message) # level 0
	end
end
function madsdebug(message::String; level=0)
	if level <= madsdebuglevel
		debug(message) # level 0
	end
end
function madsinfo(message::String)
	info(message) # level 1
end
function madswarn(message::String)
	warn(message) # level 2
end
function madserr(message::String)
	err(message) # level 3
end
function madscrit(message::String)
	critical(message) # level 4
end
