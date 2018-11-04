import Distributions
import OrderedCollections
import DocumentFunction
import JSON
using Compat

"""
Is a dictionary containing all the observations

$(DocumentFunction.documentfunction(isobs;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "dict"=>"dictionary")))

Returns:

- `true` if the dictionary contain all the observations, `false` otherwise
"""
function isobs(madsdata::AbstractDict, dict::AbstractDict)
	if haskey(madsdata, "Observations") || haskey(madsdata, "Wells")
		obs = getobskeys(madsdata)
	else
		obs = collect(keys(madsdata))
	end
	flag = true
	for i in obs
		if !haskey(dict, i)
			flag = false
			break
		end
	end
	return flag
end

"""
Get keys for all observations in the MADS problem dictionary

$(DocumentFunction.documentfunction(getobskeys;
argtext=Dict("madsdata"=>"MADS problem dictionary")))

Returns:

- keys for all observations in the MADS problem dictionary
"""
function getobskeys(madsdata::AbstractDict)
	return convert(Array{String}, collect(keys(madsdata["Observations"])))
end

"""
Get keys for all targets (observations with weights greater than zero) in the MADS problem dictionary

$(DocumentFunction.documentfunction(gettargetkeys;
argtext=Dict("madsdata"=>"MADS problem dictionary")))

Returns:

- keys for all targets in the MADS problem dictionary
"""
function gettargetkeys(madsdata::AbstractDict)
	w = getobsweight(madsdata)
	t = getobstarget(madsdata)
	k = getobskeys(madsdata)
	return convert(Array{String}, k[w.>0 .| isnan.(t)])
end

"""
Get keys for all wells in the MADS problem dictionary

$(DocumentFunction.documentfunction(getwellkeys;
argtext=Dict("madsdata"=>"MADS problem dictionary")))

Returns:

- keys for all wells in the MADS problem dictionary
"""
function getwellkeys(madsdata::AbstractDict)
	return collect(keys(madsdata["Wells"]))
end

# Make functions to get MADS observation variable names
getobsnames = ["min", "max", "log", "weight", "target", "time", "dist"]
getobsaltnames = ["min", "max", "log", "w", "c", "t", "dist"]
getobstypes = [Float64, Float64, Any, Float64, Float64, Float64, String]
getobsdefault = [-1e6, 1e6, nothing, 1, NaN, NaN, "Uniform(-1e6, 1e6)"]
getobslogdefault = [1e-6, 1e6, nothing, 1, NaN, NaN, "Uniform(1e-6, 1e6)"]
global index = 0
for i = 1:length(getobsnames)
	global index = i
	obsname = getobsnames[index]
	obsaltname = getobsaltnames[index]
	obstype = getobstypes[index]
	obsdefault = getobsdefault[index]
	obslogdefault = getobslogdefault[index]
	q = quote
		"""
		Get an array with `$(getobsnames[index])` values for observations in the MADS problem dictionary defined by `obskeys`
		"""
		function $(Symbol(string("getobs", obsname)))(madsdata::AbstractDict, obskeys)
			obsvalue = Array{$(obstype)}(undef, length(obskeys))
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
						distribution = Mads.getdistribution(madsdata["Observations"][obskeys[i]]["dist"], obskeys[i], "observation")
						if typeof(distribution) <: Distributions.Uniform
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
		"""
		Get an array with `$(getobsnames[index])` values for all observations in the MADS problem dictionary
		"""
		function $(Symbol(string("getobs", obsname)))(madsdata::AbstractDict)
			obskeys = collect(keys(madsdata["Observations"]))
			return $(Symbol(string("getobs", obsname)))(madsdata::AbstractDict, obskeys)
		end
	end
	Core.eval(Mads, q)
end

"""
Get observation time

$(DocumentFunction.documentfunction(gettime;
argtext=Dict("o"=>"observation data")))

Returns:

- observation time ("NaN" it time is missing)
"""
function gettime(o::AbstractDict)
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

"""
Set observation time

$(DocumentFunction.documentfunction(settime!;
argtext=Dict("o"=>"observation data",
            "time"=>"observation time")))
"""
function settime!(o::AbstractDict, time::Number)
	if haskey(o, "time")
		o["time"] = time
	elseif haskey(o, "t")
		o["t"] = time
	else
		o["time"] = time
	end
