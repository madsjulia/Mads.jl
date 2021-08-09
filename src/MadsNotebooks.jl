import IJulia

function notebookscript(a...; script::Bool=true, dir=Mads.dir, k...)
	notebook(a...; k..., script=script, dir=dir)
end

function notebook(problem::AbstractString; script::Bool=script, dir=Mads.dir, check::Bool=true)
	if check
		f = check_notebook(problem; dir=dir)
		if f == nothing
			return
		end
		d, p = f
	else
		d = dir
		p = problem
	end
	@info("Notebook: $(joinpath(d, p))")
	if script
		madsinfo("Executing notebook $p in directory $d")
		c = pwd()
		cd(d)
		Mads.runcmd("jupyter-nbconvert --to script $p.ipynb")
		Base.include(Main, "$(splitext(p)[1]).jl")
		cd(c)
	else
		madsinfo("Openning notebook directory $d")
		IJulia.notebook(; dir=d, detached=true)
	end
end

function notebooks(; dir=Mads.dir)
	d = joinpath(dir, "notebooks")
	if isdir(d)
		notebook("."; check=false, dir=d, script=false)
	else
		madswarn("Directory $d is missing!")
	end
end

function process_notebook(problem::AbstractString; dir=Mads.dir)
	f = check_notebook(problem; dir=dir)
	if f == nothing
		return
	end
	c = pwd()
	d, p = f
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

function check_notebook(problem::AbstractString; dir=Mads.dir)
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
	return splitdirdot(f)
end