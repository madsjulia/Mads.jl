import IJulia

"""
Execute Jupyter notebook as a script

$(DocumentFunction.documentfunction(notebookscript;
	keytext=Dict("notebook_directory"=>"notebook directory", "script"=>"execute as a script")))
"""
function notebookscript(a...; script::Bool=true, notebook_directory=joinpath(Mads.dir, "notebooks"), k...)
	notebook(a...; k..., script=script, notebook_directory=notebook_directory)
end

"""
Execute Jupyter notebook in IJulia or as a script

$(DocumentFunction.documentfunction(notebook;
	argtext=Dict("rootname"=>"notebook root name"),
	keytext=Dict("notebook_directory"=>"notebook directory", "check"=>"check of notebook exists", "script"=>"execute as a script")))
"""
function notebook(rootname::AbstractString; script::Bool=false, notebook_directory=joinpath(Mads.dir, "notebooks"), check::Bool=true)
	if check
		f = check_notebook(rootname; notebook_directory=notebook_directory)
		if f === nothing
			return
		end
		d, p = f
	else
		d = notebook_directory
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
		IJulia.notebook(; dir=notebook_directory, detached=true)
	end
end

"""
Execute Jupyter notebook in IJulia or as a script

$(DocumentFunction.documentfunction(notebooks;
	keytext=Dict("notebook_directory"=>"notebook directory")))
"""
function notebooks(; notebook_directory=joinpath(Mads.dir, "notebooks"))
	if isdir(notebook_directory)
		notebook("."; check=false, notebook_directory=notebook_directory, script=false)
	else
		madswarn("Directory $(notebook_directory) is missing!")
	end
end

"""
Process Jupyter notebook to generate html, markdown, latex, and script versions

$(DocumentFunction.documentfunction(process_notebook;
	argtext=Dict("rootname"=>"notebook root name"),
	keytext=Dict("notebook_directory"=>"notebook directory")))
"""
function process_notebook(rootname::AbstractString; notebook_directory=joinpath(Mads.dir, "notebooks"))
	f = check_notebook(rootname; notebook_directory=notebook_directory)
	if f === nothing
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
	keytext=Dict("notebook_directory"=>"notebook directory")))
"""
function check_notebook(rootname::AbstractString; notebook_directory=joinpath(Mads.dir, "notebooks"))
	if isfile("$rootname.ipynb")
		f = "$rootname.ipynb"
	elseif isfile(joinpath(notebook_directory, "$rootname.ipynb"))
		f = joinpath(notebook_directory, "$rootname.ipynb")
	elseif isfile(joinpath(Mads.dir, "notebooks", notebook_directory, "$rootname.ipynb"))
		f = joinpath(Mads.dir, "notebooks", notebook_directory, "$rootname.ipynb")
	elseif isfile(joinpath(Mads.dir, notebook_directory, rootname, "$rootname.ipynb"))
		f = joinpath(Mads.dir, notebook_directory, rootname, "$rootname.ipynb")
	elseif isfile(joinpath(Mads.dir, "$rootname.ipynb"))
		f = joinpath(Mads.dir, "$rootname.ipynb")
	else
		madswarn("Notebook with rootname $rootname is missing (searched directories: ., $(Mads.dir), $(joinpath(Mads.dir, notebook_directory)), $(joinpath(Mads.dir, notebook_directory, rootname)), $(joinpath(Mads.dir, "notebooks", notebook_directory))")
		return nothing
	end
	return splitdirdot(f)
end