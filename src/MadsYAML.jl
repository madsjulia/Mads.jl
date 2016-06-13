import JSON
import YAML

if isdefined(:yaml) && isdefined(:YAML) # using PyCall/PyYAML and YAML
	"""
	Load YAML file

	Arguments:

	- `filename` : file name
	- `julia=false` : use Python YAML library (if available)
	- `julia=true` : use Julia YAML library (if available)
	"""
	function loadyamlfile(filename::AbstractString; julia::Bool=false) # load YAML file
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

	"""
	Dump YAML file

	Arguments:

	- `filename` : file name
	- `yamldata` : YAML data
	"""
	function dumpyamlfile(filename::AbstractString, yamldata; julia::Bool=false) # dump YAML file
		f = open(filename, "w")
		if julia
			JSON.print(f, yamldata)
		else
			write(f, yaml.dump(yamldata, width=255)) # for now we use the python library because the YAML julia library cannot dump
		end
		close(f)
	end
elseif isdefined(:YAML) # using YAML in Julia
	warn("Julia YAML module is used")
	"Load YAML file"
	function loadyamlfile(filename::AbstractString; julia::Bool=true)
		yamldata = DataStructures.OrderedDict()
		f = open(filename)
		yamldata = YAML.load(f)
		close(f)
		return yamldata # this is not OrderedDict()
	end

	"Dump YAML file in JSON format"
	function dumpyamlfile(filename::AbstractString, yamldata; julia::Bool=true)
		Mads.dumpjsonfile(filename, yamldata)
		return yamldata # this is OrderedDict()
	end
else
	Mads.madserror("MADS needs YAML (and optionally PyYAML)!")
	throw("Missing modules!")
end

"""
Dump YAML Mads file

Arguments:

- `madsdata` : MADS problem dictionary
- `filename` : file name
"""
function dumpyamlmadsfile(madsdata, filename::AbstractString; julia::Bool=false) # load MADS input file in YAML forma
	yamldata = deepcopy(madsdata)
	deletekeys = ["Dynamic model", "Filename"]
	restore = Array(Bool, length(deletekeys))
	restorevals = Array(Any, length(deletekeys))
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
			for i = 1:length(yamldata["Wells"][well]["obs"])
				dict = Dict(i=>yamldata["Wells"][well]["obs"][i])
				yamldata["Wells"][well]["obs"][i] = dict
			end
		end
	end
	for obsorparam in ["Observations", "Parameters", "Wells"]
		if haskey(yamldata, obsorparam)
			a = Array(Any, 0)
			for key in keys(yamldata[obsorparam])
				if !ismatch(r"source[1-9]*_", key)
					push!( a, Dict(key=>yamldata[obsorparam][key]))
				end
			end
			yamldata[obsorparam] = a
		end
	end
	for tplorins in ["Templates", "Instructions"]
		if haskey(yamldata, tplorins)
			a = Array(Any, length(yamldata[tplorins]))
			i = 1
			keys = map(string, 1:length(yamldata[tplorins]))
			for key in keys
				a[i] = Dict(key=>yamldata[tplorins][i])
				i += 1
			end
			yamldata[tplorins] = a
		end
	end
	dumpyamlfile(filename, yamldata, julia=julia)
end

"Read MADS model predictions from a YAML file `filename`"
function readyamlpredictions(filename::AbstractString) # read YAML predictions
	return loadyamlfile(filename)
end

"Dump well data from MADS problem dictionary into a ASCII file"
function dumpwelldata(filename::AbstractString, madsdata)
	outfile = open(filename, "w")
	write(outfile, "well_name, x_coord [m], x_coord [m], z_coord [m], time [years], concentration [ppb]\n")
	for n in keys(madsdata["Wells"])
		x = madsdata["Wells"]["$n"]["x"]
		y = madsdata["Wells"]["$n"]["y"]
		z0 = madsdata["Wells"]["$n"]["z0"]
		z1 = madsdata["Wells"]["$n"]["z1"]
		o = madsdata["Wells"]["$n"]["obs"]
		for i in 1:length(o)
			c = o[i]["c"]
			t = o[i]["t"]
			write(outfile, "$n, $x, $y, $z0, $t, $c\n")
		end
	end
	close(outfile)
end
