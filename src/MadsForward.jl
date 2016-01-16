"Make a version of the mads file where the targets are given by the model predictions"
function maketruth(infilename::AbstractString, outfilename::AbstractString)
	md = loadmadsfile(infilename)
	f = makemadscommandfunction(md)
	result = f(Dict(zip(getparamkeys(md), getparamsinit(md))))
	outyaml = loadyamlfile(infilename)
	if haskey(outyaml, "Observations")
		for fullobs in outyaml["Observations"]
			obskey = collect(keys(fullobs))[1]
			obs = fullobs[obskey]
			obs["target"] = result[obskey]
		end
	end
	if haskey(outyaml, "Wells")
		for fullwell in outyaml["Wells"]
			wellname = collect(keys(fullwell))[1]
			for fullobs in fullwell[wellname]["obs"]
				obskey = collect(keys(fullobs))[1]
				obs = fullobs[obskey]
				obs["target"] = result[string(wellname, "_", obs["t"])]
			end
		end
	end
	dumpyamlfile(outfilename, outyaml)
end


"Do a forward run using the initial or provided values for the model parameters "
function forward(madsdata::Associative; paramvalues=Void)
	if paramvalues == Void
		paramvalues = Dict(zip(Mads.getparamkeys(madsdata), Mads.getparamsinit(madsdata)))
	end
	forward(madsdata, paramvalues)
end

"Do a forward run using provided values for the model parameters "
function forward(madsdata::Associative, paramvalues)
	f = Mads.makemadscommandfunction(madsdata)
	return f(paramvalues)
end

"Do a forward run over a 3D grid using the initial or provided values for the model parameters "
function forwardgrid(madsdata::Associative; paramvalues=Void)
	if paramvalues == Void
		paramvalues = Dict(zip(Mads.getparamkeys(madsdata), Mads.getparamsinit(madsdata)))
	end
	forwardgrid(madsdata, paramvalues)
end

"Do a forward run over a 3D grid using provided values for the model parameters "
function forwardgrid(madsdatain::Associative, paramvalues)
	madsdata = copy(madsdatain)
	f = Mads.makemadscommandfunction(madsdata)
	nx = madsdata["Grid"]["xcount"]
	ny = madsdata["Grid"]["ycount"]
	nz = madsdata["Grid"]["zcount"]
	xmin = madsdata["Grid"]["xmin"]
	ymin = madsdata["Grid"]["ymin"]
	zmin = madsdata["Grid"]["zmin"]
	xmax = madsdata["Grid"]["xmax"]
	ymax = madsdata["Grid"]["ymax"]
	zmax = madsdata["Grid"]["zmax"]
	time = madsdata["Grid"]["time"]
	if nx == 1
		dx = 0
	else
		dx = ( xmax - xmin ) / ( nx - 1 )
	end
	if ny == 1
		dy = 0
	else
		dy = ( ymax - ymin ) / ( ny - 1 )
	end
	if nz == 1
		dz = 0
	else
		dz = ( zmax - zmin ) / ( nz - 1 )
	end
	x = xmin
	dictwells = Dict()
	for i in 1:nx
		x += dx
		y = ymin
		for j in 1:ny
			y += dy
			z = zmin
			for k in 1:nz
				z += dz
				wellname = "w_$(i)_$(j)_$(k)"
				dictwells[wellname] = Dict()
				dictwells[wellname]["x"] = x
				dictwells[wellname]["y"] = y
				dictwells[wellname]["z0"] = z
				dictwells[wellname]["z1"] = z
				dictwells[wellname]["on"] = true
				arrayobs = Array(Dict, 0)
				dictobs = Dict()
				dictobs["t"] = time
				dictobs["c"] = 0
				dictobs["weight"] = 1
				push!(arrayobs, dictobs)
				dictwells[wellname]["obs"] = arrayobs
			end
		end
	end
	madsdata["Wells"] = dictwells
	Mads.wells2observations!(madsdata)
	forward_results = f(paramvalues)
	s = Array(Float64, nx, ny, nz)
	for i in 1:nx
		for j in 1:ny
			for k in 1:nz
				obsname = "w_$(i)_$(j)_$(k)_$(time)"
				s[i, j, k] = forward_results[obsname]
			end
		end
	end
	return s
end