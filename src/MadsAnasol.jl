import Anasol

@doc "Compute concentration for a point (x,y,z,t)" ->
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

@doc "Compute concentration for all observation points" ->
function makecomputeconcentrations(madsdata::Associative)
	disp_tied = Mads.haskeyword(madsdata, "disp_tied")
	background = 0
	if haskeyword(madsdata, "background")
			background = madsdata["Problem"]["background"]
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
					#if madsdata["Wells"][wellkey]["obs"][o]["weight"] > eps(Float64)
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
					#else
					#	c[string(wellkey, "_", t)] = 0
					#end
				end
			end
		end
		global modelruns += 1
		return c
	end
	return computeconcentrations
end

@doc "Compute injected/reduced contaminant mass" ->
function computemass(madsdata::Associative; time = 0)
	if time == 0
		grid_time = madsdata["Grid"]["time"]
		if grid_time > 0
			time = grid_time
		end
	end
	parameters = madsdata["Parameters"]
	lambda = parameters["lambda"]["init"]	
	if lambda > eps(Float64)
		compute_reduction = true
	else
		mr = 0
		compute_reduction = false
	end
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
				mr = (f * exp(-(time - t0) * lambda) * (exp((tmin - t0) * lambda)-1))/lambda
			else
				mr = mi
			end
			@show t0, t1, tmin, mi, mr
			mass_injected += mi
			mass_reduced += mr
		end
	end
	return mass_injected, mass_reduced
end

function computemass(madsfiles; time = 0, path = ".")
	mf = searchdir(madsfiles)
	nf = length(mf)
	lambda = Array(Float64, 0)
	mass_injected = Array(Float64, 0)
	mass_reduced = Array(Float64, 0)
	for i = 1:nf
		md = Mads.loadyamlmadsfile(mf[i])
		l = md["Parameters"]["lambda"]["init"]
		if l < eps(Float64)
			l = 1e-32
		end
		push!(lambda, l)
		mi, mr = Mads.computemass(md)
		push!(mass_injected, mi)
		push!(mass_reduced, mr)
	end
	return lambda, mass_injected, mass_reduced
end
