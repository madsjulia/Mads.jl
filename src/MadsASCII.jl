"Load ASCII file"
function loadasciifile(filename::String) # load ASCII text file
	data = open(readdlm, filename)
	return data
end

"Dump ASCII file"
function dumpasciifile(filename::String, data::Any) # dump ASCII text file
	writedlm(filename, data)
end

"Read MADS predictions from an ASCII file"
function readasciipredictions(filename::String) # read ASCII text predictions
	return loadasciifile(filename)
end
