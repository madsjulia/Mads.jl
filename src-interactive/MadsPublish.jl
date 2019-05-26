import Documenter
import DocumenterMarkdown
import DocumentFunction

"""
Lists modules required by a module (Mads by default)

$(DocumentFunction.documentfunction(required;
argtext=Dict("modulename"=>"module name [default=`\"Mads\"`]",
            "filtermodule"=>"filter module name")))

Returns:

- filtered modules
"""
function required(modulename::String="Mads", filtermodule::String="")
	filename = joinpath(dirname(pathof(eval(Symbol(madsmodule)))), "..", "REQUIRE")
	if isfile(filename)
		modules = readdlm(filename)
		if filtermodule != ""
			i = modules[:,1].==filtermodule
		else
			i = modules[:,1].!="julia"
		end
		return modules[i,:];
	else
		return [filtermodule ""];
	end
end

"""
Lists module dependents on a module (Mads by default)

$(DocumentFunction.documentfunction(dependents;
argtext=Dict("modulename"=>"module name [default=`\"Mads\"`]",
            "filter"=>"whether to filter modules [default=`false`]")))

Returns:

- modules that are dependents of the input module
"""
function dependents(modulename::String="Mads", filter::Bool=false)
	depmodules = Pkg.dependents(modulename)
	modules = Array{Any}(undef, (0, 2))
	for i in depmodules
		modules = [modules; [i Mads.required(i, modulename)[:,2]]]
	end
	if filter
		i = modules[:,2].!=""
		modules = modules[i,:]
	end
	return modules;
end

"""
Pull (checkout) the latest version of Mads modules

$(DocumentFunction.documentfunction(pull;
argtext=Dict("modulename"=>"module name"),
keytext=Dict("kw"=>"keyword arguments for calling function \"checkout\"")))
"""
function pull(modulename::String=""; kw...)
	checkout(modulename; kw...)
end

"""
Checkout (pull) the latest version of Mads modules

$(DocumentFunction.documentfunction(checkout;
argtext=Dict("modulename"=>"module name"),
keytext=Dict("git"=>"whether to use \"git checkout\" [default=`true`]",
            "master"=>"whether on master branch [default=`false`]",
            "force"=>"whether to overwrite local changes when checkout [default=`false`]",
            "pull"=>"whether to run \"git pull\" [default=`true`]",
            "required"=>"whether only checkout Mads.required modules [default=`false`]",
            "all"=>"whether to checkout all the modules [default=`false`]")))
"""
function checkout(modulename::String=""; git::Bool=true, master::Bool=false, force::Bool=false, pull::Bool=true, required::Bool=false, all::Bool=false)
	if modulename!=""
		modulenames = [modulename]
	else
		if required
			modulenames = Mads.required()[:,1]
		elseif all
			modulenames = keys(Pkg.installed())
		else
			modulenames = madsmodules
		end
	end
	if master==true || pull==true || force==true
		git = true
	end
	if force==true
		master = true
	end
	if !madsgit
		git = false
	end
	for i in modulenames
		if git
			@info("Checking out $(i) ...")
			cwd = pwd()
			d = joinpath(dirname(pathof(eval(Symbol(i)))), "..")
			if isdir(d)
				cd(d)
			else
				@warn("Package $i is not installed")
				return
			end
			if master
				if force
					run(`git checkout -f master`)
				else
					run(`git checkout master`)
				end
			end
			if pull
				run(`git pull`)
			end
			cd(cwd)
		else
			try
				Pkg.checkout(i)
			catch
				@warn("$i cannot be checked out; most probably it is dirty!")
			end
		end
	end
end

"""
Push the latest version of Mads modules in the default remote repository

$(DocumentFunction.documentfunction(push;
argtext=Dict("modulename"=>"module name")))
"""
function push(modulename::String="")
	if modulename!=""
		modulenames = [modulename]
	else
		modulenames = madsmodules
	end
	for i in modulenames
		@info("Pushing $(i) ...")
		cwd = pwd()
		d = joinpath(dirname(pathof(eval(Symbol(i)))), "..")
		if isdir(d)
			cd(d)
		else
			@warn("Package $i is not installed")
			return
		end
		try
			run(`git push`)
		catch errmsg
			printerrormsg(errmsg)
			@warn("$i cannot be pushed!")
		end
		cd(cwd)
	end
end

"""
Diff the latest version of Mads modules in the repository

$(DocumentFunction.documentfunction(diff;
argtext=Dict("modulename"=>"module name")))
"""
function diff(modulename::String="")
	if modulename!=""
		modulenames = [modulename]
	else
		modulenames = madsmodules
	end
	for i in modulenames
		cwd = pwd()
		d = joinpath(dirname(pathof(eval(Symbol(i)))), "..")
		if isdir(d)
			cd(d)
		else
			@warn("Package $i is not installed")
			return
		end
		try
			run(`git diff --word-diff "*.jl"`)
		catch errmsg
			printerrormsg(errmsg)
			@warn("$i cannot be diffed!")
		end
		cd(cwd)
	end
end

"""
Free Mads modules

$(DocumentFunction.documentfunction(free;
argtext=Dict("modulename"=>"module name"),
keytext=Dict("required"=>"only free Mads.required modules [default=`false`]",
            "all"=>"free all the modules [default=`false`]")))
"""
function free(modulename::String=""; required::Bool=false, all::Bool=false)
	if modulename!=""
		modulenames = [modulename]
	else
		if required
			modulenames = Mads.required()
		elseif all
			modulenames = keys(Pkg.installed())
		else
			modulenames = madsmodules
		end
	end
	for i in modulenames
		Pkg.free(i)
	end
