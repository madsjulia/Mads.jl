import IJulia
import DocumentFunction

"""
Execute Jupyter notebook as a script

$(DocumentFunction.documentfunction(notebookscript;
keytext=Dict("dir"=>"notebook directory", "script"=>"execute as a script")))
"""
function notebookscript(a...; script::Bool=true, dir=Mads.dir, ndir="notebooks", k...)
	notebook(a...; k..., script=script, dir=dir, ndir=ndir)
end

"""
Execute Jupyter notebook in IJulia or as a script

$(DocumentFunction.documentfunction(notebook;
argtext=Dict("rootname"=>"notebook root name"),
keytext=Dict("dir"=>"notebook directory", "check"=>"check of notebook exists", "script"=>"execute as a script")))
"""
function notebook(rootname::AbstractString; script::Bool=false, dir=Mads.dir, ndir="notebooks", check::Bool=true)
	if check
		f = check_notebook(rootname; dir=dir, ndir=ndir)
		if f == nothing
			return
		end
		d, p = f
	else
		d = dir
		p = rootname
	end
	@info("Notebook: $(joinpath(d, p))")
	if script
		madsinfo("Executing notebook $p in directory $d")
		c = pwd()
		cd(d)
		r = splitext(p)[1]
		Mads.runcmd("jupyter-nbconvert --to script $(r).ipynb"; pipe=true, quiet=false)
		Base.include(Main, "$(r).jl")
		cd(c)
	else
		madsinfo("Opening notebook directory $d")
		IJulia.notebook(; dir=d, detached=true)
	end
end

"""
Execute Jupyter notebook in IJulia or as a script

$(DocumentFunction.documentfunction(notebooks;
keytext=Dict("dir"=>"notebook directory")))
"""
function notebooks(; dir=Mads.dir, ndir="notebooks")
	d = joinpath(dir, ndir)
	if isdir(d)
		notebook("."; check=false, dir=d, script=false)
	else
		madswarn("Directory $d is missing!")
	end
end

"""
Process Jupyter notebook to generate html, markdown, latex, and script versions

$(DocumentFunction.documentfunction(process_notebook;
argtext=Dict("rootname"=>"notebook root name"),
keytext=Dict("dir"=>"notebook directory")))
"""
function process_notebook(rootname::AbstractString; dir=Mads.dir, ndir="notebooks")
	f = check_notebook(rootname; dir=dir, ndir=ndir)
	if f == nothing
		return
	end
	d, p = f
	r = splitext(p)[1]
	c = pwd()
	cd(d)
	Mads.runcmd("python3 ~/system/notebook-clean.py $(r).ipynb")
	Mads.runcmd("rm -fR $(r)_files")
	Mads.runcmd("jupyter-nbconvert --to script $(r).ipynb")
	Mads.runcmd("jupyter-nbconvert --to html $(r).ipynb")
	Mads.runcmd("jupyter-nbconvert --to markdown $(r).ipynb")
	Mads.runcmd("jq -j '.cells | map( select(.cell_type != \"code\") | .source + [\"\n\n\"] ) | .[][]' $(r).ipynb > $(r).txt")
	Mads.runcmd("jupyter-nbconvert --to latex $(r).ipynb")
	Mads.runcmd("xelatex $(r) --quiet")
	Mads.runcmd("rm -f $(r).log $(r).aux $(r).out texput.log")
	cd(c)
end

"""
Check is Jupyter notebook exists

$(DocumentFunction.documentfunction(check_notebook;
argtext=Dict("rootname"=>"notebook root name"),
keytext=Dict("dir"=>"notebook directory")))
"""
function check_notebook(rootname::AbstractString; dir=Mads.dir, ndir="notebooks")
	if isfile("$rootname.ipynb")
		f = "$rootname.ipynb"
	elseif isfile(joinpath(dir, ndir, "$rootname.ipynb"))
		f = joinpath(dir, ndir, "$rootname.ipynb")
	elseif isfile(joinpath(dir, "notebooks", ndir, "$rootname.ipynb"))
		f = joinpath(dir, "notebooks", ndir, "$rootname.ipynb")
	elseif isfile(joinpath(dir, ndir, rootname, "$rootname.ipynb"))
		f = joinpath(dir, ndir, rootname, "$rootname.ipynb")
	elseif isfile(joinpath(dir, "$rootname.ipynb"))
		f = joinpath(dir, "$rootname.ipynb")
	else
		madswarn("Notebook with rootname $rootname is missing (searched directories: ., $dir, $(joinpath(dir, ndir)), $(joinpath(dir, ndir, rootname)), $(joinpath(dir, "notebooks", ndir))")
		return nothing
	end
	return splitdirdot(f)
end