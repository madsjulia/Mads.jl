import Documenter

"Produce MADS help information"
function help()
	Markdown.parse_file(Pkg.dir("Mads") * "/GETTING_STARTED.md")
end

"Produce MADS copyright information"
function copyright()
	Markdown.parse_file(Pkg.dir("Mads") * "/COPYING.md")
end

"""
List available functions in the MADS modules:

Examples:

```
Mads.functions()
Mads.functions(BIGUQ)
Mads.functions("get")
Mads.functions(Mads, "get")
```

Arguments:

- `module` : MADS module
- `string` : matching string
"""
function functions(string::AbstractString="")
	functions(Mads, string)
	functions(BIGUQ, string)
	functions(Anasol, string)
	functions(ReusableFunctions, string)
	functions(MetaProgTools, string)
	functions(RobustPmap, string)
end

function functions(m::Module, string::AbstractString="")
	objects = m.__META__
	modulename = "$(m)"
	names = Any[]
	k = keys(objects)
	c = collect(k)
	for i in 1:length(c)
		functionname = "$(c[i])"
		if functionname == modulename || contains(functionname, "ObjectIdDict")
			continue
		end
		if string == "" || contains(functionname, string)
			push!(names, functionname)
		end
	end
	if length(names) > 0
		info("$(m) functions:")
		sort!(names)
		Base.display(names)
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

#=
#TODO IMPORTANT

MADS function documentation should include the following sections:
"""
Description:

Usage:

Arguments:

Returns:

Dumps:

Examples:

Details:

References:

See Also:
"""
=#
