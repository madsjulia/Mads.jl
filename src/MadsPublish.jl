"Checkout the latest version of the Mads modules"
function checkout()
	for i in madsmodules
		Pkg.checkout(i)
	end
end

"Status of the Mads modules"
function status()
	for i in madsmodules
		Mads.status(i)
	end
end

function status(testmod::AbstractString)
	originalSTDOUT = STDOUT;
	tag_flag = false
	o = ""
	try
		(outRead, outWrite) = redirect_stdout();
		Pkg.status(testmod)
		o = readavailable(outRead);
		close(outWrite);
		close(outRead);
		redirect_stdout(originalSTDOUT);
	catch
		redirect_stdout(originalSTDOUT);
	end
	a = ascii(o)
	print(a)
	if ismatch(r"(dirty)", a)
		warn("$testmod latest changes are not committed!")
		tag_flag = false
	elseif ismatch(r"[0-9]\+", a)
		warn("$testmod latest changes are not tagged!")
		tag_flag = true
	elseif ismatch(r"master", a)
		info("$testmod latest changes are already tagged!")
		tag_flag = false
	end
	return tag_flag
end

"Tag the Mads modules"
function tag()
	for i in madsmodules
		tag_flag = Mads.status(i)
		if tag_flag
			info("$i is now tagged!")
			Pkg.tag(i)
		else
			error("$i cannot be tagged!")
		end
	end
end

function tag(testmod::AbstractString)
	tag_flag = Mads.status(testmod)
	if tag_flag
		info("$testmod is now tagged!")
		Pkg.tag(testmod)
	else
		error("$testmod cannot be tagged!")
	end
end

"Use the latest tagged versions of the Mads modules"
function free()
	for i in madsmodules
		Pkg.free(i)
	end
end