import ProgressMeter
import DataStructures
import JLD
import DocumentFunction

function forward(madsdata::Associative; all::Bool=false)
	paramdict = Mads.getparamdict(madsdata)
	forward(madsdata, paramdict; all=all)
end
function forward(madsdata::Associative, paramvector::Vector; all::Bool=false, checkpointfrequency::Integer=0, checkpointfilename::String="checkpoint_forward")
	if length(paramvector) == 0
		return forward(madsdata; all=all)
	end
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
	f(paramvector)
end
function forward(madsdata::Associative, paramdict::Associative; all::Bool=false, checkpointfrequency::Integer=0, checkpointfilename::String="checkpoint_forward")
	if length(paramdict) == 0
		return forward(madsdata; all=all)
	end
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
	kk = collect(keys(paramdict))
	l = length(paramdict[kk[1]])
	for k = kk[2:end]
		l2 = length(paramdict[k])
		@assert l == l2
	end
	paraminitdict = Mads.getparamdict(madsdata)
	if l == 1
		p = merge(paraminitdict, paramdict)
		return convert(DataStructures.OrderedDict{Any,Float64}, f(p))
	else
		optkeys = Mads.getoptparamkeys(madsdata)
		if length(optkeys) == length(kk)
			paramarray = hcat(map(i->collect(paramdict[i]), optkeys)...)'
		else
		end
		return forward(madsdata, paramarray; all=all, checkpointfrequency=checkpointfrequency, checkpointfilename=checkpointfilename)
	end
end
function forward(madsdata::Associative, paramarray::Array; all::Bool=false, checkpointfrequency::Integer=0, checkpointfilename::String="checkpoint_forward")
	paramdict = Mads.getparamdict(madsdata)
	if sizeof(paramarray) == 0
		return forward(madsdata; all=all)
	end
	pk = Mads.getoptparamkeys(madsdata)
	np = length(pk)
	s = size(paramarray)
	if length(s) > 2
		error("Incorrect array size: size(paramarray) = $(size(paramarray))")
	elseif length(s) == 2
		nrow, ncol = s
		if nrow != np && ncol != np
			warn("Incorrect array size: size(paramarray) = $(size(paramarray))")
		elseif nrow == np
			np = nrow
			nr = ncol
			if ncol == np
				warn("Matrix columns assumed to represent the parameters!")
			end
		elseif nrcol == np
			np = ncol
			nr = nrow
		end
	else
		np = s[1]
		nr = 1
	end
	if all
		madsdata_c = deepcopy(madsdata)
		if haskey(madsdata_c, "Wells")
			setwellweights!(madsdata_c, 1)
		elseif haskey(madsdata_c, "Observations")
			setobsweights!(madsdata_c, 1)
		end
		f = makearrayfunction(madsdata_c)
	else
		f = makearrayfunction(madsdata)
	end
	local r
	if length(s) == 2
		local rv
		restartdir = getrestartdir(madsdata)
		if checkpointfrequency != 0 && restartdir != ""
			if s[2] == np
				rv = RobustPmap.crpmap(i->f(vec(paramarray[i, :])), checkpointfrequency, joinpath(restartdir, checkpointfilename), 1:nr)
			else
				rv = RobustPmap.crpmap(i->f(vec(paramarray[:, i])), checkpointfrequency, joinpath(restartdir, checkpointfilename), 1:nr)
			end
			r = hcat(collect(rv)...)
		else
			rv = Array{Array{Float64}}(nr)
			if s[2] == np
				# r = RobustPmap.rpmap(i->f(vec(paramarray[i, :])), 1:nr)
				for i = 1:nr
					rv[i] = collect(values(f(vec(paramarray[i, :]))))
				end
			else
				# r = RobustPmap.rpmap(i->f(vec(paramarray[:, i])), 1:nr)
				for i = 1:nr
					rv[i] = collect(values(f(vec(paramarray[:, i]))))
				end
			end
			r = hcat(rv...)
		end
	else
		r = f(paramarray)
	end
	return r
end

@doc """
Perform a forward run using the initial or provided values for the model parameters

$(DocumentFunction.documentfunction(forward;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "paramdict"=>"dictionary of model parameter values",
            "paramarray"=>"array of model parameter values"),
keytext=Dict("all"=>"all model results are returned [default=`false`]",
            "checkpointfrequency"=>"check point frequency for storing restart information [default=`0`]",
            "checkpointfilename"=>"check point file name [default=\"checkpoint_forward\"]")))

Returns:

- dictionary of model predictions
""" forward

function forwardgrid(madsdata::Associative)
	paramvalues = Mads.getparamdict(madsdata)
	forwardgrid(madsdata, paramvalues)
end

function forwardgrid(madsdatain::Associative, paramvalues::Associative)
	if !haskey(madsdatain, "Grid")
		madswarn("Grid properties are not defined in the Mads dictionary")
		return
	end
	madsdata = copy(madsdatain)
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
	dx = nx == 1 ? 0 : dx = ( xmax - xmin ) / ( nx - 1 )
	dy = ny == 1 ? 0 : dy = ( ymax - ymin ) / ( ny - 1 )
	dz = nz == 1 ? 0 : dz = ( zmax - zmin ) / ( nz - 1 )
	x = xmin
	dictwells = DataStructures.OrderedDict()
	for i in 1:nx
		x += dx
		y = ymin
		for j in 1:ny
			y += dy
			z = zmin
			for k in 1:nz
				z += dz
				wellname = "w_$(i)_$(j)_$(k)"
				dictwells[wellname] = DataStructures.OrderedDict()
				dictwells[wellname]["x"] = x
				dictwells[wellname]["y"] = y
				dictwells[wellname]["z0"] = z
				dictwells[wellname]["z1"] = z
				dictwells[wellname]["on"] = true
				arrayobs = Array{DataStructures.OrderedDict}(0)
				dictobs = DataStructures.OrderedDict()
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
	f = Mads.makemadscommandfunction(madsdata)
	forward_results = f(paramvalues)
	s = Array{Float64}(nx, ny, nz)
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

@doc """
Perform a forward run over a 3D grid defined in `madsdata` using the initial or provided values for the model parameters

$(DocumentFunction.documentfunction(forwardgrid;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "madsdatain"=>"MADS problem dictionary",
            "paramvalues"=>"dictionary of model parameter values")))

Returns:

- 3D array with model predictions along a 3D grid
""" forwardgrid
