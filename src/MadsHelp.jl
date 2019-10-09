import DocumentFunction
import Markdown

function welcome()
	c = Base.text_colors
	tx = c[:normal] # text
	bl = c[:bold] # bold
	d1 = c[:bold] * c[:blue]    # first dot
	d2 = c[:bold] * c[:red]     # second dot
	d3 = c[:bold] * c[:green]   # third dot
	d4 = c[:bold] * c[:magenta] # fourth dot
	println("$(bl)Mads: Model Analysis & Decision Support$(tx)")
	println("====")
	println("")
	println("$(d1)    ___      ____    $(d2)        ____   $(d3) ____         $(d4)     ______$(tx)")
	println("$(d1)   /   \\    /    \\  $(d2)        /    | $(d3) |    \\     $(d4)       /  __  \\$(tx)")
	println("$(d1)  |     \\  /     |   $(d2)      /     |  $(d3)|     \\     $(d4)     /  /  \\__\\$(tx)")
	println("$(d1)  |  |\\  \\/  /|  | $(d2)       /      | $(d3) |      \\   $(d4)     |  |$(tx)")
	println("$(d1)  |  | \\    / |  |  $(d2)     /  /|   | $(d3) |   |\\  \\   $(d4)     \\  \\______.$(tx)")
	println("$(d1)  |  |  \\__/  |  |  $(d2)    /  / |   | $(d3) |   | \\  \\  $(d4)      \\_______  \\$(tx)")
	println("$(d1)  |  |        |  | $(d2)    /  /  |   | $(d3) |   |  \\  \\  $(d4)             \\  \\$(tx)")
	println("$(d1)  |  |        |  |  $(d2)  /  /===|   | $(d3) |   |___\\  \\ $(d4)   __.        |  |$(tx)")
	println("$(d1)  |  |        |  | $(d2)  /  /    |   | $(d3) |           \\  $(d4) \\  \\______/  /$(tx)")
	println("$(d1)  |__|        |__| $(d2) /__/     |___| $(d3) |____________\\ $(d4)  \\__________/$(tx)")
	println("")
	println("$(bl)MADS$(tx) is an integrated high-performance computational framework for data- and model-based analyses.")
	println("$(bl)MADS$(tx) can perform: Sensitivity Analysis, Parameter Estimation, Model Inversion and Calibration, Uncertainty Quantification, Model Selection and Model Averaging, Model Reduction and Surrogate Modeling, Machine Learning, Decision Analysis and Support.")
end

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
