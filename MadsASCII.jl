module MadsASCII

function loadasciifile(filename::String) # load ASCII text file
  data = open(readdlm, filename)
	return data
end

function dumpasciifile(filename::String, data) # dump ASCII text file
  writedlm(filename, data)
end

function readasciipredictions(filename::String) # read ASCII text predictions
	return loadasciifile(filename)
end

end # Module end
