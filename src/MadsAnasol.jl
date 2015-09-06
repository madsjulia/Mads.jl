import Anasol

@doc "Compute concentration for a point (x,y,z,t)" ->
function contamination(wellx, welly, wellz, n, lambda, theta, vx, vy, vz, ax, ay, az, H, x, y, z, dx, dy, dz, f, t0, t1, t, usefff)
	d = -theta * pi / 180
	xshift = wellx - x
	yshift = welly - y
	ztrans = wellz - z
	xtrans = xshift * cos(d) - yshift * sin(d)
	ytrans = xshift * sin(d) + yshift * cos(d)
	x01 = x02 = x03 = 0. # we transformed the coordinates so the source starts at the origin
	#sigma01 = sigma02 = sigma03 = 0.#point source
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
	if usefff
		anasolresult = Anasol.long_fff_ddd_iir_c([xtrans, ytrans, ztrans], t, x01, sigma01, v1, sigma1, H1, xb1, x02, sigma02, v2, sigma2, H2, xb2, x03, sigma03, v3, sigma3, H3, xb3, lambda, t0, t1)
	else
		anasolresult = Anasol.long_bbb_ddd_iir_c([xtrans, ytrans, ztrans], t, x01, sigma01, v1, sigma1, H1, xb1, x02, sigma02, v2, sigma2, H2, xb2, x03, sigma03, v3, sigma3, H3, xb3, lambda, t0, t1)
	end
	return 1e6 * f * anasolresult / n
end

@doc "Compute concentration for all observation points" ->
function makecomputeconcentrations(madsdata)
	function computeconcentrations(parameters)
		porosity = parameters["n"]
		lambda = parameters["lambda"]
		theta = parameters["theta"]
		vx = parameters["vx"]
		vy = parameters["vy"]
		vz = parameters["vz"]
		ax = parameters["ax"]
		ay = parameters["ay"]
		az = parameters["az"]
		if haskey(parameters, "ts_dsp") && parameters["ts_dsp"] != 1.
			usefff = true
			H = 0.5 * parameters["ts_dsp"]
		else
			H = 0.5
			usefff = false
		end
		c = DataStructures.OrderedDict()
		for wellkey in Mads.getwellkeys(madsdata)
			wellx = madsdata["Wells"][wellkey]["x"]
			welly = madsdata["Wells"][wellkey]["y"]
			wellz0 = madsdata["Wells"][wellkey]["z0"]
			wellz1 = madsdata["Wells"][wellkey]["z1"]
			for i in 1:length(madsdata["Wells"][wellkey]["obs"])
				t = madsdata["Wells"][wellkey]["obs"][i][i]["t"]
				for i = 1:length(madsdata["Sources"]) # TODO check what is the source type (box, point, etc) and implement different soluion depending on the source type
					x = parameters[string("source", i, "_", "x")]
					y = parameters[string("source", i, "_", "y")]
					z = parameters[string("source", i, "_", "z")]
					dx = parameters[string("source", i, "_", "dx")]
					dy = parameters[string("source", i, "_", "dy")]
					dz = parameters[string("source", i, "_", "dz")]
					f = parameters[string("source", i, "_", "f")]
					t0 = parameters[string("source", i, "_", "t0")]
					t1 = parameters[string("source", i, "_", "t1")]
					if i == 1
						c[string(wellkey, "_", t)] = .5 * (contamination(wellx, welly, wellz0, porosity, lambda, theta, vx, vy, vz, ax, ay, az, H, x, y, z, dx, dy, dz, f, t0, t1, t, usefff) + contamination(wellx, welly, wellz1, porosity, lambda, theta, vx, vy, vz, ax, ay, az, H, x, y, z, dx, dy, dz, f, t0, t1, t, usefff))
					else
						c[string(wellkey, "_", t)] += .5 * (contamination(wellx, welly, wellz0, porosity, lambda, theta, vx, vy, vz, ax, ay, az, H, x, y, z, dx, dy, dz, f, t0, t1, t, usefff) + contamination(wellx, welly, wellz1, porosity, lambda, theta, vx, vy, vz, ax, ay, az, H, x, y, z, dx, dy, dz, f, t0, t1, t, usefff))
					end
				end
				# c[t] = contamination(wellx, welly, .5 * (wellz0 + wellz1), n, lambda, theta, vx, vy, vz, ax, ay, az, x, y, z, dx, dy, dz, f, t0, t1, t)
			end
		end
		global modelruns += 1
		return c
	end
	return computeconcentrations
end
