import Anasol
import DataStructures
import ProgressMeter

"""
Create a function to compute concentrations for all the observation points using Anasol

`Mads.makecomputeconcentrations(madsdata)`

Arguments:

- `madsdata` : MADS problem dictionary

Returns:

- `computeconcentrations` : function to compute concentrations; `computeconcentrations` returns a dictionary of observations and model predicted concentrations

Examples:

`computeconcentrations()`

or

```
computeconcentrations = Mads.makecomputeconcentrations(madsdata)
paramkeys = Mads.getparamkeys(madsdata)
paramdict = OrderedDict(zip(paramkeys, map(key->madsdata["Parameters"][key]["init"], paramkeys)))
forward_preds = computeconcentrations(paramdict)
```
"""
function makecomputeconcentrations(madsdata::Associative; calczeroweightobs=false, calcpredictions=true)
	disp_tied = Mads.haskeyword(madsdata, "disp_tied")
	background = 0
	if haskeyword(madsdata, "background")
		background = madsdata["Problem"]["background"]
	end
	function computeconcentrations()
		paramkeys = Mads.getparamkeys(madsdata)
		paramdict = OrderedDict(zip(paramkeys, map(key->madsdata["Parameters"][key]["init"], paramkeys)))
		computeconcentrations(paramdict)
	end
	function computeconcentrations(parameters)
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
		if haskey(parameters, "ts_dsp") && parameters["ts_dsp"] != 1.
			H = 0.5 * parameters["ts_dsp"]
			anasolfunctionroot = "long_fff_"
		else
			H = 0.5
			anasolfunctionroot = "long_bbb_"
		end
		c = DataStructures.OrderedDict()
		for wellkey in Mads.getwellkeys(madsdata)
			if madsdata["Wells"][wellkey]["on"]
				wellx = madsdata["Wells"][wellkey]["x"]
				welly = madsdata["Wells"][wellkey]["y"]
				wellz0 = madsdata["Wells"][wellkey]["z0"]
				wellz1 = madsdata["Wells"][wellkey]["z1"]
				if abs( wellz1 - wellz0 ) > 0.1
					screen = true
				else
					wellz = (wellz1 + wellz0) / 2
					screen = false
				end
				for o in 1:length(madsdata["Wells"][wellkey]["obs"])
					t = madsdata["Wells"][wellkey]["obs"][o]["t"]
					if calczeroweightobs || (haskey(madsdata["Wells"][wellkey]["obs"][o], "weight") && madsdata["Wells"][wellkey]["obs"][o]["weight"] > 0) || (calcpredictions && haskey(madsdata["Wells"][wellkey]["obs"][o], "type") && madsdata["Wells"][wellkey]["obs"][o]["type"] == "prediction")
						conc = background
						for i = 1:length(madsdata["Sources"]) # TODO check what is the source type (box, point, etc) and implement different soluion depending on the source type
							if haskey( madsdata["Sources"][i], "box" )
								anasolfunction = anasolfunctionroot * "bbb_iir_c"
							elseif haskey( madsdata["Sources"][i], "gauss" )
								anasolfunction = anasolfunctionroot * "ddd_iir_c"
							end
							x = parameters[string("source", i, "_", "x")]
							y = parameters[string("source", i, "_", "y")]
							z = parameters[string("source", i, "_", "z")]
							dx = parameters[string("source", i, "_", "dx")]
							dy = parameters[string("source", i, "_", "dy")]
							dz = parameters[string("source", i, "_", "dz")]
							f = parameters[string("source", i, "_", "f")]
							t0 = parameters[string("source", i, "_", "t0")]
							t1 = parameters[string("source", i, "_", "t1")]
							if screen
								conc += .5 * (contamination(wellx, welly, wellz0, porosity, lambda, theta, vx, vy, vz, ax, ay, az, H, x, y, z, dx, dy, dz, f, t0, t1, t; anasolfunction=anasolfunction) +
								              contamination(wellx, welly, wellz1, porosity, lambda, theta, vx, vy, vz, ax, ay, az, H, x, y, z, dx, dy, dz, f, t0, t1, t; anasolfunction=anasolfunction))
							else
								conc += contamination(wellx, welly, wellz, porosity, lambda, theta, vx, vy, vz, ax, ay, az, H, x, y, z, dx, dy, dz, f, t0, t1, t; anasolfunction=anasolfunction)
							end
						end
						c[string(wellkey, "_", t)] = conc
					else
						c[string(wellkey, "_", t)] = 0
					end
				end
			end
		end
		global modelruns += 1
		return c
	end
	return computeconcentrations
end

