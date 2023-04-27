"""
List available examples

$(DocumentFunction.documentfunction(examples))
"""
function examples()
	list_examples = readdir(joinpath(Mads.dir, "examples"))
	return list_examples[isdir.(joinpath.(Mads.dir, "examples", list_examples))]
end

"""
List available examples

$(DocumentFunction.documentfunction(examples))
"""
function example(e::AbstractString)
	file = joinpath(Mads.dir, "examples", e, "$(e).jl")
	if isfile(file)
		printstyled("Executing example $(e) ...\n"; color=:cyan)
		@elapsed include(file)
	else
		file = joinpath(Mads.dir, "examples", e, "runtests.jl")
		if isfile(file)
			printstyled("Executing example $(e) ...\n"; color=:cyan)
			@elapsed include(file)
		else
			@warn("Example $(e) does not exist!")
		end
	end
end

