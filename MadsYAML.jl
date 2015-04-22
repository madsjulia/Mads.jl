module MadsYAML
export loadyamlmadsfile, dumpyamlmadsfile

# import YAML
using PyCall
@pyimport yaml
using DataStructures

function loadyamlfile(filename::String) # load YAML file
	yamldata = OrderedDict()
	f = open(filename)
	# yamldata = YAML.load(f) # works; however Julia YAML cannot write
	yamldata = yaml.load(f) # for now we use the python library because the YAML julia library cannot dump
	close(f)
	return yamldata
end

function dumpyamlfile(filename::String, yamldata) # dump YAML file
	f = open(filename, "w")
	# write(f, YAML.dump(yamldata)) # crashes
	write(f, yaml.dump(yamldata, width=255)) # for now we use the python library because the YAML julia library cannot dump
	close(f)
end

function loadyamlmadsfile(filename::String) # load MADS input file in YAML format
	madsdict = loadyamlfile(filename)
	parameters = OrderedDict()
	for paramdict in madsdict["Parameters"]
		for key in keys(paramdict)
			parameters[key] = paramdict[key]
		end
	end
	madsdict["Parameters"] = parameters
	observations = OrderedDict()
	for obsdict in madsdict["Observations"]
		for key in keys(obsdict)
			observations[key] = obsdict[key]
		end
	end
	madsdict["Observations"] = observations
	if haskey(madsdict, "Templates")
		templates = Array(Dict, length(madsdict["Templates"]))
		i = 1
		for tmpdict in madsdict["Templates"]
			for key in keys(tmpdict) # this should only iterate once
				templates[i] = tmpdict[key]
			end
			i += 1
		end
		madsdict["Templates"] = templates
	end
	if haskey(madsdict, "Instructions")
		instructions = Array(Dict, length(madsdict["Instructions"]))
		i = 1
		for insdict in madsdict["Instructions"]
			for key in keys(insdict) # this should only iterate once
				instructions[i] = insdict[key]
			end
			i += 1
		end
		madsdict["Instructions"] = instructions
	end
	madsdict["Filename"] = filename
	return madsdict
end

function dumpyamlmadsfile(filename::String, madsdata) # load MADS input file in YAML forma
	#TODO we need to restore the "stupid" YAML structure of MADS file
	#TODO we can also forget about it
	#TODO it was originally impletemented to perform miltple independent runs with different parameter definitions for
	# each parameter/observations but we never got there and most probably we will never will
	#TODO we need to keep the order and not sort alphabetically parameters and observations
	yamldata = copy(madsdata)
	for obsorparam in ["Observations", "Parameters"]
		yamldata[obsorparam] = Array(Any, length(madsdata[obsorparam]))
		i = 1
		for key in keys(madsdata[obsorparam])
			yamldata[obsorparam][i] = {key=>madsdata[obsorparam][key]}
			i += 1
		end
	end
	dumpyamlfile(filename, yamldata)
end

function readyamlpredictions(filename::String) # read YAML predictions
	return loadyamlfile(filename)
end

end # Module end