"""
Compute concentration for a point in space and time (x,y,z,t)

`Mads.contamination(wellx, welly, wellz, n, lambda, theta, vx, vy, vz, ax, ay, az, H, x, y, z, dx, dy, dz, f, t0, t1, t; anasolfunction="long_bbb_ddd_iir_c")`

Arguments:

- `wellx` - observation point (well) X coordinate
- `welly` - observation point (well) Y coordinate
- `wellz` - observation point (well) Z coordinate
- `n` - porosity
- `lambda` - first-order reaction rate
- `theta` - groundwater flow direction
- `vx` - advective transport velocity in X direction
- `vy` - advective transport velocity in Y direction
- `vz` - advective transport velocity in Z direction
- `ax` - dispersivity in X direction (longitudinal)
- `ay` - dispersivity in Y direction (transverse horizontal)
- `az` - dispersivity in Y direction (transverse vertical)
- `H` - Hurst coefficient for Fractional Brownian dispersion
- `x` - X coordinate of contaminant source location 
- `y` - Y coordinate of contaminant source location
- `z` - Z coordinate of contaminant source location
- `dx` - source size (extent) in X direction
- `dy` - source size (extent) in Y direction
- `dz` - source size (extent) in Z direction
- `f` - source mass flux
- `t0` - source starting time
- `t1` - source termination time
- `t` - time to compute concentration at the observation point
- `anasolfunction` : Anasol function to call (check out the Anasol module) [long_bbb_ddd_iir_c]

Returns:

- predicted concentration at (wellx, welly, wellz, t)
"""
function contamination(wellx, welly, wellz, n, lambda, theta, vx, vy, vz, ax, ay, az, H, x, y, z, dx, dy, dz, f, t0, t1, t; anasolfunction="long_bbb_ddd_iir_c")
	anasolfunction = eval(parse("Anasol.$anasolfunction"))
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
	speed = sqrt(vx * vx + vy * vy + vz * vz)
	sigma1 = sqrt(ax * speed * 2)
	sigma2 = sqrt(ay * speed * 2)
	sigma3 = sqrt(az * speed * 2)
	H1 = H2 = H3 = H
	xb1 = xb2 = xb3 = 0. # xb1 and xb2 will be ignored, xb3 should be set to 0 (reflecting boundary at z=0)
	anasolresult = anasolfunction([xtrans, ytrans, ztrans], t, x01, sigma01, v1, sigma1, H1, xb1, x02, sigma02, v2, sigma2, H2, xb2, x03, sigma03, v3, sigma3, H3, xb3, lambda, t0, t1)
	return 1e6 * f * anasolresult / n
end

"""
Compute injected/reduced contaminant mass

`Mads.computemass(madsdata; time = 0)`

Arguments:

- `madsdata` : MADS problem dictionary
- `time` : computational time

Returns:

- `mass_injected` : total injected mass
- `mass_reduced` : total reduced mass
"""
function computemass(madsdata::Associative; time = 0)
	if time == 0
		grid_time = madsdata["Grid"]["time"]
		if grid_time > 0
			time = grid_time
		end
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
		#=
		if i == 1
			f = 10
			t0 = 1960
			t1 = 1963
		else
			f = 10
			t0 = 2010
			t1 = 2100
		end
		=#
		if time > t0
			tmin = min(time, t1)
			mi = f * (tmin - t0)
			if compute_reduction
				mr = mi - (f * exp(-(time - t0) * lambda) * (exp((tmin - t0) * lambda)-1))/lambda
			end
			# @show t0, t1, tmin, mi, mr
			mass_injected += mi
			mass_reduced += mr
		end
	end
	return mass_injected, mass_reduced
end

"""
Compute injected/reduced contaminant mass for a given set of mads input files

`Mads.computemass(madsfiles; time = 0, path = ".")`

Arguments:

- `madsfiles` : matching pattern for Mads input files (string or regular expression accepted)
- `time` : computational time
- `path` : search directory for the mads input files 

Returns:

- `lambda` : array with all the lambda values
- `mass_injected` : array with associated total injected mass
- `mass_reduced` : array with associated total reduced mass
"""
function computemass(madsfiles; time = 0, path = ".")
	mf = searchdir(madsfiles, path=path)
	nf = length(mf)
	Mads.madsinfo("""Number of files = $nf""")
	lambda = Array(Float64, nf)
	mass_injected = Array(Float64, nf)
	mass_reduced = Array(Float64, nf)
	@ProgressMeter.showprogress 1 "Computing reducted mass ..." for i = 1:nf
		md = Mads.loadmadsfile(path * "/" * mf[i])
		l = md["Parameters"]["lambda"]["init"]
		if l < eps(Float64)
			l = 1e-32
		end
		lambda[i] = l
		mi, mr = Mads.computemass(md, time=time)
		mass_injected[i] = mi
		mass_reduced[i] = mr
	end
	plotmass(lambda, mass_injected, mass_reduced, path * "/mass_reduced")
	return lambda, mass_injected, mass_reduced
end