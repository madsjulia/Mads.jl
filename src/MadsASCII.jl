"""
Load ASCII file

$(DocumentFunction.documentfunction(loadasciifile))
"""
function loadasciifile(filename::String) # load ASCII text file
	data = open(readdlm, filename)
	return data
end

"""
Dump ASCII file

$(DocumentFunction.documentfunction(dumpasciifile))
"""
function dumpasciifile(filename::String, data::Any) # dump ASCII text file
	writedlm(filename, data)
end

"""
Read MADS predictions from an ASCII file

$(DocumentFunction.documentfunction(readasciipredictions))
"""
function readasciipredictions(filename::String) # read ASCII text predictions
	return loadasciifile(filename)
end
