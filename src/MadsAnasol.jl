import Anasol
import OrderedCollections
import ProgressMeter
import DocumentFunction

anasolarguments = ["n", "lambda", "theta", "vx", "vy", "vz", "ax", "ay", "az", "H"]
anasolparametersrequired = ["n", "lambda", "theta", "vx", "vy", "vz", "ax", "ay", "az"]
anasolparametersall = [anasolparametersrequired; ["H", "rf", "ts_dsp", "ts_adv", "ts_rct", "alpha", "beta", "nlc0", "nlc1"]]
anasolsourcerequired = ["x", "y", "z", "dx", "dy", "dz", "f", "t0", "t1"]

"""
Add an additional contamination source

$(DocumentFunction.documentfunction(addsource!;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "sourceid"=>"source id [default=`0`]")))
"""
function addsource!(madsdata::AbstractDict, sourceid::Int=0; dict::AbstractDict=Dict())
	if haskey(madsdata, "Sources")
		ns = length(madsdata["Sources"])
		if sourceid <= 0
			sourceid = ns
		end
		if sourceid <= ns
			s = deepcopy(madsdata["Sources"][sourceid])
			push!(madsdata["Sources"], s)
			for k = keys(dict)
				d = madsdata["Sources"][ns+1][keys(madsdata["Sources"][1])...]
				if haskey(d, k)
					d[k]["init"] = dict[k]
				end
			end
			addsourceparameters!(madsdata)
		else
			madserror("There are only $(ns) sources in the Mads dictionary!")
		end
	else
		madserror("There are no sources in the Mads dictionary!")
	end
	Mads.madswarn("There are $(length(madsdata["Sources"])) sources now!")
end

"""
Remove a contamination source

$(DocumentFunction.documentfunction(removesource!;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "sourceid"=>"source id [default=`0`]")))
"""
function removesource!(madsdata::AbstractDict, sourceid::Int=0)
	if haskey(madsdata, "Sources")
		ns = length(madsdata["Sources"])
		if sourceid <= 0
			sourceid = ns
		end
		if sourceid <= ns
			removesourceparameters!(madsdata)
			deleteat!(madsdata["Sources"], sourceid)
			addsourceparameters!(madsdata)
		else
			madserror("There are only $(ns) sources in the Mads dictionary!")
		end
	else
		madserror("There are no sources in the Mads dictionary!")
	end
	Mads.madswarn("There are $(length(madsdata["Sources"])) sources now!")
end

"""
Add contaminant source parameters

$(DocumentFunction.documentfunction(addsourceparameters!;
argtext=Dict("madsdata"=>"MADS problem dictionary")))
"""
function addsourceparameters!(madsdata::AbstractDict)
	if haskey(madsdata, "Sources")
		if !haskey(madsdata, "Parameters")
			madsdata["Parameters"] = OrderedCollections.OrderedDict()
		end
		for i = 1:length(madsdata["Sources"])
			sourcetype = collect(keys(madsdata["Sources"][i]))[1]
			sourceparams = collect(keys(madsdata["Sources"][i][sourcetype]))
			if length(findall((in)(sourceparams), anasolsourcerequired)) < length(anasolsourcerequired)
				Mads.madswarn("Missing: $(anasolsourcerequired[indexin(anasolsourcerequired, sourceparams).==0]))")
				Mads.madscritical("There are missing Anasol source parameters!")
			end
			extraparams = sourceparams[indexin(sourceparams, anasolsourcerequired).==0]
			for sourceparam in [anasolsourcerequired; extraparams]
				if !haskey(madsdata["Sources"][i][sourcetype][sourceparam], "exp")
					madsdata["Parameters"][string("source", i, "_", sourceparam)] = OrderedCollections.OrderedDict{String,Any}()
					for pf in keys(madsdata["Sources"][i][sourcetype][sourceparam])
						madsdata["Parameters"][string("source", i, "_", sourceparam)][pf] = madsdata["Sources"][i][sourcetype][sourceparam][pf]
					end
				else
					if !haskey(madsdata, "Expressions")
						madsdata["Expressions"] = OrderedCollections.OrderedDict()
					end
					madsdata["Expressions"][string("source", i, "_", sourceparam)] = OrderedCollections.OrderedDict{String,Any}()
					for pf in keys(madsdata["Sources"][i][sourcetype][sourceparam])
						madsdata["Expressions"][string("source", i, "_", sourceparam)][pf] = madsdata["Sources"][i][sourcetype][sourceparam][pf]
					end
				end
			end
		end
	end
