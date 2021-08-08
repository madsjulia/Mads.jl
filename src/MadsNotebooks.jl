import IJulia

function notebook(problem::AbstractString; notebook::Bool=false, dir=Mads.dir)
	@info("Mads notebook: $problem")
	if notebook
		IJulia.notebook(; dir=joinpath(dir, "notebooks", problem), detached=true)
	else
		cd(joinpath(dir, "notebooks", problem))
		include("$(problem).jl")
	end
end

function notebooks(; dir=Mads.dir)
	notebook("."; dir=dir, notebook=true)
end

function process_notebook(problem::AbstractString; dir=Mads.dir)
	if isfile("$problem.ipynb")
		f = "$problem.ipynb"
	elseif isfile(joinpath(dir, "notebooks", "$problem.ipynb"))
		f = joinpath(dir, "notebooks", "$problem.ipynb")

	elseif isfile(joinpath(dir, "notebooks", problem, "$problem.ipynb"))
		f = joinpath(dir, "notebooks", problem, "$problem.ipynb")
	else
		madswarn("Notebook is missing: $problem")
		return nothing
	end
	c = pwd()
	d, p = splitdir(f)
	cd(d)
	Mads.runcmd("python3 ~/system/notebook-clean.py $p.ipynb")
	Mads.runcmd("rm -fR $(p)_files")
	Mads.runcmd("jupyter-nbconvert --to script $p.ipynb")
	Mads.runcmd("jupyter-nbconvert --to html $p.ipynb")
	Mads.runcmd("jupyter-nbconvert --to markdown $p.ipynb")
	Mads.runcmd("jq -j '.cells | map( select(.cell_type != \"code\") | .source + [\"\n\n\"] ) | .[][]' $p.ipynb > $p.txt")
	Mads.runcmd("jupyter-nbconvert --to latex $p.ipynb")
	Mads.runcmd("xelatex $p --quiet")
	Mads.runcmd("rm -f $p.log $p.aux $p.out texput.log")
	cd(c)
end