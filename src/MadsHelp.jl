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
function functions(string::String="")
	functions(Mads, string)
	functions(BIGUQ, string)
	functions(Anasol, string)
	functions(ReusableFunctions, string)
	functions(MetaProgTools, string)
	functions(RobustPmap, string)
end

function functions(m::Module, string::String="")
	f = names(m, true)
	fuctions = Any[]
	for i in 1:length(f)
		functionname = "$(f[i])"
		if contains(functionname, "eval") || contains(functionname, "#") || contains(functionname, "_")
			continue
		end
		if string == "" || contains(functionname, string)
			push!(fuctions, functionname)
		end
	end
	if length(fuctions) > 0
		info("$(m) functions:")
		sort!(fuctions)
		Base.display(fuctions)
	end
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
