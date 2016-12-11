if VERSION >= v"0.5"
	@tryimport PkgDev
end

"Checkout the latest version of the Mads modules"
function checkout(git::Bool=true)
	for i in madsmodules
		if git
			info("Checking out $(i) ...")
			cwd = pwd()
			cd(Pkg.dir(i))
			run(`git pull`)
			cd(cwd)
		else
			try
				Pkg.checkout(i)
			catch
				warn("$i cannot be checked out; most probably it is dirty!")
			end
		end
	end
end

"Status of the Mads modules"
function status(; git::Bool=true, gitmore::Bool=false)
	for i in madsmodules
		Mads.status(i, git=git, gitmore=gitmore)
	end
end
function status(madsmodule::String; git::Bool=true, gitmore::Bool=false)
	try
		run(pipeline(`git help`, stdout=DevNull, stderr=DevNull))
	catch
		git = false
	end
	if git
		cwd = pwd()
		info("Git status $(madsmodule) ...")
		cd(Pkg.dir(madsmodule))
		run(`git status -s`)
		if gitmore
			info("Git ID HEAD   $(madsmodule) ...")
			run(`git rev-parse --verify HEAD`)
			info("Git ID master $(madsmodule) ...")
			run(`git rev-parse --verify master`)
		end
		cd(cwd)
	else
		originalSTDOUT = STDOUT;
		tag_flag = false
		o = ""
		try
			(outRead, outWrite) = redirect_stdout();
			Pkg.status(madsmodule)
			o = readavailable(outRead);
			close(outWrite);
			close(outRead);
			redirect_stdout(originalSTDOUT);
		catch
			redirect_stdout(originalSTDOUT);
		end
		a = ascii(String(o))
		print(a)
		if ismatch(r"(dirty)", a)
			warn("$madsmodule latest changes are not committed!")
			tag_flag = false
		elseif ismatch(r"[0-9]\+", a)
			warn("$madsmodule latest changes are not tagged!")
			tag_flag = true
		elseif ismatch(r"master", a)
			info("$madsmodule latest changes are already tagged!")
			tag_flag = false
		end
		return tag_flag
	end
end

"Tag the Mads modules with a default argument `:patch`"
function tag(sym::Symbol=:patch)
	for i in madsmodules
		Mads.tag(i, sym)
	end
end
function tag(madsmodule::String, sym::Symbol=:patch)
	tag_flag = Mads.status(madsmodule, git=false)
	if tag_flag
		if VERSION < v"0.5"
			Pkg.tag(madsmodule, sym)
		elseif isdefined(:PkgDev)
			PkgDev.tag(madsmodule, sym)
		else
			warn("PkgDev is missing!")
		end
		info("$madsmodule is now tagged!")
	else
		warn("$madsmodule cannot be tagged!")
	end
end

"Use the latest tagged versions of the Mads modules"
function free()
	for i in madsmodules
		Pkg.free(i)
	end
end

"Create web documentation files for Mads functions"
function create_documentation()
	Documenter.makedocs(root = Pkg.dir("Mads", "docs"), doctest=false, clean=true)

	d = pwd()
	cd(Pkg.dir("Mads"))
	# run(`git pull gh gh-pages`)
	run(`mkdocs build --clean`)
	run(`mkdocs gh-deploy --clean`)
	cd(d)
	return
end