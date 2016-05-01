"Get keys for all observations in the MADS problem dictionary"
function getobskeys(madsdata::Associative)
	return collect(keys(madsdata["Observations"]))
end

"Get keys for all targets (observations with weights greater than zero) in the MADS problem dictionary"
function gettargetkeys(madsdata::Associative)
	w = getobsweight(madsdata)
	k = getobskeys(madsdata)
	return k[w.>0]
end

"Get keys for all wells in the MADS problem dictionary"
function getwellkeys(madsdata::Associative)
	return collect(keys(madsdata["Wells"]))
end

# Make functions to get MADS observation variable names
getobsnames = ["min", "max", "log", "weight", "target", "time"]
getobsaltnames = ["min", "max", "log", "w", "c", "t"]
getobstypes = [Float64, Float64, Any, Float64, Float64, Float64]
getobsdefault = [-1e6, 1e6, nothing, 1, 0, NaN]
getobslogdefault = [1e-6, 1e6, nothing, 1, 1, NaN]
index = 0
for i = 1:length(getobsnames)
	obsname = getobsnames[i]
	obsaltname = getobsaltnames[i]
	obstype = getobstypes[i]
	obsdefault = getobsdefault[i]
	obslogdefault = getobslogdefault[i]
	index = i
	q = quote
		@doc "Get an array with `$(getobsnames[index])` values for observations in the MADS problem dictionary defined by `obskeys`" ->
		function $(symbol(string("getobs", obsname)))(madsdata::Associative, obskeys) 
			obsvalue = Array($(obstype), length(obskeys))
			for i in 1:length(obskeys)
				if haskey( madsdata["Observations"][obskeys[i]], $obsname)
					obsvalue[i] = madsdata["Observations"][obskeys[i]][$obsname]
				elseif haskey( madsdata["Observations"][obskeys[i]], $obsaltname)
					obsvalue[i] = madsdata["Observations"][obskeys[i]][$obsaltname]
				else
					if haskey(madsdata["Observations"][obskeys[i]], "log") && madsdata["Observations"][obskeys[i]]["log"] == true
						obsvalue[i] = $(obslogdefault)
					else
						obsvalue[i] = $(obsdefault)
					end
				end
			end
			return obsvalue
		end
		@doc "Get an array with `$(getobsnames[index])` values for all observations in the MADS problem dictionary"  ->
		function $(symbol(string("getobs", obsname)))(madsdata::Associative)
			obskeys = getobskeys(madsdata)
			return $(symbol(string("getobs", obsname)))(madsdata::Associative, obskeys)
		end
	end
	eval(q)
end

"Get observation time"
function gettime(o::Associative)
	if haskey(o, "time")
		time = o["time"]
	elseif haskey(o, "t")
		time = o["t"]
	else
		time = NaN
		madswarn("Time is missing for observation $(o)!")
	end
	return time
end

"Get observation weight"
function getweight(o::Associative)
	if haskey(o, "weight")
		time = o["weight"]
	elseif haskey(o, "w")
		time = o["w"]
	else
		time = NaN
		madswarn("Weight is missing for observation $(o)!")
	end
	return time
end

"Get observation target"
function gettarget(o::Associative)
	if haskey(o, "target")
		time = o["target"]
	elseif haskey(o, "c")
		time = o["c"]
	else
		time = NaN
		madswarn("Target is missing for observation $(o)!")
	end
	return time
end

"""
Set observation time based on the observation name in the MADS problem dictionary

Usage:

```
Mads.setobstime!(madsdata, separator)
Mads.setobstime!(madsdata, regex)
```

Arguments:

- `madsdata` : MADS problem dictionary
- `separator` : string to separator
- `regex` : regular expression to match

Examples:
```
Mads.setobstime!(madsdata, "_t")
Mads.setobstime!(madsdata, r"[A-x]*_t([0-9,.]+)")
```
"""
function setobstime!(madsdata::Associative, separator::AbstractString="_")
	obskeys = Mads.getobskeys(madsdata)
	for i in 1:length(obskeys)
		s = split(obskeys[i], separator)
		if length(s) != 2
			madserror("String `$(split)` cannot split $(obskeys[i])")
		else
			madsdata["Observations"][obskeys[i]]["time"] = parse(Float64, s[2])
		end
	end
end
function setobstime!(madsdata::Associative, rx::Regex=r"[A-x]*_([0-9,.]+)")
	obskeys = Mads.getobskeys(madsdata)
	for i in 1:length(obskeys)
		m = match(rx, obskeys[i])
		if typeof(m) == Void || length(m.captures) != 1
			madserror("Regular expression `$(rx)` cannot match $(obskeys[i])")
		else
			madsdata["Observations"][obskeys[i]]["time"] = parse(Float64, m.captures[1])
		end
	end