end

"""
Get observation weight

$(DocumentFunction.documentfunction(getweight;
argtext=Dict("o"=>"observation data")))

Returns:

- observation weight ("NaN" when weight is missing)
"""
function getweight(o::AbstractDict)
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

"""
Set observation weight

$(DocumentFunction.documentfunction(setweight!;
argtext=Dict("o"=>"observation data",
            "weight"=>"observation weight")))
"""
function setweight!(o::AbstractDict, weight::Number)
	if haskey(o, "weight")
		o["weight"] = weight
	elseif haskey(o, "w")
		o["w"] = weight
	else
		o["weight"] = weight
	end
end

"""
Get observation target

$(DocumentFunction.documentfunction(gettarget;
argtext=Dict("o"=>"observation data")))

Returns:

- observation target
"""
function gettarget(o::AbstractDict)
	if haskey(o, "target")
		target = o["target"]
	elseif haskey(o, "c")
		target = o["c"]
	else
		target = NaN
		!quiet && madswarn("Target is missing for observation $(o)!")
	end
	return target
end

"""
Set observation target

$(DocumentFunction.documentfunction(settarget!;
argtext=Dict("o"=>"observation data",
            "target"=>"observation target")))
"""
function settarget!(o::AbstractDict, target::Number)
	if haskey(o, "target")
		o["target"] = target
	elseif haskey(o, "c")
		o["c"] = target
	else
		o["target"] = target
	end
end

function setobstime!(madsdata::AbstractDict, separator::String="_")
	obskeys = getobskeys(madsdata)
	for i in 1:length(obskeys)
		s = split(obskeys[i], separator)
		if length(s) != 2
			madswarn("String `$(split)` cannot split $(obskeys[i])")
		else
			settime!(madsdata["Observations"][obskeys[i]], Base.parse(Float64, s[2]))
		end
	end
end
function setobstime!(madsdata::AbstractDict, rx::Regex)
	obskeys = getobskeys(madsdata)
	for i in 1:length(obskeys)
		m = match(rx, obskeys[i])
		if typeof(m) == Nothing || length(m.captures) != 1
			madswarn("Regular expression `$(rx)` cannot match $(obskeys[i])")
		else
			settime!(madsdata["Observations"][obskeys[i]], Base.parse(Float64, m.captures[1]))
		end
	end
end

@doc """
Set observation time based on the observation name in the MADS problem dictionary

$(DocumentFunction.documentfunction(setobstime!;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "separator"=>"separator [default=`_`]",
            "rx"=>"regular expression to match")))

Examples:

```julia
Mads.setobstime!(madsdata, "_t")
Mads.setobstime!(madsdata, r"[A-x]*_t([0-9,.]+)")
```
""" setobstime!

"""
Set observation weights in the MADS problem dictionary

$(DocumentFunction.documentfunction(setobsweights!;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "value"=>"value for observation weights")))
"""
function setobsweights!(madsdata::AbstractDict, value::Number)
	obskeys = getobskeys(madsdata)
	for i in 1:length(obskeys)
		setweight!(madsdata["Observations"][obskeys[i]], value)
	end
end

"""
Modify (multiply) observation weights in the MADS problem dictionary

$(DocumentFunction.documentfunction(modobsweights!;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "value"=>"value for modifing observation weights")))
"""
function modobsweights!(madsdata::AbstractDict, value::Number)
	obskeys = getobskeys(madsdata)
	for i in 1:length(obskeys)
		setweight!(madsdata["Observations"][obskeys[i]], getweight(madsdata["Observations"][obskeys[i]]) * value)
	end
end

"""
Set inversely proportional observation weights in the MADS problem dictionary

$(DocumentFunction.documentfunction(invobsweights!;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "multiplier"=>"weight multiplier")))
"""
function invobsweights!(madsdata::AbstractDict, multiplier::Number)
	obskeys = getobskeys(madsdata)
	for i in 1:length(obskeys)
		t = gettarget(madsdata["Observations"][obskeys[i]])
		if getweight(madsdata["Observations"][obskeys[i]]) > 0 && t > 0
			setweight!(madsdata["Observations"][obskeys[i]], (1. / t) * multiplier)
		end
	end
end

