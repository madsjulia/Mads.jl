export loadyamlmadsfile, dumpyamlmadsfile

# import YAML
using PyCall
using DataStructures
@pyimport yaml
using DataStructures
if VERSION < v"0.4.0-dev"
	using Docile # default for v > 0.4
end

@doc "Load YAML file" ->
function loadyamlfile(filename::String) # load YAML file
	yamldata = DataStructures.OrderedDict()
	f = open(filename)
	# yamldata = YAML.load(f) # works; however Julia YAML cannot write
	yamldata = yaml.load(f) # for now we use the python library because the YAML julia library cannot dump
	close(f)
	return yamldata
end

@doc "Dump YAML file" ->
function dumpyamlfile(filename::String, yamldata) # dump YAML file
	f = open(filename, "w")
	# write(f, yaml.dump(yamldata)) # crashes
	write(f, yaml.dump(yamldata, width=255)) # for now we use the python library because the YAML julia library cannot dump
	close(f)
end

@doc "Load YAML MADS file" ->
function loadyamlmadsfile(filename::String) # load MADS input file in YAML format
	madsdict = loadyamlfile(filename)
	if haskey(madsdict, "Parameters")
		parameters = DataStructures.OrderedDict()
		for dict in madsdict["Parameters"]
			for key in keys(dict)
				if !haskey(dict[key], "exp") # it is a real parameter, not an expression
					parameters[key] = dict[key]
				else
					if !haskey(madsdict, "Expressions")
						madsdict["Expressions"] = DataStructures.OrderedDict()
					end
					madsdict["Expressions"][key] = dict[key]
				end
			end
		end
		madsdict["Parameters"] = parameters
	end
	if haskey(madsdict, "Sources")
		for i = 1:length(madsdict["Sources"])
			sourcetype = collect(keys(madsdict["Sources"][i]))[1]
			sourceparams = keys(madsdict["Sources"][i][sourcetype])
			for sourceparam in sourceparams
				madsdict["Parameters"][string("source", i, "_", sourceparam)] = madsdict["Sources"][i][sourcetype][sourceparam]
			end
		end
	end
	if haskey(madsdict, "Wells")
		wells = DataStructures.OrderedDict()
		for dict in madsdict["Wells"]
			for key in keys(dict)
				wells[key] = dict[key]
			end
		end
		madsdict["Wells"] = wells
		observations = DataStructures.OrderedDict()
		for wellkey in collect(keys(madsdict["Wells"]))
			for i in 1:length(madsdict["Wells"][wellkey]["obs"])
				t = madsdict["Wells"][wellkey]["obs"][i][i]["t"]
				obskey = wellkey * "_" * string(t)
				data = DataStructures.OrderedDict()
				data["target"] = madsdict["Wells"][wellkey]["obs"][i][i]["c"]
				for datakey in keys(madsdict["Wells"][wellkey]["obs"][i][i])
					if datakey != "c" && datakey != "t"
						data[datakey] = madsdict["Wells"][wellkey]["obs"][i][i][datakey]
					end
				end
				observations[obskey] = data
			end
		end
		madsdict["Observations"] = observations
	elseif haskey(madsdict, "Observations")
		observations = DataStructures.OrderedDict()
		for dict in madsdict["Observations"]
			for key in keys(dict)
				observations[key] = dict[key]
			end
		end
		madsdict["Observations"] = observations
	end
	if haskey(madsdict, "Templates")
		templates = Array(Dict, length(madsdict["Templates"]))
		i = 1
		for dict in madsdict["Templates"]
			for key in keys(dict) # this should only iterate once
				templates[i] = dict[key]
			end
			i += 1
		end
		madsdict["Templates"] = templates
	end
	if haskey(madsdict, "Instructions")
		instructions = Array(Dict, length(madsdict["Instructions"]))
		i = 1
		for dict in madsdict["Instructions"]
			for key in keys(dict) # this should only iterate once
				instructions[i] = dict[key]
			end
			i += 1
		end
		madsdict["Instructions"] = instructions
	end
	madsdict["Filename"] = filename
	madsdatadict = madsdict
	return madsdict
end

@doc "Dump YAML MADS file" ->
function dumpyamlmadsfile(filename::String, madsdata) # load MADS input file in YAML forma
	yamldata = copy(madsdata)
	deletekeys = ["Dynamic model", "Filename"]
	restore = Array(Bool, length(deletekeys))
	restorevals = Array(Any, length(deletekeys))
	i = 1
	for deletekey in deletekeys
		if haskey(yamldata, deletekey)
			restore[i] = true
			restorevals[i] = yamldata[deletekey]
			delete!(yamldata, deletekey)
		end
		i += 1
	end
	for obsorparam in ["Observations", "Parameters"]
		yamldata[obsorparam] = Array(Any, length(madsdata[obsorparam]))
		i = 1
		for key in keys(madsdata[obsorparam])
			yamldata[obsorparam][i] = {key=>madsdata[obsorparam][key]}
			i += 1
		end
	end
	for tplorins in ["Templates", "Instructions"]
		yamldata[tplorins] = Array(Any, length(madsdata[tplorins]))
		i = 1
		keys = map(string, 1:length(madsdata[tplorins]))
		for key in keys
			yamldata[tplorins][i] = {key=>madsdata[tplorins][i]}
			i += 1
		end
	end
	dumpyamlfile(filename, yamldata)
end

@doc "Read predictions from YAML MADS file" ->
function readyamlpredictions(filename::String) # read YAML predictions
	return loadyamlfile(filename)
end

@doc "Dump well concentrations" ->
function dumpwellconcentrations(filename::String, madsdata)
	outfile = open(filename, "w")
	write(outfile, "well_name, x_coord [m], x_coord [m], z_coord [m], time [years], concentration [ppb]\n")
	for n in keys(madsdata["Wells"])
		x = madsdata["Wells"]["$n"]["x"]
		y = madsdata["Wells"]["$n"]["y"]
		z0 = madsdata["Wells"]["$n"]["z0"]
		z1 = madsdata["Wells"]["$n"]["z1"]
		o = madsdata["Wells"]["$n"]["obs"]
		for i in 1:length(o)
			c = o[i][i]["c"]
			t = o[i][i]["t"]
			write(outfile, "$n, $x, $y, $z0, $t, $c\n")
		end
	end
	close(outfile)
end
