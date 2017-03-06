import Documenter

"Produce MADS help information"
function help()
	Markdown.parse_file(joinpath(Pkg.dir("Mads"), "GETTING_STARTED.md"))
end

"Produce MADS copyright information"
function copyright()
	Markdown.parse_file(joinpath(Pkg.dir("Mads"), "COPYING.md"))
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
	for i in madsmodules
		eval(Mads, :(@tryimport $(Symbol(i))))
		functions(Symbol(i), string)
	end
end

function functions(m::Union{Symbol, Module}, string::String="")
	try
		f = names(eval(m), true)
		functions = Any[]
		for i in 1:length(f)
			functionname = "$(f[i])"
			if contains(functionname, "eval") || contains(functionname, "#") || contains(functionname, "_")
				continue
			end
			if string == "" || contains(functionname, string)
				push!(functions, functionname)
			end
		end
		if length(functions) > 0
			info("$(m) functions:")
			sort!(functions)
			Base.display(functions)
		end
	catch
		warn("Module $m not defined!")
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
