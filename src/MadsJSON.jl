import JSON
import OrderedCollections
import DocumentFunction

"""
Load a JSON file

$(DocumentFunction.documentfunction(loadjsonfile;
argtext=Dict("filename"=>"JSON file name")))

Returns:

- data from the JSON file
"""
function loadjsonfile(filename::AbstractString)
	data = JSON.parsefile(filename; dicttype=OrderedCollections.OrderedDict)
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
function dumpjsonfile(filename::AbstractString, data::Any)
	f = open(filename, "w")
	JSON.print(f, data, 1)
	close(f)
end