end

"Set observation weights in the MADS problem dictionary"
function setobsweights!(madsdata::Associative, value::Number)
	obskeys = Mads.getobskeys(madsdata)
	for i in 1:length(obskeys)
		madsdata["Observations"][obskeys[i]]["weight"] = value
	end
end

"Modify (multiply) observation weights in the MADS problem dictionary"
function modobsweights!(madsdata::Associative, value::Number)
	obskeys = Mads.getobskeys(madsdata)
	for i in 1:length(obskeys)
		madsdata["Observations"][obskeys[i]]["weight"] *= value
	end
end

"Set well weights in the MADS problem dictionary"
function setwellweights!(madsdata::Associative, value::Number)
	wellkeys = getwellkeys(madsdata)
	for i in 1:length(wellkeys)
		for k in 1:length(madsdata["Wells"][wellkeys[i]]["obs"])
			madsdata["Wells"][wellkeys[i]]["obs"][k]["weight"] = value
		end
	end
	setobsweights!(madsdata, value)
end

"Modify (multiply) well weights in the MADS problem dictionary"
function modwellweights!(madsdata::Associative, value::Number)
	wellkeys = getwellkeys(madsdata)
	for i in 1:length(wellkeys)
		for k in 1:length(madsdata["Wells"][wellkeys[i]]["obs"])
			madsdata["Wells"][wellkeys[i]]["obs"][k]["weight"] *= value
		end
	end
	modobsweights!(madsdata, value)
end

"Show observations in the MADS problem dictionary"
function showobservations(madsdata::Associative)
	obsdict = madsdata["Observations"]
	obskeys = Mads.getobskeys(madsdata)
	p = Array(ASCIIString, 0)
	for obskey in obskeys
		if haskey( obsdict[obskey], "weight" )
			if obsdict[obskey]["weight"] > eps(Float16)
				s = @sprintf "%-10s target = %15g weight = %15g\n" obskey obsdict[obskey]["target"] obsdict[obskey]["weight"]
			end
		else
			s = @sprintf "%-10s target = %15g\n" obskey obsdict[obskey]["target"]
		end
		push!(p, s)
	end
	print(p...)
	println("Number of observations is $(length(p))")
end

"""
Create observations in the MADS problem dictionary based on `time` and `observation` arrays 
"""
function createobservations!(madsdata::Associative, time, observation; logtransform=false, weight_type="constant", weight=1)
	@assert length(time) == length(observation)
	observationsdict = OrderedDict()
	for i in 1:length(time)
		obskey = string("o", time[i])
		data = OrderedDict()
		data["target"] = observation[i]
		if weight_type == "constant"
			data["weight"] = weight
		else
			data["weight"] = 1 / observation[i]
		end
		data["time"] = time[i]
		data["log"] = logtransform
		data["min"] = 0
		data["max"] = 1
		observationsdict[obskey] = data
	end
	madsdata["Observations"] = observationsdict
end

"Set observations (calibration targets) in the MADS problem dictionary based on a `predictions` dictionary"
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

"Turn on all the wells in the MADS problem dictionary"
function allwellson!(madsdata::Associative)
	for wellkey in collect(keys(madsdata["Wells"]))
		madsdata["Wells"][wellkey]["on"] = true
	end
	wells2observations!(madsdata)
end

"Turn on a specific well in the MADS problem dictionary"
function wellon!(madsdata::Associative, wellname::AbstractString)
	error = true
	for wellkey in collect(keys(madsdata["Wells"]))
		if wellname == wellkey
			madsdata["Wells"][wellkey]["on"] = true
			error = false
		end
	end
	if error
		Mads.madserror("""Well name $wellname does not match existing well names!""")
	else
		wells2observations!(madsdata)
	end
end

"Turn off all the wells in the MADS problem dictionary"
function allwellsoff!(madsdata::Associative)
	for wellkey in collect(keys(madsdata["Wells"]))
		madsdata["Wells"][wellkey]["on"] = false
	end
	wells2observations!(madsdata)
end

"Turn off a specific well in the MADS problem dictionary"
function welloff!(madsdata, wellname::AbstractString)
	error = true
	for wellkey in collect(keys(madsdata["Wells"]))
		if wellname == wellkey
			madsdata["Wells"][wellkey]["on"] = false
			error = false
		end
	end
	if error
		Mads.madserror("""Well name $wellname does not match existing well names!""")
	else
		wells2observations!(madsdata)
	end
end

"Convert `Wells` class to `Observations` class in the MADS problem dictionary"
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
