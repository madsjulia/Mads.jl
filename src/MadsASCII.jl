import DocumentFunction
import Distributed
import DelimitedFiles

"""
Load ASCII file

$(DocumentFunction.documentfunction(loadasciifile;
argtext=Dict("filename"=>"ASCII file name")))

Returns:

- data from the file
"""
function loadasciifile(filename::AbstractString)
	return DelimitedFiles.readdlm(filename)
end

"""
Dump ASCII file

$(DocumentFunction.documentfunction(dumpasciifile;
argtext=Dict("filename"=>"ASCII file name",
            "data"=>"data to dump")))

Dumps:

- ASCII file with the name in "filename"
"""
function dumpasciifile(filename::AbstractString, data::Any)
	DelimitedFiles.writedlm(filename, data)
end

"""
Read MADS predictions from an ASCII file

$(DocumentFunction.documentfunction(readasciipredictions;
argtext=Dict("filename"=>"ASCII file name")))

Returns:

- MADS predictions
"""
function readasciipredictions(filename::AbstractString)
	return loadasciifile(filename)
end
