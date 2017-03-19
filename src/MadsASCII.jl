"""
Load ASCII file

$(documentfunction(loadasciifile))
"""
function loadasciifile(filename::String) # load ASCII text file
	data = open(readdlm, filename)
	return data
end

"""
Dump ASCII file

$(documentfunction(dumpasciifile))
"""
function dumpasciifile(filename::String, data::Any) # dump ASCII text file
	writedlm(filename, data)
end

"""
Read MADS predictions from an ASCII file

$(documentfunction(readasciipredictions))
"""
function readasciipredictions(filename::String) # read ASCII text predictions
	return loadasciifile(filename)
end
