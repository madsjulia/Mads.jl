import DocumentFunction
import Markdown

"""
Produce MADS help information

$(DocumentFunction.documentfunction(help))
"""
function help()
	Markdown.parse_file(joinpath(Mads.madsdir, "GETTING_STARTED.md"))
end

"""
Produce MADS copyright information

$(DocumentFunction.documentfunction(copyright))
"""
function copyright()
	Markdown.parse_file(joinpath(Mads.madsdir, "COPYING.md"))
end

function functions(re::Regex; shortoutput::Bool=false, quiet::Bool=false)
	n = 0
	for i in madsmodules
		Core.eval(Mads, :(@tryimport $(Symbol(i))))
		n += functions(Symbol(i), re; shortoutput=shortoutput, quiet=quiet)
	end
	n > 0 && string == "" && @info("Total number of functions: $n")
	return
end
function functions(string::String=""; shortoutput::Bool=false, quiet::Bool=false)
	n = 0
	for i in madsmodules
		Core.eval(Mads, :(@tryimport $(Symbol(i))))
		n += functions(Symbol(i), string; shortoutput=shortoutput, quiet=quiet)
	end
	n > 0 && string == "" && @info("Total number of functions: $n")
	return
end
function functions(m::Union{Symbol, Module}, re::Regex; shortoutput::Bool=false, quiet::Bool=false)
	n = 0
	try
		f = names(Core.eval(Mads, m); all=true)
		functions = Array{String}(undef, 0)
		for i in 1:length(f)
			functionname = "$(f[i])"
			if occursin("eval", functionname) || occursin("#", functionname) || occursin("__", functionname) || functionname == "$m"
				continue
			end
			if occursin(re, functionname)
				push!(functions, functionname)
			end
		end
		if length(functions) > 0
			!quiet && @info("$(m) functions matching the search criteria:")
			sort!(functions)
			n = length(functions)
			if shortoutput
				!quiet && Base.display(TextDisplay(stdout), functions)
			else
				!quiet && Base.display(functions)
			end
		end
	catch
		Mads.madswarn("Module $m not defined!")
	end
	n > 0 && string == "" && @info("Number of functions in module $m: $n")
	return n
end
function functions(m::Union{Symbol, Module}, string::String=""; shortoutput::Bool=false, quiet::Bool=false)
	n = 0
	if string != ""
		quiet = false
		suffix = " matching the search criteria"
	end
	try
		f = names(Core.eval(Mads, m); all=true)
		functions = Array{String}(undef, 0)
		for i in 1:length(f)
			functionname = "$(f[i])"
			if occursin("eval", functionname) || occursin("#", functionname) || occursin("__", functionname) || functionname == "$m"
				continue
			end
			if string == "" || occursin(string, functionname)
				push!(functions, functionname)
			end
		end
		if length(functions) > 0
			!quiet && @info("$(m) functions$suffix:")
			sort!(functions)
			n = length(functions)
			if shortoutput
				!quiet && Base.display(TextDisplay(stdout), functions)
			else
				!quiet && (Base.display(functions); println())
			end
		end
	catch
		Mads.madswarn("Module $m not defined!")
	end
	n > 0 && string == "" && @info("Number of functions in module $m: $n")
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
