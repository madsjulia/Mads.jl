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
		f = notebook_check(rootname; notebook_directory=notebook_directory)
		if isnothing(f)
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
Open Jupyter in the Mads notebook directory

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
Export Jupyter notebook in html, markdown, latex, and script versions

$(DocumentFunction.documentfunction(notebook_export;
	argtext=Dict("rootname"=>"notebook root name"),
	keytext=Dict("notebook_directory"=>"notebook directory")))
"""
function notebook_export(rootname::AbstractString; notebook_directory=joinpath(Mads.dir, "notebooks"))
	f = notebook_check(rootname; notebook_directory=notebook_directory)
	if isnothing(f)
		return
	end
	d, p = f
	r = first(splitext(p))
	@info("Processing $(f) in directory $(d) ...")
	c = pwd()
	cd(d)
	nb_clean = joinpath(ENV["HOMEPATH"], "system", "notebook-clean.py")
	if isfile(nb_clean)
		Mads.runcmd("python3 $(nb_clean) $(r).ipynb"; quiet=false, pipe=false)
		Mads.runcmd("rm -fR $(r)_files")
	end
	Mads.runcmd("python3 -m nbconvert --to script $(r).ipynb")
	@info("Julia script file created: $(r).jl")
	Mads.runcmd("python3 -m nbconvert --to html $(r).ipynb")
	@info("HTML file created: $(r).html")
	Mads.runcmd("python3 -m nbconvert --to markdown $(r).ipynb")
	@info("Markdown file created: $(r).md")
	# Mads.runcmd("jq -j '.cells | map( select(.cell_type != \"code\") | .source + [\"\n\n\"] ) | .[][]' $(r).ipynb > $(r).txt") # this does not work
	# @info("Text file created: $(r).txt")
	Mads.runcmd("python3 -m nbconvert --to latex $(r).ipynb")
	Mads.runcmd("xelatex $(r) --quiet")
	@info("LaTeX file created: $(r).tex")
	Mads.runcmd("rm $(r).log $(r).aux $(r).out texput.log")
	cd(c)
end

"""
Check is Jupyter notebook exists

$(DocumentFunction.documentfunction(notebook_check;
	argtext=Dict("rootname"=>"notebook root name"),
	keytext=Dict("notebook_directory"=>"notebook directory")))
"""
function notebook_check(rootname::AbstractString; notebook_directory=joinpath(Mads.dir, "notebooks"))
	if isfile("$(rootname).ipynb")
		f = "$(rootname).ipynb"
	elseif isfile(joinpath(notebook_directory, "$(rootname).ipynb"))
		f = joinpath(notebook_directory, "$(rootname).ipynb")
	elseif isfile(joinpath(Mads.dir, "notebooks", notebook_directory, "$(rootname).ipynb"))
		f = joinpath(Mads.dir, "notebooks", notebook_directory, "$(rootname).ipynb")
	elseif isfile(joinpath(Mads.dir, notebook_directory, rootname, "$(rootname).ipynb"))
		f = joinpath(Mads.dir, notebook_directory, rootname, "$(rootname).ipynb")
	elseif isfile(joinpath(Mads.dir, "$(rootname).ipynb"))
		f = joinpath(Mads.dir, "$(rootname).ipynb")
	else
		madswarn("Notebook with rootname $(rootname) is missing (searched directories: ., $(Mads.dir), $(joinpath(Mads.dir, notebook_directory)), $(joinpath(Mads.dir, notebook_directory, rootname)), $(joinpath(Mads.dir, "notebooks", notebook_directory))")
		return nothing
	end
	return splitdirdot(f)
end