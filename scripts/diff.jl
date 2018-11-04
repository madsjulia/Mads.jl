import YAML

if length(ARGS) != 3
	println("Usage: madsjl.jl diff file1.mads file2.mads")
end

function printdiff(prefix, thing1::AbstractDict, thing2::AbstractDict, depth)
	if depth < 0
		return
	end
	allkeys = union(Set(keys(thing1)), Set(keys(thing2)))
	for key in allkeys
		if haskey(thing1, key) && !haskey(thing2, key)
			printstyled(string(prefix, key, ": ", thing1[key], "\n"); color=:red)
			printstyled(string(prefix, key, ":\n"); color=:green)
		elseif !haskey(thing1, key) && haskey(thing2, key)
			printstyled(string(prefix, key, ":\n"); color=:red)
			printstyled(string(prefix, key, ": ", thing2[key], "\n"); color=:green)
		elseif thing1[key] != thing2[key]
			if depth == 0
				printstyled(string(prefix, key, ": ", thing1[key], "\n"); color=:red)
				printstyled(string(prefix, key, ": ", thing2[key], "\n"); color=:green)
			else
				printdiff(string(prefix, key, "->"), thing1[key], thing2[key], depth - 1)
			end
		end
	end
end

function printdiff(prefix, thing1::Vector, thing2::Vector, depth)
	if depth < 0
		return
	end
	maxlength = max(length(thing1), length(thing2))
	for i = 1:maxlength
		if length(thing2) < i
			printstyled(string(prefix, i, ": ", thing1[i], "\n"); color=:red)
			printstyled(string(prefix, i, ":\n"); color=:green)
		elseif length(thing1) < i
			printstyled(string(prefix, i, ":\n"); color=:red)
			printstyled(string(prefix, i, ": ", thing2[i], "\n"); color=:green)
		elseif thing1[i] != thing2[i]
			if depth == 0
				printstyled(string(prefix, i, ": ", thing1[i], "\n"); color=:red)
				printstyled(string(prefix, i, ": ", thing2[i], "\n"); color=:green)
			else
				printdiff(string(prefix, i, "->"), thing1[i], thing2[i], depth - 1)
			end
		end
	end
end

function printdiff(prefix, thing1, thing2, depth)
	if depth < 0
		return
	end
	if thing1 != thing2
		printstyled(string(prefix, ": ", thing1, "\n"); color=:red)
		printstyled(string(prefix, ": ", thing2, "\n"); color=:green)
	end
end

f1 = YAML.load_file(ARGS[2])
f2 = YAML.load_file(ARGS[3])

printdiff("", f1, f2, 6)
