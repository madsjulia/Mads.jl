"Get keys for observations"
function getobskeys(madsdata::Associative)
	return collect(keys(madsdata["Observations"]))
	#return [convert(AbstractString,k) for k in keys(madsdata["Observations"])]
end

"Get keys for wells"
function getwellkeys(madsdata::Associative)
	return collect(keys(madsdata["Wells"]))
	#return [convert(AbstractString,k) for k in keys(madsdata["Wells"])]
end

"Create functions to get values of the MADS observations"
getobsnames = ["min", "max", "log", "weight", "target"]
getobstypes = [Float64, Float64, Any, Float64, Float64]
getobsdefault = [-Inf32, Inf32, nothing, 1, 0]
for i = 1:length(getobsnames)
	obsname = getobsnames[i]
	obstype = getobstypes[i]
	obsdefault = getobsdefault[i]
	q = quote
		function $(symbol(string("getobs", obsname)))(madsdata, obskeys) # create a function to get each parameter name with 2 arguments
			obsvalue = Array($(obstype), length(obskeys))
			for i in 1:length(obskeys)
				if haskey( madsdata["Observations"][obskeys[i]], $obsname)
					obsvalue[i] = madsdata["Observations"][obskeys[i]][$obsname]
				else
					obsvalue[i] = $(obsdefault)
				end
			end
			return obsvalue # returns the parameter values
		end
		function $(symbol(string("getobs", obsname)))(madsdata) # create a function to get each parameter name with 1 argument
			obskeys = getobskeys(madsdata) # get observation keys
			return $(symbol(string("getobs", obsname)))(madsdata, obskeys) # call the function with 2 arguments
		end
	end
	eval(q)
end

function setobsweights!(madsdata, value::Number)
	obskeys = getobskeys(madsdata)
	for i in 1:length(obskeys)
		madsdata["Observations"][obskeys[i]]["weight"] = value
	end
end

function setwellweights!(madsdata, value::Number)
	wellkeys = getwellkeys(madsdata)
	for i in 1:length(wellkeys)
		for k in 1:length(madsdata["Wells"][wellkeys[i]]["obs"])
			madsdata["Wells"][wellkeys[i]]["obs"][k]["weight"] = value
		end
	end
	setobsweights!(madsdata, value)
end

"Show observations"
function showobservations(madsdata::Associative)
	obsdict = madsdata["Observations"]
	obskeys = Mads.getobskeys(madsdata)
	p = Array(ASCIIString, 0)
	for obskey in obskeys
		if obsdict[obskey]["weight"] > eps(Float16)
			s = @sprintf "%-10s target = %15g weight = %15g" obskey obsdict[obskey]["target"] obsdict[obskey]["weight"]
			push!(p, s)
		end
	end
	display(p)
end

"Create observations"
function createobservations!(madsdata::Associative, t, c; logtransform=false, weight_type="constant", weight=1 )
	@assert length(t) == length(c)
	observationsdict = OrderedDict()
	for i in 1:length(t)
		obskey = string("o", t[i])
		data = OrderedDict()
		data["target"] = c[i]
		if weight_type == "constant"
			data["weight"] = weight
		else
			data["weight"] = 1 / c[i]
		end
		data["time"] = t[i]
		data["log"] = logtransform
		data["min"] = 0
		data["max"] = 1
		observationsdict[obskey] = data
	end
	madsdata["Observations"] = observationsdict
end

"Set observations (calibration targets)"
function setobservationtargets!(madsdata::Associative, predictions::Associative)
	observationsdict = madsdata["Observations"]
	if haskey(madsdata, "Wells")
		wellsdict = madsdata["Wells"]
	end
	for k in keys(predictions)
		observationsdict[k]["target"] = predictions[k]
		if haskey( observationsdict[k], "well" )
			well = observationsdict[k]["well"]
			i = observationsdict[k]["index"]
			wellsdict[well]["obs"][i]["c"] = predictions[k]
		end
	end
end

"Turn on all Wells"
function allwellson!(madsdata::Associative)
	for wellkey in collect(keys(madsdata["Wells"]))
		madsdata["Wells"][wellkey]["on"] = true
	end
	wells2observations!(madsdata)
end

"Turn on a specific well"
function wellon!(madsdata::Associative, wellname::AbstractString)
	error = true
	for wellkey in collect(keys(madsdata["Wells"]))
		if wellname == wellkey
			madsdata["Wells"][wellkey]["on"] = true
			error = false
		end
	end
	if error
		Mads.err("""Well name $wellname does not match existing well names!""")
	else
		wells2observations!(madsdata)
	end
end

"Turn off all Wells"
function allwellsoff!(madsdata::Associative)
	for wellkey in collect(keys(madsdata["Wells"]))
		madsdata["Wells"][wellkey]["on"] = false
	end
	wells2observations!(madsdata)
end

"Turn off a specific well"
function welloff!(madsdata, wellname::AbstractString)
	error = true
	for wellkey in collect(keys(madsdata["Wells"]))
		if wellname == wellkey
			madsdata["Wells"][wellkey]["on"] = false
			error = false
		end
	end
	if error
		Mads.err("""Well name $wellname does not match existing well names!""")
	else
		wells2observations!(madsdata)
	end
end

"Convert Wells to Observations class"
function wells2observations!(madsdata::Associative)
	observations = DataStructures.OrderedDict()
	for wellkey in collect(keys(madsdata["Wells"]))
		if madsdata["Wells"][wellkey]["on"]
			for i in 1:length(madsdata["Wells"][wellkey]["obs"])
				t = madsdata["Wells"][wellkey]["obs"][i]["t"]
				obskey = wellkey * "_" * string(t)
				data = DataStructures.OrderedDict()
				data["well"] = wellkey
				data["time"] = t
				data["index"] = i
				if haskey(madsdata["Wells"][wellkey]["obs"][i], "c") && !haskey(madsdata["Wells"][wellkey]["obs"][i], "target")
					data["target"] = madsdata["Wells"][wellkey]["obs"][i]["c"]
				end
				for datakey in keys(madsdata["Wells"][wellkey]["obs"][i])
					if datakey != "c" && datakey != "t"
						data[datakey] = madsdata["Wells"][wellkey]["obs"][i][datakey]
					end
				end
				observations[obskey] = data
			end
		end
	end
	madsdata["Observations"] = observations
end
