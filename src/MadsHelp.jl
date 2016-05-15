import Lexicon

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
		display(names)
	end
end

"Create web documentation files for Mads functions"
function create_documentation()
	Lexicon.save(Mads.madsdir * "/../docs/mads.md", Mads; md_permalink = false)
	Lexicon.save(Mads.madsdir * "/../docs/mads.html", Mads)
	Lexicon.save(Mads.madsdir * "/../docs/Modules/Mads.md", Mads; mdstyle_objname="##", md_permalink = false, md_subheader=:category)
	Lexicon.save(Mads.madsdir * "/../docs/Modules/BIGUQ.md", BIGUQ; mdstyle_objname="##", md_permalink = false, md_subheader=:category)
	Lexicon.save(Mads.madsdir * "/../docs/Modules/Anasol.md", Anasol; mdstyle_objname="##", md_permalink = false, md_subheader=:category)
	Lexicon.save(Mads.madsdir * "/../docs/Modules/ReusableFunctions.md", ReusableFunctions; mdstyle_objname="##", md_permalink = false, md_subheader=:category)
	Lexicon.save(Mads.madsdir * "/../docs/Modules/MetaProgTools.md", MetaProgTools; mdstyle_objname="##", md_permalink = false, md_subheader=:category)
	Lexicon.save(Mads.madsdir * "/../docs/Modules/RobustPmap.md", RobustPmap; mdstyle_objname="##", md_permalink = false, md_subheader=:category)

	# index = Lexicon.save(Mads.madsdir * "/../docs/mads.md", Mads)
	# Lexicon.save(Mads.madsdir * "/../docs/index.md", Lexicon.Index([index]); md_subheader = :category)

	d = pwd()
	cd(Mads.madsdir * "/..")
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
