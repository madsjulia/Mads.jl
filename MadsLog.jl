function madsdebug(message::String)
  debug(message) # level 0
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