"""
Set well weights in the MADS problem dictionary

$(DocumentFunction.documentfunction(setwellweights!;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "value"=>"value for well weights")))
"""
function setwellweights!(madsdata::AbstractDict, value::Number)
	wellkeys = getwellkeys(madsdata)
	for i in 1:length(wellkeys)
		if haskey(madsdata["Wells"][wellkeys[i]], "obs") && madsdata["Wells"][wellkeys[i]]["obs"] != nothing
			for k in 1:length(madsdata["Wells"][wellkeys[i]]["obs"])
				setweight!(madsdata["Wells"][wellkeys[i]]["obs"][k], value)
			end
		end
	end
	setobsweights!(madsdata, value)
end

"""
Modify (multiply) well weights in the MADS problem dictionary

$(DocumentFunction.documentfunction(modwellweights!;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "value"=>"value for well weights")))
"""
function modwellweights!(madsdata::AbstractDict, value::Number)
	wellkeys = getwellkeys(madsdata)
	for i in 1:length(wellkeys)
		if haskey(madsdata["Wells"][wellkeys[i]], "obs") && madsdata["Wells"][wellkeys[i]]["obs"] != nothing
			for k in 1:length(madsdata["Wells"][wellkeys[i]]["obs"])
				setweight!(madsdata["Wells"][wellkeys[i]]["obs"][k], getweight(madsdata["Wells"][wellkeys[i]]["obs"][k]) * value)
			end
		end
	end
	modobsweights!(madsdata, value)
end

"""
Set inversely proportional well weights in the MADS problem dictionary

$(DocumentFunction.documentfunction(invwellweights!;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "multiplier"=>"weight multiplier")))
"""
function invwellweights!(madsdata::AbstractDict, multiplier::Number)
	wellkeys = getwellkeys(madsdata)
	for i in 1:length(wellkeys)
		if haskey(madsdata["Wells"][wellkeys[i]], "obs") && madsdata["Wells"][wellkeys[i]]["obs"] != nothing
			for k in 1:length(madsdata["Wells"][wellkeys[i]]["obs"])
				t = gettarget(madsdata["Wells"][wellkeys[i]]["obs"][k])
				if getweight(madsdata["Wells"][wellkeys[i]]["obs"][k]) > 0 && t > 0
					setweight!(madsdata["Wells"][wellkeys[i]]["obs"][k], (1. / t) * multiplier)
				end
			end
		end
	end
	invobsweights!(madsdata, multiplier)
end

"""
Show observations in the MADS problem dictionary

$(DocumentFunction.documentfunction(showobservations;
argtext=Dict("madsdata"=>"MADS problem dictionary")))
"""
function showobservations(madsdata::AbstractDict)
	obsdict = madsdata["Observations"]
	obskeys = getobskeys(madsdata)
	p = Array{String}(undef, 0)
	for obskey in obskeys
		w = getweight(obsdict[obskey])
		t = gettarget(obsdict[obskey])
		if w != NaN
			s = @Printf.sprintf "%-10s target = %15g weight = %15g\n" obskey t w
			push!(p, s)
		else
			s = @Printf.sprintf "%-10s target = %15g\n" obskey t
			push!(p, s)
		end
	end
	print(p...)
	# Base.display(p)
	println("Number of observations is $(length(p))")
end

function printobservations(madsdata::AbstractDict, io::IO=stdout)
	obskeys = getobskeys(madsdata)
	println(io, "Observations:")
	for k in obskeys
		print(io, "- $(k): ")
		JSON.print(io, madsdata["Observations"][k])
		print(io, "\n")
	end
end
function printobservations(madsdata::AbstractDict, filename::String; json::Bool=false)
	f = open(filename, "w")
	printobservations(madsdata, f)
	close(f)
end
@doc """
Print (emit) observations in the MADS problem dictionary

$(DocumentFunction.documentfunction(printobservations;
argtext=Dict("madsdata"=>"MADS problem dictionary", "io"=>"output stream", "filename"=>"output file name")))
""" printobservations

