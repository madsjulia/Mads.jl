"""
Perform a forward run using the initial or provided values for the model parameters

- `forward(madsdata)`
- `forward(madsdata, paramvalues)`

Arguments:

- `madsdata` : MADS problem dictionary
- `paramvalues` : dictionary of model parameter values

Returns:

- `obsvalues` : dictionary of model predictions
"""
function forward(madsdata::Associative; all=false)
	paramvalues = Dict(zip(Mads.getparamkeys(madsdata), Mads.getparamsinit(madsdata)))
	forward(madsdata, paramvalues; all=all)
end

function forward(madsdata::Associative, paramvalues::Associative; all=false)
	if all
		madsdata_c = deepcopy(madsdata)
		if haskey(madsdata_c, "Wells")
			setwellweights!(madsdata_c, 1)
		elseif haskey(madsdata_c, "Observations")
			setobsweights!(madsdata_c, 1)
		end
		f = makemadscommandfunction(madsdata_c)
	else
		f = makemadscommandfunction(madsdata)
	end
	return f(paramvalues)
end

function forward(madsdata::Associative, paramvalues::Array; all=false)
	madsdata_c = deepcopy(madsdata)
	if all
		if haskey(madsdata_c, "Wells")
			setwellweights!(madsdata_c, 1)
		elseif haskey(madsdata_c, "Observations")
			setobsweights!(madsdata_c, 1)
		end
	end
	f = makemadscommandfunction(madsdata_c)
	pk = Mads.getoptparamkeys(madsdata_c)
	np = length(pk)
	s = size(paramvalues)
	if length(s) > 2
		madswarn("Incorrect array size: size(paramvalues) = $(size(paramvalues))")
		return
	elseif length(s) == 2	
		mx = max(s...)
		mn = min(s...)
	else
		mx = s[1]
		mn = 1
	end
	if mn != np && mx != np
		madswarn("Incorrect array size: size(paramvalues) = $(size(paramvalues))")
		return
	end
	nr = (mn == np) ? mx : mn
	r = []
	for i = 1:nr
		if length(s) == 2
			if s[2] == np
				pd = DataStructures.OrderedDict(zip(pk, map(j->paramvalues[i,j], 1:np)))
			else
				pd = DataStructures.OrderedDict(zip(pk, map(j->paramvalues[j,i], 1:np)))
			end
		else
			pd = DataStructures.OrderedDict(zip(pk, map(j->paramvalues[j], 1:np)))
		end
		@show pd
		o = f(pd)
		push!(r, o)
	end
	return r
end

"""
Perform a forward run over a 3D grid defined in `madsdata` using the initial or provided values for the model parameters

- `forwardgrid(madsdata)`  
- `forwardgrid(madsdata, paramvalues))`

Arguments:

- `madsdata` : MADS problem dictionary
- `paramvalues` : dictionary of model parameter values

Returns:

- `array3d` : 3D array with model predictions along a 3D grid
"""
function forwardgrid(madsdata::Associative)
	paramvalues = Dict(zip(Mads.getparamkeys(madsdata), Mads.getparamsinit(madsdata)))
	forwardgrid(madsdata, paramvalues)
end

function forwardgrid(madsdatain::Associative, paramvalues::Associative)
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