end

"""
Copy aquifer parameters to become contaminant source parameters

$(DocumentFunction.documentfunction(copyaquifer2sourceparameters!;
argtext=Dict("madsdata"=>"MADS problem dictionary")))
"""
function copyaquifer2sourceparameters!(madsdata::AbstractDict)
	if haskey(madsdata, "Sources") && haskey(madsdata, "Parameters")
		for i = 1:length(madsdata["Sources"])
			for k in keys(madsdata["Sources"][i])
				for pkey in keys(madsdata["Parameters"])
					if !occursin("source", pkey)
						madsdata["Sources"][i][k][pkey] = deepcopy(madsdata["Parameters"][pkey])
					end
				end
			end
		end
		delete!(madsdata, "Parameters")
	end
end

"""
Remove contaminant source parameters

$(DocumentFunction.documentfunction(removesourceparameters!;
argtext=Dict("madsdata"=>"MADS problem dictionary")))
"""
function removesourceparameters!(madsdata::AbstractDict)
	if haskey(madsdata, "Sources")
		for i = 1:length(madsdata["Sources"])
			sourcetype = collect(keys(madsdata["Sources"][i]))[1]
			sourceparams = keys(madsdata["Sources"][i][sourcetype])
			for sourceparam in sourceparams
				if !haskey(madsdata["Sources"][i][sourcetype][sourceparam], "exp")
					if haskey(madsdata["Parameters"], string("source", i, "_", sourceparam))
						delete!(madsdata["Parameters"], string("source", i, "_", sourceparam))
					end
				else
					if haskey(madsdata, "Expressions")
						if haskey(madsdata["Expressions"], string("source", i, "_", sourceparam))
							delete!(madsdata["Expressions"], string("source", i, "_", sourceparam))
						end
					end
				end
			end
		end
	end
end

