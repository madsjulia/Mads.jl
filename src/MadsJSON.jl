if VERSION < v"0.4.0-dev"
	using Docile # default for v > 0.4
end

@doc "Load JSON file" ->
function loadjsonfile(filename::String) # load JSON text file
	data = JSON.parsefile(filename; ordered=true, use_mmap=true)
	return data
end

@doc "Dump JSON file" ->
function dumpjsonfile(filename::String, data) # dump JSON text file
	f = open(filename, "w")
	JSON.print(f, data)
	close(f)
end

@doc "Read MADS predictions from a JSON file" ->
function readjsonpredictions(filename::String) # read JSON text predictions
	return loadjsonfile(filename)
end
