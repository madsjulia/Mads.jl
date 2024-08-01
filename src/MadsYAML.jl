import JSON
import YAML
import OrderedCollections

"""
Load YAML file

$(DocumentFunction.documentfunction(loadyamlfile;
argtext=Dict("filename"=>"file name"),
keytext=Dict("julia"=>"if `true`, use `julia` YAML library (if available); if `false` (default), use `python` YAML library (if available)")))

Returns:

- data in the yaml input file
"""
function loadyamlfile(filename::AbstractString)
	yamldata = YAML.load_file(filename)
	return yamldata
end

"""
Dump YAML file

$(DocumentFunction.documentfunction(dumpyamlfile;
argtext=Dict("filename"=>"output file name",
            "data"=>"YAML data"),
keytext=Dict("julia"=>"if `true`, use `julia` YAML library (if available); if `false` (default), use `python` YAML library (if available)")))
"""
function dumpyamlfile(filename::AbstractString, data::Any) # dump YAML file
	YAML.write_file(filename, data)
end

"""
Dump YAML Mads file

$(DocumentFunction.documentfunction(dumpyamlmadsfile;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "filename"=>"output file name"),
keytext=Dict("julia"=>"use julia YAML [default=`false`]")))
"""
function dumpyamlmadsfile(madsdata::AbstractDict, filename::AbstractString) # load MADS input file in YAML forma
	yamldata = deepcopy(madsdata)
	deletekeys = ["Julia model", "Filename"]
	restore = Array{Bool}(undef, length(deletekeys))
	restorevals = Array{Any}(undef, length(deletekeys))
	i = 1
	for deletekey in deletekeys
		if haskey(yamldata, deletekey)
			restore[i] = true #TODO is this needed?
			restorevals[i] = yamldata[deletekey]
			delete!(yamldata, deletekey)
		end
		i += 1
	end
	if haskey(yamldata, "Wells")
		if haskey(yamldata, "Observations")
			delete!(yamldata, "Observations")
		end
		for well in keys(yamldata["Wells"])
			delete!(yamldata["Wells"][well], "on" )
			for i = eachindex(yamldata["Wells"][well]["obs"])
				dict = OrderedCollections.OrderedDict(i=>yamldata["Wells"][well]["obs"][i])
				yamldata["Wells"][well]["obs"][i] = dict
			end
		end
	end
	for obsorparam in ["Observations", "Parameters", "Wells"]
		if haskey(yamldata, obsorparam)
			a = Array{Any}(undef, 0)
			for key in keys(yamldata[obsorparam])
				if !occursin(r"source[1-9]*_", key)
					push!(a, OrderedCollections.OrderedDict(key=>yamldata[obsorparam][key]))
				end
			end
			yamldata[obsorparam] = a
		end
	end
	for tplorins in ["Templates", "Instructions"]
		if haskey(yamldata, tplorins)
			a = Array{Any}(undef, length(yamldata[tplorins]))
			i = 1
			keys = map(string, eachindex(yamldata[tplorins]))
			for key in keys
				a[i] = OrderedCollections.OrderedDict(key=>yamldata[tplorins][i])
				i += 1
			end
			yamldata[tplorins] = a
		end
	end
	dumpyamlfile(filename, yamldata)
end

"""
Read MADS model predictions from a YAML file `filename`

$(DocumentFunction.documentfunction(readyamlpredictions;
argtext=Dict("filename"=>"file name"),
keytext=Dict("julia"=>"if `true`, use `julia` YAML library (if available); if `false` (default), use `python` YAML library (if available)")))

Returns:

- data in yaml input file
"""
function readyamlpredictions(filename::AbstractString)
	return loadyamlfile(filename)
end
