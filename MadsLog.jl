function madsdebug(message::String; level=1)
	if level > madsdebuglevel
		debug(message) # level 0
	end
end
function madsinfo(message::String; level=1)
	if level > madsinfolevel
		info(message) # level 1
	end
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
