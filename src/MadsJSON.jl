import JSON
import OrderedCollections
import DocumentFunction
import Mmap

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
	s = String(a) # ASCIIString is needed; urgh
	data = JSON.parse(s; dicttype=OrderedCollections.OrderedDict)
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
	JSON.print(f, data, 1)
	close(f)
end
