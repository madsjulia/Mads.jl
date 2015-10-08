if isdefined(:yaml) && isdefined(:YAML) # using PyCall/PyYAML and YAML
	@doc "Load YAML file" ->
	function loadyamlfile(filename::AbstractString; julia=false) # load YAML file
		yamldata = DataStructures.OrderedDict()
		f = open(filename)
		if julia
			yamldata = YAML.load(f) # works better; delimiters are well defined and "1e6" correctly interpreted as a number
		else
			yamldata = yaml.load(f) # WARNING do not use python yaml! delimiters are not working well; "1e6" interpreted as a string
		end
		close(f)
		return yamldata # this is not OrderedDict()
	end

	@doc "Dump YAML file" ->
	function dumpyamlfile(filename::AbstractString, yamldata) # dump YAML file
		f = open(filename, "w")
		write(f, yaml.dump(yamldata, width=255)) # for now we use the python library because the YAML julia library cannot dump
		close(f)
	end
elseif isdefined(:YAML) # using YAML in Julia
	@doc "Load YAML file" ->
	function loadyamlfile(filename::AbstractString; julia=true) # load YAML file
		yamldata = DataStructures.OrderedDict()
		f = open(filename)
		yamldata = YAML.load(f) # works; however Julia YAML cannot write
		close(f)
		return yamldata # this is not OrderedDict()
	end

	@doc "Dump YAML file in JSON format" ->
	function dumpyamlfile(filename::AbstractString, yamldata) # dump YAML file
		f = open(filename, "w")
		JSON.print(f, yamldata) # dump as a JSON file just in case
		close(f)
	end
else
	Mads.err("MADS needs YAML (and optionally PyYAML)!")
	throw("Missing modules!")
end

@doc "Load YAML MADS file" ->
function loadyamlmadsfile(filename::AbstractString; julia=false) # load MADS input file in YAML format
	madsdata = loadyamlfile(filename; julia=julia) # this is not OrderedDict()
	if haskey(madsdata, "Parameters")
		parameters = DataStructures.OrderedDict()
		for dict in madsdata["Parameters"]
			for key in keys(dict)
				if !haskey(dict[key], "exp") # it is a real parameter, not an expression
					parameters[key] = dict[key]
				else
					if !haskey(madsdata, "Expressions")
						madsdata["Expressions"] = DataStructures.OrderedDict()
					end
					madsdata["Expressions"][key] = dict[key]
				end
			end
		end
		madsdata["Parameters"] = parameters
	end
	if haskey(madsdata, "Sources")
		for i = 1:length(madsdata["Sources"])
			sourcetype = collect(keys(madsdata["Sources"][i]))[1]
			sourceparams = keys(madsdata["Sources"][i][sourcetype])
			for sourceparam in sourceparams
				madsdata["Parameters"][string("source", i, "_", sourceparam)] = madsdata["Sources"][i][sourcetype][sourceparam]
			end
		end
	end
	if haskey(madsdata, "Parameters")
		parameters = madsdata["Parameters"]
		for key in keys(parameters)
			if haskey(parameters[key], "log")
				flag = parameters[key]["log"]
				if flag == "yes" || flag == true
					parameters[key]["log"] = true
					for v in ["init", "init_max", "init_min", "max", "min", "step"]
						if haskey(parameters[key], v)
							parameters[key][v] = float(parameters[key][v])
							if parameters[key][v] < 0
								Mads.err("""The field $v for Parameter $key cannot be log-transformed; it is negative!""")
							end
						end
					end
				else
					parameters[key]["log"] = false
				end
			end
		end
	end
	if haskey(madsdata, "Wells")
		wells = DataStructures.OrderedDict()
		for dict in madsdata["Wells"]
			for key in keys(dict)
				wells[key] = dict[key]
				wells[key]["on"] = true
			end
		end
		madsdata["Wells"] = wells
		Mads.wells2observations!(madsdata)
	elseif haskey(madsdata, "Observations") # TODO drop zero weight observations
		observations = DataStructures.OrderedDict()
		for dict in madsdata["Observations"]
			for key in keys(dict)
				observations[key] = dict[key]
			end
		end
		madsdata["Observations"] = observations
	end
	if haskey(madsdata, "Templates")
		templates = Array(Dict, length(madsdata["Templates"]))
		i = 1
		for dict in madsdata["Templates"]
			for key in keys(dict) # this should only iterate once
				templates[i] = dict[key]
			end
			i += 1
		end
		madsdata["Templates"] = templates
	end
	if haskey(madsdata, "Instructions")
		instructions = Array(Dict, length(madsdata["Instructions"]))
		i = 1
		for dict in madsdata["Instructions"]
			for key in keys(dict) # this should only iterate once
				instructions[i] = dict[key]
			end
			i += 1
		end
		madsdata["Instructions"] = instructions
	end
	madsdata["Filename"] = filename
	return madsdata
end

@doc "Dump YAML MADS file" ->
function dumpyamlmadsfile(madsdata, filename::AbstractString) # load MADS input file in YAML forma
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
		if haskey(yamldata, obsorparam)
			yamldata[obsorparam] = Array(Any, length(madsdata[obsorparam]))
			i = 1
			for key in keys(madsdata[obsorparam])
				yamldata[obsorparam][i] = @Compat.compat Dict(key=>madsdata[obsorparam][key])
				i += 1
			end
		end
	end
	for tplorins in ["Templates", "Instructions"]
		if haskey(yamldata, tplorins)
			yamldata[tplorins] = Array(Any, length(madsdata[tplorins]))
			i = 1
			keys = map(string, 1:length(madsdata[tplorins]))
			for key in keys
				yamldata[tplorins][i] = @Compat.compat Dict(key=>madsdata[tplorins][i])
				i += 1
			end
		end
	end
	dumpyamlfile(filename, yamldata)
end

@doc "Read predictions from YAML MADS file" ->
function readyamlpredictions(filename::AbstractString) # read YAML predictions
	return loadyamlfile(filename)
end

@doc "Dump well concentrations" ->
function dumpwellconcentrations(filename::AbstractString, madsdata)
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
