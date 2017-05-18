import JSON
import DataStructures
import DocumentFunction

"""
Load a JSON file

$(DocumentFunction.documentfunction(loadjsonfile;
argtext=Dict("filename"=>"JSON file name")))

Returns:

- data from the JSON file
"""
function loadjsonfile(filename::String) # load JSON text file
	sz = filesize(filename)
	f = open(filename, "r")
	a = Mmap.mmap(f, Vector{UInt8}, sz)
	s = convert(String, a) # ASCIIString is needed; urgh
	data = JSON.parse(s; dicttype=DataStructures.OrderedDict)
	finalize(a)
	close(f)
	return data
end

"""
Dump a JSON file

$(DocumentFunction.documentfunction(dumpjsonfile;
argtext=Dict("filename"=>"JSON file name",
            "data"=>"data to dump")))

Dumps:

- JSON file with the name in "filename"
"""
function dumpjsonfile(filename::String, data::Any) # dump JSON text file
	f = open(filename, "w")
	JSON.print(f, data)
	close(f)
end

"""
Read MADS model predictions from a JSON file

$(DocumentFunction.documentfunction(readjsonpredictions;
argtext=Dict("filename"=>"JSON file name")))

Returns:

- MADS model predictions
"""
function readjsonpredictions(filename::String) # read JSON text predictions
	return loadjsonfile(filename)
end