function createobservations!(madsdata::AbstractDict, time::Vector, observation::Vector=zeros(length(time)); logtransform::Bool=false, weight_type::String="constant", weight::Number=1)
	nT = length(time)
	@assert nT == length(observation)
	if !haskey(madsdata, "Wells")
		observationsdict = OrderedCollections.OrderedDict()
		for i in 1:nT
			obskey = string("o", time[i])
			data = OrderedCollections.OrderedDict()
			data["target"] = observation[i]
			if weight_type == "constant"
				data["weight"] = weight
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
	else
		for wellname in keys(madsdata["Wells"])
			observationsarray = Array{Dict{Any,Any}}(undef, nT)
			for i in 1:nT
				data = OrderedCollections.OrderedDict()
				data["c"] = observation[i]
				if weight_type == "constant"
					data["weight"] = weight
				else
					data["weight"] = 1 / observation[i]
				end
				data["t"] = time[i]
				if logtransform == true
					data["log"] = logtransform
				end
				observationsarray[i] = data
			end
			madsdata["Wells"][wellname]["obs"] = observationsarray
		end
		wells2observations!(madsdata)
	end
	nothing
end
function createobservations!(madsdata::AbstractDict, observation::AbstractDict; logtransform::Bool=false, weight_type::String="constant", weight::Number=1)
	observationsdict = OrderedCollections.OrderedDict()
	for k in keys(observation)
		data = OrderedCollections.OrderedDict()
		data["target"] = observation[k]
		if weight_type == "constant"
			if weight != 1
				data["weight"] = weight
			end
		else
			data["weight"] = 1 / observation[k]
		end
		if logtransform == true
			data["log"] = logtransform
		end
		observationsdict[k] = data
	end
	madsdata["Observations"] = observationsdict
end

@doc """
Create observations in the MADS problem dictionary based on `time` and `observation` vectors

$(DocumentFunction.documentfunction(createobservations!;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "time"=>"vector of observation times",
            "observation"=>"vector of observations [default=`zeros(length(time))`]",
            "observation"=>"dictionary of observations"),
keytext=Dict("logtransform"=>"log transform observations [default=`false`]",
            "weight_type"=>"weight type [default=`constant`]",
            "weight"=>"weight value [default=`1`]")))
""" createobservations!

"""
Set observations (calibration targets) in the MADS problem dictionary based on a `predictions` dictionary

$(DocumentFunction.documentfunction(setobservationtargets!;
argtext=Dict("madsdata"=>"Mads problem dictionary",
            "predictions"=>"dictionary with model predictions")))
"""
function setobservationtargets!(madsdata::AbstractDict, predictions::AbstractDict)
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

"""
Turn on all the wells in the MADS problem dictionary

$(DocumentFunction.documentfunction(allwellson!;
argtext=Dict("madsdata"=>"MADS problem dictionary")))
"""
function allwellson!(madsdata::AbstractDict)
	for wellkey in keys(madsdata["Wells"])
		madsdata["Wells"][wellkey]["on"] = true
	end
	wells2observations!(madsdata)
end

"""
Turn on a specific well in the MADS problem dictionary

$(DocumentFunction.documentfunction(wellon!;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "wellname"=>"name of the well to be turned on")))
"""
function wellon!(madsdata::AbstractDict, wellname::String)
	error = true
	for wellkey in keys(madsdata["Wells"])
		if wellname == wellkey
			madsdata["Wells"][wellkey]["on"] = true
			error = false
		end
	end
	if error
		Mads.madswarn("""Well name $wellname does not match existing well names!""")
	else
		wells2observations!(madsdata)
	end
end

"""
Turn on a specific well in the MADS problem dictionary

$(DocumentFunction.documentfunction(wellon!;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "wellname"=>"name of the well to be turned on")))
"""
function wellon!(madsdata::AbstractDict, rx::Regex)
	error = true
	for wellkey in keys(madsdata["Wells"])
		m = match(rx, wellkey)
		if typeof(m) != Nothing
			madsdata["Wells"][wellkey]["on"] = true
			error = false
		end
	end
	if error
		Mads.madswarn("""Well name $rx does not match existing well names!""")
	else
		wells2observations!(madsdata)
	end
end

"""
Turn off all the wells in the MADS problem dictionary

$(DocumentFunction.documentfunction(allwellsoff!;
argtext=Dict("madsdata"=>"MADS problem dictionary")))
"""
function allwellsoff!(madsdata::AbstractDict)
	for wellkey in keys(madsdata["Wells"])
		madsdata["Wells"][wellkey]["on"] = false
	end
	wells2observations!(madsdata)
end

