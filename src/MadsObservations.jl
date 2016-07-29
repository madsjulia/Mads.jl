import Distributions
import DataStructures

"Is a dictionary containing all the observations"
function isobs(madsdata::Associative, dict::Associative)
	flag = true
	if haskey(madsdata, "Observations") || haskey(madsdata, "Wells")
		obs = getobskeys(madsdata)
	else
		obs = madsdata
	end
	for i in obs
		if !haskey(dict, i)
			flag = false
			break
		end
	end
	return flag
end

"Get keys for all observations in the MADS problem dictionary"
function getobskeys(madsdata::Associative)
	return collect(keys(madsdata["Observations"]))
end

"Get keys for all targets (observations with weights greater than zero) in the MADS problem dictionary"
function gettargetkeys(madsdata::Associative)
	w = getobsweight(madsdata)
	t = getobstarget(madsdata)
	k = getobskeys(madsdata )
	return k[w.>0 | isnan(t)]
end

"Get keys for all wells in the MADS problem dictionary"
function getwellkeys(madsdata::Associative)
	return collect(keys(madsdata["Wells"]))
end

# Make functions to get MADS observation variable names
getobsnames = ["min", "max", "log", "weight", "target", "time", "dist"]
getobsaltnames = ["min", "max", "log", "w", "c", "t", "dist"]
getobstypes = [Float64, Float64, Any, Float64, Float64, Float64, Distributions.Distribution]
getobsdefault = [-1e6, 1e6, nothing, 1, NaN, NaN, "Uniform(-1e6, 1e6)"]
getobslogdefault = [1e-6, 1e6, nothing, 1, NaN, NaN, "Uniform(1e-6, 1e6)"]
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
				if haskey(madsdata["Observations"][obskeys[i]], $obsname)
					obsvalue[i] = madsdata["Observations"][obskeys[i]][$obsname]
				elseif haskey(madsdata["Observations"][obskeys[i]], $obsaltname)
					obsvalue[i] = madsdata["Observations"][obskeys[i]][$obsaltname]
				else
					if haskey(madsdata["Observations"][obskeys[i]], "log") && madsdata["Observations"][obskeys[i]]["log"] == true
						obsvalue[i] = $(obslogdefault)
					else
						obsvalue[i] = $(obsdefault)
					end
					if ($obsname == "min" || $obsname == "max") && haskey(madsdata["Observations"][obskeys[i]], "dist")
						distribution = Distributions.eval(parse(madsdata["Observations"][obskeys[i]]["dist"]))
						if typeof(distribution) == Distributions.Uniform
							if $obsname == "min"
								obsvalue[i] = distribution.a
							elseif $obsname == "max"
								obsvalue[i] = distribution.b
							end
						end
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

"Set observation time"
function settime!(o::Associative, time)
	if haskey(o, "time")
		o["time"] = time
	elseif haskey(o, "t")
		o["t"] = time
	else
		o["time"] = time
	end
end

"Get observation weight"
function getweight(o::Associative)
	if haskey(o, "weight")
		weight = o["weight"]
	elseif haskey(o, "w")
		weight = o["w"]
	else
		weight = NaN
		madswarn("Weight is missing for observation $(o)!")
	end
	return weight
end

"Set observation weight"
function setweight!(o::Associative, weight)
	if haskey(o, "weight")
		o["weight"] = weight
	elseif haskey(o, "w")
		o["w"] = weight
	else
		o["weight"] = weight
	end
end

"Get observation target"
function gettarget(o::Associative)
	if haskey(o, "target")
		target = o["target"]
	elseif haskey(o, "c")
		target = o["c"]
	else
		target = NaN
		madswarn("Target is missing for observation $(o)!")
	end
	return target
end

"Set observation target"
function settarget!(o::Associative, target)
	if haskey(o, "target")
		o["target"] = target
	elseif haskey(o, "c")
		o["c"] = target
	else
		o["target"] = target
	end
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
			settime!(madsdata["Observations"][obskeys[i]], parse(Float64, s[2]))
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
			settime!(madsdata["Observations"][obskeys[i]], parse(Float64, m.captures[1]))
		end
	end
end

"Set observation weights in the MADS problem dictionary"
function setobsweights!(madsdata::Associative, value::Number)
	obskeys = Mads.getobskeys(madsdata)
	for i in 1:length(obskeys)
		setweight!(madsdata["Observations"][obskeys[i]], value)
	end
end

