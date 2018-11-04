import DocumentFunction
using Distributed

"""
Load ASCII file

$(DocumentFunction.documentfunction(loadasciifile;
argtext=Dict("filename"=>"ASCII file name")))

Returns:

- data from the file
"""
function loadasciifile(filename::String) # load ASCII text file
	data = open(readdlm, filename)
	return data
end

"""
Dump ASCII file

$(DocumentFunction.documentfunction(dumpasciifile;
argtext=Dict("filename"=>"ASCII file name",
            "data"=>"data to dump")))

Dumps:

- ASCII file with the name in "filename"
"""
function dumpasciifile(filename::String, data::Any) # dump ASCII text file
	writedlm(filename, data)
end

"""
Read MADS predictions from an ASCII file

$(DocumentFunction.documentfunction(readasciipredictions;
argtext=Dict("filename"=>"ASCII file name")))

Returns:

- MADS predictions
"""
function readasciipredictions(filename::String) # read ASCII text predictions
	return loadasciifile(filename)
end
