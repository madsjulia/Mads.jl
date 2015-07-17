module MadsASCII

if VERSION < v"0.4.0-dev"
	using Docile # default for v > 0.4
end

@doc "Load ASCII file" ->
function loadasciifile(filename::String) # load ASCII text file
	data = open(readdlm, filename)
	return data
end

@doc "Dump ASCII file" ->
function dumpasciifile(filename::String, data) # dump ASCII text file
	writedlm(filename, data)
end

@doc "Read MADS predictions from an ASCII file" ->
function readasciipredictions(filename::String) # read ASCII text predictions
	return loadasciifile(filename)
end

end # Module end
