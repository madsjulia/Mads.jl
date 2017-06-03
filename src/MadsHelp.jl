import Documenter
import DocumentFunction

"""
Produce MADS help information

$(DocumentFunction.documentfunction(help))
"""
function help()
	Markdown.parse_file(joinpath(Pkg.dir("Mads"), "GETTING_STARTED.md"))
end

"""
Produce MADS copyright information

$(DocumentFunction.documentfunction(copyright))
"""
function copyright()
	Markdown.parse_file(joinpath(Pkg.dir("Mads"), "COPYING.md"))
end

function functions(string::String=""; stdout::Bool=false)
	n = 0
	for i in madsmodules
		eval(Mads, :(@tryimport $(Symbol(i))))
		n += functions(Symbol(i), string; stdout=stdout)
	end
	n > 0 && info("Total number of functions: $n")
end
function functions(m::Union{Symbol, Module}, string::String=""; stdout::Bool=false)
	n = 0
	try
		f = names(eval(m), true)
		functions = Any[]
		for i in 1:length(f)
			functionname = "$(f[i])"
			if contains(functionname, "eval") || contains(functionname, "#") || contains(functionname, "__") || functionname == "$m"
				continue
			end
			if string == "" || contains(functionname, string)
				push!(functions, functionname)
			end
		end
		if length(functions) > 0
			info("$(m) functions:")
			sort!(functions)
			n = length(functions)
			if stdout
				Base.display(TextDisplay(STDOUT), functions)
			else
				Base.display(functions)
			end
		end
	catch
		warn("Module $m not defined!")
	end
	n > 0 && info("Number of functions in module $m: $n")
	return n
end

@doc """
List available functions in the MADS modules:

$(DocumentFunction.documentfunction(functions;
argtext=Dict("string"=>"string to display functions with matching names",
            "m"=>"MADS module")))

Examples:

```julia
Mads.functions()
Mads.functions(BIGUQ)
Mads.functions("get")
Mads.functions(Mads, "get")
```
""" functions

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
