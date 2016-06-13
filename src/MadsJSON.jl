import JSON
import DataStructures

"Load a JSON file"
function loadjsonfile(filename::AbstractString) # load JSON text file
	sz = filesize(filename)
	f = open(filename, "r")
	a = Mmap.mmap(f, Vector{UInt8}, sz)
	s = UTF8String(a)
	data = JSON.parse(s; dicttype=DataStructures.OrderedDict)
	finalize(a)
	close(f)
	return data
end

"Dump a JSON file"
function dumpjsonfile(filename::AbstractString, data) # dump JSON text file
	f = open(filename, "w")
	JSON.print(f, data)
	close(f)
end

"Read MADS model predictions from a JSON file"
function readjsonpredictions(filename::AbstractString) # read JSON text predictions
	return loadjsonfile(filename)
end