"""
Create a function to compute concentrations for all the observation points using Anasol

$(DocumentFunction.documentfunction(makecomputeconcentrations;
argtext=Dict("madsdata"=>"MADS problem dictionary"),
keytext=Dict("calczeroweightobs"=>"calculate zero weight observations[default=`false`]",
            "calcpredictions"=>"calculate zero weight predictions [default=`true`]")))

Returns:

- function to compute concentrations; the new function returns a dictionary of observations and model predicted concentrations

Examples:

```julia
computeconcentrations = Mads.makecomputeconcentrations(madsdata)
paramkeys = Mads.getparamkeys(madsdata)
paramdict = OrderedDict(zip(paramkeys, map(key->madsdata["Parameters"][key]["init"], paramkeys)))
forward_preds = computeconcentrations(paramdict)
```
"""
function makecomputeconcentrations(madsdata::AbstractDict; calczeroweightobs::Bool=false, calcpredictions::Bool=true)
	disp_tied = Mads.haskeyword(madsdata, "disp_tied")
	background = haskeyword(madsdata, "background") ? madsdata["Problem"]["background"] : 0.
	parametersnoexpressions = Mads.getparamdict(madsdata)
	parameters = evaluatemadsexpressions(madsdata, parametersnoexpressions)
	paramkeys = collect(keys(parameters))
	ts_dsp = haskey(parameters, "ts_dsp") ? parameters["ts_dsp"] : 1.
	H = haskey(parameters, "H") ? parameters["H"] : 0.5
	if (ts_dsp == 1. && !Mads.isopt(madsdata, "ts_dsp")) && (H == 0.5 && !Mads.isopt(madsdata, "H"))
		anasolfunctionroot = "long_bbb_"
	else
		anasolfunctionroot = "long_fff_"
	end
	numberofsources = length(madsdata["Sources"])
	anasolfunctions = Array{Function}(undef, numberofsources)
	anasolallparametersrequired = anasolparametersrequired
	anasolallparametersall = anasolparametersall
	for i = 1:numberofsources
		for p in anasolsourcerequired
			pn = string("source", i, "_", p)
			anasolallparametersrequired = [anasolallparametersrequired; pn]
			anasolallparametersall = [anasolallparametersall; pn]
		end
		if haskey(madsdata["Sources"][i], "box")
			anasolfunction = anasolfunctionroot * "bbb_iir_c"
		elseif haskey(madsdata["Sources"][i], "gauss" )
			anasolfunction = anasolfunctionroot * "ddd_iir_c"
		end
		anasolfunctions[i] = Core.eval(Mads, Meta.parse("Anasol.$anasolfunction"))
	end
	if length(findall((in)(paramkeys), anasolallparametersrequired)) < length(anasolallparametersrequired)
		missingparameters = anasolallparametersrequired[indexin(anasolallparametersrequired, paramkeys).==0]
		anasolallparametersrequired = Array{String}(undef, 0)
		anasolallparametersall = Array{String}(undef, 0)
		for i = 1:numberofsources
			for p in [anasolparametersrequired; anasolsourcerequired]
				pn = string("source", i, "_", p)
				anasolallparametersrequired = [anasolallparametersrequired; pn]
				anasolallparametersall = [anasolallparametersall; pn]
			end
		end
		if length(findall((in)(paramkeys), anasolallparametersrequired)) < length(anasolallparametersrequired)
			Mads.madswarn("There are missing Anasol parameters!")
			Mads.madswarn("Missing parameters: $(missingparameters)")
			Mads.madswarn("Missing source parameters: $(anasolallparametersrequired[indexin(anasolallparametersrequired, paramkeys).==0])")
			Mads.madscritical("Mads quits!")
		end
	end
	nW = 0
	for wellkey in Mads.getwellkeys(madsdata)
		if madsdata["Wells"][wellkey]["on"]
			nW += 1
		end
	end
	wellx = Array{Float64}(undef, nW)
	welly = Array{Float64}(undef, nW)
	wellz0 = Array{Float64}(undef, nW)
	wellz1 = Array{Float64}(undef, nW)
	wellscreen = Array{Bool}(undef, nW)
	wellnO = Array{Int}(undef, nW)
	wellt = Array{Array{Float64}}(undef, nW)
	wellp = Array{Array{Bool}}(undef, nW)
	wellc = Array{Array{Float64}}(undef, nW)
	wellkeys = Array{String}(undef, 0)
	w = 0
	for wellkey in Mads.getwellkeys(madsdata)
		if madsdata["Wells"][wellkey]["on"]
			w += 1
			wellx[w] = madsdata["Wells"][wellkey]["x"]
			welly[w] = madsdata["Wells"][wellkey]["y"]
			wellz0[w] = madsdata["Wells"][wellkey]["z0"]
			wellz1[w] = madsdata["Wells"][wellkey]["z1"]
			if abs(wellz1[w]  - wellz0[w] ) > 0.1
				wellscreen[w] = true
			else
				wellz0[w]  = (wellz1[w]  + wellz0[w] ) / 2
				wellscreen[w] = false
			end
			obst = Array{Float64}(undef, 0)
			obsp = Array{Int}(undef, 0)
			if haskey(madsdata["Wells"][wellkey], "obs") && madsdata["Wells"][wellkey]["obs"] != nothing
				nO = length(madsdata["Wells"][wellkey]["obs"])
			else
				nO = 0
			end
			wellc[w] = Array{Float64}(undef, nO)
			wellp[w] = Array{Bool}(undef, nO)
			for o in 1:nO
				t = madsdata["Wells"][wellkey]["obs"][o]["t"]
				if calczeroweightobs || (haskey(madsdata["Wells"][wellkey]["obs"][o], "weight") && madsdata["Wells"][wellkey]["obs"][o]["weight"] > 0) || (calcpredictions && haskey(madsdata["Wells"][wellkey]["obs"][o], "type") && madsdata["Wells"][wellkey]["obs"][o]["type"] == "prediction")
					push!(obst, t)
					wellp[w][o] = true
				else
					wellp[w][o] = false
				end
				push!(wellkeys, string(wellkey, "_", t))
			end
			wellt[w] = obst
			wellc[w][.!wellp[w]] .= 0
			end
	end
	classical = haskey(madsdata["Parameters"], "vx")
	# indexall = indexin(anasolallparametersall, paramkeys)
	function computeconcentrations()
		paramdict = Mads.getparamdict(madsdata)
		parameterswithexpressions = evaluatemadsexpressions(madsdata, paramdict)
		computeconcentrations(parameterswithexpressions)
	end
	function computeconcentrations(parameters::Vector)
		paramdict = Mads.getparamdict(madsdata)
		nP = length(paramdict)
		if length(parameters) == nP
			i = 1
			for k in keys(paramdict)
				paramdict[k] = parameters[i]
				i += 1
			end
		else
			optkeys = Mads.getoptparamkeys(madsdata)
			if length(parameters) == length(optkeys)
				i = 1
				for k in optkeys
					paramdict[k] = parameters[i]
					i += 1
				end
			else
				Mads.madscritical("Parameter vector length does not match!")
			end
		end
		parameterswithexpressions = evaluatemadsexpressions(madsdata, paramdict)
		computeconcentrations(parameterswithexpressions)
	end
	function computeconcentrations(parametersnoexpressions::AbstractDict)
		parameters = evaluatemadsexpressions(madsdata, parametersnoexpressions)
		if classical
			porosity = parameters["n"]
			lambda = parameters["lambda"]
			theta = parameters["theta"]
			vx = parameters["vx"]
			vy = parameters["vy"]
			vz = parameters["vz"]
			ax = parameters["ax"]
			if disp_tied
				ay = ax / parameters["ay"]
				az = ay / parameters["az"]
			else
				ay = parameters["ay"]
				az = parameters["az"]
			end
			if haskey(parameters, "rf")
				rf = parameters["rf"]; vx /= rf; vy /= rf; vz /= rf
			end
			if haskey(parameters, "H")
				H = parameters["H"]
			elseif haskey(parameters, "ts_dsp")
				H = 0.5 * parameters["ts_dsp"]
			else
				H = 0.5
			end
		end
		for w_ in 1:nW
			global w = w_
			wellc[w] .= background
		end
		for i=1:numberofsources
			ss = string("source", i, "_")
			x = parameters[string(ss, "x")]
			y = parameters[string(ss, "y")]
			z = parameters[string(ss, "z")]
			dx = parameters[string(ss, "dx")]
			dy = parameters[string(ss, "dy")]
			dz = parameters[string(ss, "dz")]
			f = parameters[string(ss, "f")]
			t0 = parameters[string(ss, "t0")]
			t1 = parameters[string(ss, "t1")]
			if !classical
				porosity = parameters[string(ss, "n")]
				lambda = parameters[string(ss, "lambda")]
				theta = parameters[string(ss, "theta")]
				vx = parameters[string(ss, "vx")]
				vy = parameters[string(ss, "vy")]
				vz = parameters[string(ss, "vz")]
				ax = parameters[string(ss, "ax")]
				if disp_tied
					ay = ax / parameters[string(ss, "ay")]
					az = ay / parameters[string(ss, "az")]
				else
					ay = parameters[string(ss, "ay")]
					az = parameters[string(ss, "az")]
				end
				if haskey(parameters, string(ss, "rf"))
					rf = parameters[string(ss, "rf")]; vx /= rf; vy /= rf; vz /= rf
				end
				if haskey(parameters, string(ss, "H"))
					H = parameters[string(ss, "H")]
				elseif haskey(parameters, string(ss, "ts_dsp"))
					H = 0.5 * parameters[string(ss, "ts_dsp")]
				else
					H = 0.5
				end
			end
			for w_ in 1:nW
				global w = w_
				if wellscreen[w]
					wellc[w][wellp[w]] += (contamination(wellx[w], welly[w], wellz0[w], porosity, lambda, theta, vx, vy, vz, ax, ay, az, H, x, y, z, dx, dy, dz, f, t0, t1, wellt[w], anasolfunctions[i]) +
					             contamination(wellx[w], welly[w], wellz1[w], porosity, lambda, theta, vx, vy, vz, ax, ay, az, H, x, y, z, dx, dy, dz, f, t0, t1, wellt[w], anasolfunctions[i])) * 0.5
				else
					wellc[w][wellp[w]] += contamination(wellx[w], welly[w], wellz0[w], porosity, lambda, theta, vx, vy, vz, ax, ay, az, H, x, y, z, dx, dy, dz, f, t0, t1, wellt[w], anasolfunctions[i])
				end
			end
		end
		global modelruns += 1
		return OrderedCollections.OrderedDict{String,Float64}(zip(wellkeys, vcat(wellc...)))
	end
	return computeconcentrations