"Modify (multiply) observation weights in the MADS problem dictionary"
function modobsweights!(madsdata::Associative, value::Number)
	obskeys = Mads.getobskeys(madsdata)
	for i in 1:length(obskeys)
		setweight!(madsdata["Observations"][obskeys[i]], getweight(madsdata["Observations"][obskeys[i]]) * value)
	end
end

"Inversely proportional observation weights in the MADS problem dictionary"
function invobsweights!(madsdata::Associative, value::Number)
	obskeys = Mads.getobskeys(madsdata)
	for i in 1:length(obskeys)
		t = gettarget(madsdata["Observations"][obskeys[i]])
		if getweight(madsdata["Observations"][obskeys[i]]) > 0 && t > 0
			setweight!(madsdata["Observations"][obskeys[i]], (1. / t) * value)
		end
	end
end

"Set well weights in the MADS problem dictionary"
function setwellweights!(madsdata::Associative, value::Number)
	wellkeys = getwellkeys(madsdata)
	for i in 1:length(wellkeys)
		for k in 1:length(madsdata["Wells"][wellkeys[i]]["obs"])
			setweight!(madsdata["Wells"][wellkeys[i]]["obs"][k], value)
		end
	end
	setobsweights!(madsdata, value)
end

"Modify (multiply) well weights in the MADS problem dictionary"
function modwellweights!(madsdata::Associative, value::Number)
	wellkeys = getwellkeys(madsdata)
	for i in 1:length(wellkeys)
		for k in 1:length(madsdata["Wells"][wellkeys[i]]["obs"])
			setweight!(madsdata["Wells"][wellkeys[i]]["obs"][k], getweight(madsdata["Wells"][wellkeys[i]]["obs"][k]) * value)
		end
	end
	modobsweights!(madsdata, value)
end

"Inversely proportional observation weights in the MADS problem dictionary"
function invwellweights!(madsdata::Associative, value::Number)
	wellkeys = getwellkeys(madsdata)
	for i in 1:length(wellkeys)
		for k in 1:length(madsdata["Wells"][wellkeys[i]]["obs"])
			t = gettarget(madsdata["Wells"][wellkeys[i]]["obs"][k])
			if getweight(madsdata["Wells"][wellkeys[i]]["obs"][k]) > 0 && t > 0 
				setweight!(madsdata["Wells"][wellkeys[i]]["obs"][k], (1. / t) * value)
			end
		end
	end
	invobsweights!(madsdata, value)
end

"Show observations in the MADS problem dictionary"
function showobservations(madsdata::Associative)
	obsdict = madsdata["Observations"]
	obskeys = Mads.getobskeys(madsdata)
	p = Array(ASCIIString, 0)
	for obskey in obskeys
		w = getweight(obsdict[obskey])
		t = gettarget(obsdict[obskey])
		if w != NaN
			s = @sprintf "%-10s target = %15g weight = %15g\n" obskey t w
			push!(p, s)
		else
			s = @sprintf "%-10s target = %15g\n" obskey t
			push!(p, s)
		end
	end
	print(p...)
	# display(p)
	println("Number of observations is $(length(p))")
end

"Create observations in the MADS problem dictionary based on `time` and `observation` arrays"
function createobservations!(madsdata::Associative, time, observation; logtransform=false, weight_type="constant", weight=1)
	@assert length(time) == length(observation)
	observationsdict = DataStructures.OrderedDict()
	for i in 1:length(time)
		obskey = string("o", time[i])
		data = DataStructures.OrderedDict()
		data["target"] = observation[i]
		if weight_type == "constant"
			if weight != 1
				data["weight"] = weight
			end
		else
			data["weight"] = 1 / observation[i]
		end
		data["time"] = time[i]
		if logtransform == true
			data["log"] = logtransform
		end
		observationsdict[obskey] = data
	end
	madsdata["Observations"] = observationsdict
end

function createobservations!(madsdata::Associative, observations::Associative; logtransform=false, weight_type="constant", weight=1)
	observationsdict = DataStructures.OrderedDict()
	for k in keys(observations)
		data = DataStructures.OrderedDict()
		data["target"] = observations[k]
		if weight_type == "constant"
			if weight != 1
				data["weight"] = weight
			end
		else
			data["weight"] = 1 / observation[i]
		end
		if logtransform == true
			data["log"] = logtransform
		end
		observationsdict[k] = data
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
				t = gettime(madsdata["Wells"][wellkey]["obs"][i])
				obskey = wellkey * "_" * string(t)
				data = DataStructures.OrderedDict()
				data["well"] = wellkey
				data["time"] = t
				data["index"] = i
				target = gettarget(madsdata["Wells"][wellkey]["obs"][i])
				if target != NaN
					data["target"] = target
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