end

"""
Commit the latest version of Mads modules in the repository

$(DocumentFunction.documentfunction(commit;
argtext=Dict("commitmsg"=>"commit message",
            "modulename"=>"module name")))
"""
function commit(commitmsg::String, modulename::String="")
	if modulename!=""
		modulenames = [modulename]
	else
		modulenames = madsmodules
	end
	for i in modulenames
		@info("Commiting changes in $(i) ...")
		cwd = pwd()
		d = joinpath(dirname(pathof(eval(Symbol(i)))), "..")
		if isdir(d)
			cd(d)
		else
			@warn("Package $i is not installed")
			return
		end
		try
			run(`git commit -a -m $(commitmsg)`)
		catch
			@warn("Nothing to commit in $(i).")
		end
		cd(cwd)
	end
end

function status(; git::Bool=true, gitmore::Bool=false)
	for i in madsmodules
		Mads.status(i, git=git, gitmore=gitmore)
	end
end
function status(madsmodule::String; git::Bool=madsgit, gitmore::Bool=false)
	if git
		cwd = pwd()
		@info("Git status $(madsmodule) ...")
		d = joinpath(dirname(pathof(Core.eval(Mads, Symbol(madsmodule)))), "..")
		if isdir(d)
			cd(d)
		else
			@warn("Package $(madsmodule) is not installed")
			return
		end
		cmdproc, cmdout, cmderr = Mads.runcmd(`git status -s`; quiet=true, pipe=true);
		cmdproc, cmdout, cmderr = Mads.runcmd("git log `git describe --tags --abbrev=0`..HEAD --oneline"; quiet=true, pipe=true);
		if cmdproc.exitcode != 0
			@warn("Module is not under development; execute `dev $(madsmodule)`")
		elseif gitmore
			@info("Git ID HEAD   $(madsmodule) ...")
			run(`git rev-parse --verify HEAD`)
			@info("Git ID master $(madsmodule) ...")
			run(`git rev-parse --verify master`)
		end
		cd(cwd)
	else
		tag_flag = false
		o = ""
		try
			stdoutcaptureon()
			Pkg.status(madsmodule)
			o = stdoutcaptureoff()
		catch
			o = stdoutcaptureoff()
			@warn("Module $(modulestr) is not available")
		end
		a = ascii(String(o))
		print(a)
		if occursin(r"(dirty)", a)
			@warn("$madsmodule latest changes are not committed!")
			tag_flag = false
		elseif occursin(r"[0-9]\+", a)
			@warn("$madsmodule latest changes are not tagged!")
			tag_flag = true
		elseif occursin(r"master", a)
			@info("$madsmodule latest changes are already tagged!")
			tag_flag = false
		end
		return tag_flag
	end
end
@doc """
Status of Mads modules

$(DocumentFunction.documentfunction(status;
argtext=Dict("madsmodule"=>"mads module"),
keytext=Dict("git"=>"use git [default=`true` or `Mads.madsgit`]",
            "gitmore"=>"use even more git [default=`false`]")))

Returns:

- `true` or `false`
""" status

function tag(versionsym::Symbol=:patch)
	for i in madsmodules
		Mads.tag(i, versionsym)
	end
end
function tag(madsmodule::String, versionsym::Symbol=:patch)
	tag_flag = Mads.status(madsmodule, git=false)
	if tag_flag
		if isdefined(Mads, :PkgDev)
			try
				PkgDev.tag(madsmodule, versionsym)
			catch errmsg
				printerrormsg(errmsg)
				@warn("$madsmodule cannot be tagged!")
				return
			end
		else
			@warn("PkgDev is missing!")
		end
		@info("$madsmodule is now tagged!")
	else
		@warn("$madsmodule cannot be tagged!")
	end
end

@doc """
Tag Mads modules with a default argument `:patch`

$(DocumentFunction.documentfunction(tag;
argtext=Dict("madsmodule"=>"mads module name",
            "versionsym"=>"version symbol [default=`:patch`]")))
""" tag

"""
Untag specific version

$(DocumentFunction.documentfunction(untag;
argtext=Dict("madsmodule"=>"mads module name",
            "version"=>"version")))
"""
function untag(madsmodule::String, version::String)
	cwd = pwd()
	@info("Git untag $(madsmodule) ...")
	d = joinpath(dirname(pathof(eval(Symbol(madsmodule)))), "..")
	if isdir(d)
		cd(d)
	else
		@warn("Package $madsmodule is not installed")
		return
	end
	try
		run(`git tag -d $version`)
		run(`git push origin :refs/tags/$version`)
	catch errmsg
		printerrormsg(errmsg)
		@warn("Untag of $madsmodule failed!")
	end
	cd(cwd)
end

"""
Create web documentation files for Mads functions

$(DocumentFunction.documentfunction(create_documentation))
"""
function create_documentation()
	for i in madsmodules
		Core.eval(Main, :(@Mads.tryimportmain $(Symbol(i))))
	end

	Documenter.makedocs(root=joinpath(dirname(pathof(Mads)), "..", "docs"), sitename="Mads documentation", format = DocumenterMarkdown.Markdown(), doctest=false, modules=madsmodulesdoc, clean=true)

	d = pwd()
	cd(Mads.madsdir)
	# run(`git pull gh gh-pages`)
	@info("mkdocs build & deploy ...")
	run(`mkdocs gh-deploy --clean`)
	@info("mkdocs done.")
	cd(d)
	return
end
