import YAML

if length(ARGS) != 3
	println("Usage: madsjl.jl diff file1.mads file2.mads")
end

function printdiff(prefix, thing1::Associative, thing2::Associative, depth)
	if depth < 0
		return
	end
	allkeys = union(Set(keys(thing1)), Set(keys(thing2)))
	for key in allkeys
		if haskey(thing1, key) && !haskey(thing2, key)
			print_with_color(:red, string(prefix, key, ": ", thing1[key], "\n"))
			print_with_color(:green, string(prefix, key, ":\n"))
		elseif !haskey(thing1, key) && haskey(thing2, key)
			print_with_color(:red, string(prefix, key, ":\n"))
			print_with_color(:green, string(prefix, key, ": ", thing2[key], "\n"))
		elseif thing1[key] != thing2[key]
			if depth == 0
				print_with_color(:red, string(prefix, key, ": ", thing1[key], "\n"))
				print_with_color(:green, string(prefix, key, ": ", thing2[key], "\n"))
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
			print_with_color(:red, string(prefix, i, ": ", thing1[i], "\n"))
			print_with_color(:green, string(prefix, i, ":\n"))
		elseif length(thing1) < i
			print_with_color(:red, string(prefix, i, ":\n"))
			print_with_color(:green, string(prefix, i, ": ", thing2[i], "\n"))
		elseif thing1[i] != thing2[i]
			if depth == 0
				print_with_color(:red, string(prefix, i, ": ", thing1[i], "\n"))
				print_with_color(:green, string(prefix, i, ": ", thing2[i], "\n"))
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
		print_with_color(:red, string(prefix, ": ", thing1, "\n"))
		print_with_color(:green, string(prefix, ": ", thing2, "\n"))
	end
end

f1 = YAML.load_file(ARGS[2])
f2 = YAML.load_file(ARGS[3])

printdiff("", f1, f2, 6)