"""
Turn off a specific well in the MADS problem dictionary

$(DocumentFunction.documentfunction(welloff!;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "wellname"=>"name of the well to be turned off")))
"""
function welloff!(madsdata::AbstractDict, wellname::String)
	error = true
	for wellkey in keys(madsdata["Wells"])
		if wellname == wellkey
			madsdata["Wells"][wellkey]["on"] = false
			error = false
		end
	end
	if error
		Mads.madswarn("""Well name $wellname does not match existing well names!""")
	else
		wells2observations!(madsdata)
	end
end

"""
Delete all wells marked as being off in the MADS problem dictionary

$(DocumentFunction.documentfunction(welloff!;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "wellname"=>"name of the well to be turned off")))
"""
function deleteoffwells!(madsdata::AbstractDict)
    for wellkey in keys(madsdata["Wells"])
        if madsdata["Wells"][wellkey]["on"] == false
            delete!(madsdata["Wells"], wellkey)
        end
    end
end

"""
Delete all times in the MADS problem dictionary in a given list.

$(DocumentFunction.documentfunction(welloff!;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "wellname"=>"name of the well to be turned off")))
"""
function deletetimes!(madsdata::AbstractDict, deletetimes)
    for wellkey in keys(madsdata["Wells"])
        delete_pos = [] # position of times to be deleted.
        for obs_num in 1:length(madsdata["Wells"][wellkey]["obs"])
            if madsdata["Wells"][wellkey]["obs"][obs_num]["t"] in deletetimes
                delete_pos = append!(delete_pos, obs_num)
            end
        end
        deleteat!( madsdata["Wells"][wellkey]["obs"], delete_pos)
    end
end

"""
Convert `Wells` class to `Observations` class in the MADS problem dictionary

$(DocumentFunction.documentfunction(wells2observations!;
argtext=Dict("madsdata"=>"MADS problem dictionary")))
"""
function wells2observations!(madsdata::AbstractDict)
	observations = OrderedCollections.OrderedDict()
	for wellkey in keys(madsdata["Wells"])
		if madsdata["Wells"][wellkey]["on"]
			if haskey(madsdata["Wells"][wellkey], "obs") && madsdata["Wells"][wellkey]["obs"] != nothing
				for i in 1:length(madsdata["Wells"][wellkey]["obs"])
					t = gettime(madsdata["Wells"][wellkey]["obs"][i])
					obskey = wellkey * "_" * string(t)
					data = OrderedCollections.OrderedDict()
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
	end
	madsdata["Observations"] = observations
end

"""
Get spatial and temporal data in the `Wells` class

$(DocumentFunction.documentfunction(getwelldata;
argtext=Dict("madsdata"=>"Mads problem dictionary"),
keytext=Dict("time"=>"get observation times [default=`false`]")))

Returns:

- array with spatial and temporal data in the `Wells` class
"""
function getwelldata(madsdata::AbstractDict; time::Bool=false)
	if time
		a = Array{Float64}(undef, 4, 0)
	else
		a = Array{Float64}(undef, 3, 0)
	end
	for wellkey in keys(madsdata["Wells"])
		if madsdata["Wells"][wellkey]["on"]
			x = madsdata["Wells"][wellkey]["x"]
			y = madsdata["Wells"][wellkey]["y"]
			z = (madsdata["Wells"][wellkey]["z0"] + madsdata["Wells"][wellkey]["z1"])/2
			if !time
				a = [a [x, y, z]]
			else
				o = madsdata["Wells"][wellkey]["obs"]
				nT = length(o)
				for i in 1:nT
					t = gettime(o[i])
					a = [a [x, y, z, t]]
				end
			end
		end
	end
	return a
end

"""
$(DocumentFunction.documentfunction(getwelltargets;
argtext=Dict("madsdata"=>"Mads problem dictionary")))

Returns:

- array with targets in the `Wells` class
"""
function getwelltargets(madsdata::AbstractDict)
	a = Vector{Vector{Float64}}(undef, 0)
	for wellkey in keys(madsdata["Wells"])
		if madsdata["Wells"][wellkey]["on"] && haskey(madsdata["Wells"][wellkey], "obs")
			o = madsdata["Wells"][wellkey]["obs"]
			nT = length(o)
			t = Vector{Float64}(undef, 0)
			for i in 1:nT
				v = gettarget(o[i])
				push!(t, v)
			end
			push!(a, t)
		end
	end
	return a
end
