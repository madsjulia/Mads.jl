import DocumentFunction
import Distributed

"""
Load ASCII file

$(DocumentFunction.documentfunction(loadasciifile;
argtext=Dict("filename"=>"ASCII file name")))

Returns:

- data from the file
"""
function loadasciifile(filename::AbstractString) # load ASCII text file
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
function dumpasciifile(filename::AbstractString, data::Any) # dump ASCII text file
	writedlm(filename, data)
end

"""
Read MADS predictions from an ASCII file

$(DocumentFunction.documentfunction(readasciipredictions;
argtext=Dict("filename"=>"ASCII file name")))

Returns:

- MADS predictions
"""
function readasciipredictions(filename::AbstractString) # read ASCII text predictions
	return loadasciifile(filename)
end