end

"""
Compute concentration for a point in space and time (x,y,z,t)

$(DocumentFunction.documentfunction(contamination;
argtext=Dict("wellx"=>"observation point (well) X coordinate",
            "welly"=>"observation point (well) Y coordinate",
            "wellz"=>"observation point (well) Z coordinate",
            "n"=>"porosity",
            "lambda"=>"first-order reaction rate",
            "theta"=>"groundwater flow direction",
            "vx"=>"advective transport velocity in X direction",
            "vy"=>"advective transport velocity in Y direction",
            "vz"=>"advective transport velocity in Z direction",
            "ax"=>"dispersivity in X direction (longitudinal)",
            "ay"=>"dispersivity in Y direction (transverse horizontal)",
            "az"=>"dispersivity in Y direction (transverse vertical)",
            "H"=>"Hurst coefficient for Fractional Brownian dispersion",
            "x"=>"X coordinate of contaminant source location",
            "y"=>"Y coordinate of contaminant source location",
            "z"=>"Z coordinate of contaminant source location",
            "dx"=>"source size (extent) in X direction",
            "dy"=>"source size (extent) in Y direction",
            "dz"=>"source size (extent) in Z direction",
            "f"=>"source mass flux",
            "t0"=>"source starting time",
            "t1"=>"source termination time",
            "t"=>"vector of times to compute concentration at the observation point"),
keytext=Dict("anasolfunction"=>"Anasol function to call (check out the Anasol module) [default=`\"long_bbb_ddd_iir_c\"`]")))

Returns:

- a vector of predicted concentration at (wellx, welly, wellz, t)
"""
function contamination(wellx::Number, welly::Number, wellz::Number, n::Number, lambda::Number, theta::Number, vx::Number, vy::Number, vz::Number, ax::Number, ay::Number, az::Number, H::Number, x::Number, y::Number, z::Number, dx::Number, dy::Number, dz::Number, f::Number, t0::Number, t1::Number, t::Vector, anasolfunction::Function)
	d = -theta * pi / 180
	xshift = wellx - x
	yshift = welly - y
	ztrans = wellz - z
	xtrans = xshift * cos(d) - yshift * sin(d)
	ytrans = xshift * sin(d) + yshift * cos(d)
	x01 = x02 = x03 = 0. # we transformed the coordinates so the source starts at the origin
	#sigma01 = sigma02 = sigma03 = 0. #point source
	sigma01 = dx
	sigma02 = dy
	sigma03 = dz
	v1 = vx
	v2 = vy
	v3 = vz
	twospeed = 2 * sqrt(vx * vx + vy * vy + vz * vz)
	sigma1 = sqrt(ax * twospeed)
	sigma2 = sqrt(ay * twospeed)
	sigma3 = sqrt(az * twospeed)
	H1 = H2 = H3 = H
	xb1 = xb2 = xb3 = 0. # xb1 and xb2 will be ignored, xb3 should be set to 0 (reflecting boundary at z=0)
	nt = length(t)
	xtransvec = [xtrans, ytrans, ztrans]
	anasolresult = Vector{Float64}(undef, nt)
	for i = 1:nt
		anasolresult[i] = 1e6 * f / n * anasolfunction(xtransvec, t[i], x01, sigma01, v1, sigma1, H1, xb1, x02, sigma02, v2, sigma2, H2, xb2, x03, sigma03, v3, sigma3, H3, xb3, lambda, t0, t1)
	end
	return anasolresult
