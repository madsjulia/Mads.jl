"Checkout the latest version of the Mads modules"
function checkout(git::Bool=true)
	for i in madsmodules
		cwd = pwd()
		if git
			info("Checking out $(i) ...")
			cd(Pkg.dir(i))
			run(`git pull`)
		else
			Pkg.checkout(i)
		end
		cd(cwd)
	end
end

"Status of the Mads modules"
function status(; git::Bool=true)
	for i in madsmodules
		Mads.status(i, git=git)
	end
end

function status(testmod::AbstractString; git::Bool=true)
	if git
		cwd = pwd()
		info("Git status $(testmod) ...")
		cd(Pkg.dir(testmod))
		run(`git status -s`)
		cd(cwd)
	else
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
end

"Tag the Mads modules"
function tag()
	for i in madsmodules
		Mads.tag(i)
	end
end

function tag(testmod::AbstractString)
	tag_flag = Mads.status(testmod, git=false)
	if tag_flag
		Pkg.tag(testmod)
		info("$testmod is now tagged!")
	else
		warn("$testmod cannot be tagged!")
	end
end

"Use the latest tagged versions of the Mads modules"
function free()
	for i in madsmodules
		Pkg.free(i)
	end
end