end

function computemass(madsdata::AbstractDict; time::Number=0)
	if time == 0
		grid_time = (haskey(madsdata, "Grid") && haskey(madsdata["Grid"], "time")) ? madsdata["Grid"]["time"] : 0
		time = grid_time > 0 ? grid_time : 0
	end
	parameters = madsdata["Parameters"]
	lambda = parameters["lambda"]["init"]
	compute_reduction = lambda > eps(Float64) ? true : false
	mr = 0
	mass_injected = 0
	mass_reduced = 0
	for i = 1:length(madsdata["Sources"])
		f = parameters[string("source", i, "_", "f")]["init"]
		t0 = parameters[string("source", i, "_", "t0")]["init"]
		t1 = parameters[string("source", i, "_", "t1")]["init"]
		if time > t0
			tmin = min(time, t1)
			mi = f * (tmin - t0)
			if compute_reduction
				mr = mi - (f * exp(-(time - t0) * lambda) * (exp((tmin - t0) * lambda)-1))/lambda
			end
			mass_injected += mi
			mass_reduced += mr
		end
	end
	return mass_injected, mass_reduced
end
function computemass(madsfiles::Union{Regex,String}; time::Number=0, path::String=".")
	mf = searchdir(madsfiles, path=path)
	nf = length(mf)
	Mads.madsinfo("Number of files = $nf")
	lambda = Array{Float64}(undef, nf)
	mass_injected = Array{Float64}(undef, nf)
	mass_reduced = Array{Float64}(undef, nf)
	@ProgressMeter.showprogress 1 "Computing reduced mass ..." for i = 1:nf
		md = Mads.loadmadsfile(joinpath(path, mf[i]))
		l = md["Parameters"]["lambda"]["init"]
		lambda[i] = l < eps(Float64) ? 1e-32 : l
		mi, mr = Mads.computemass(md, time=time)
		mass_injected[i] = Float64(mi)
		mass_reduced[i] = Float64(mi)
	end
	if Mads.graphoutput && isdefined(Mads, :plotmass)
		plotmass(lambda, mass_injected, mass_reduced, joinpath(path, "mass_reduced"))
	end
	return lambda, mass_injected, mass_reduced
end

@doc """
Compute injected/reduced contaminant mass (for a given set of mads input files when "path" is provided)

$(DocumentFunction.documentfunction(computemass;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "madsfiles"=>"matching pattern for Mads input files (string or regular expression accepted)"),
keytext=Dict("time"=>"computational time [default=`0`]",
            "path"=>"search directory for the mads input files [default=`\".\"`]")))

Returns:

- array with all the lambda values
- array with associated total injected mass
- array with associated total reduced mass

Example:

```julia
Mads.computemass(madsfiles; time=0, path=".")
```
""" computemass
