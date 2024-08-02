import ProgressMeter
import OrderedCollections
import DocumentFunction
import DelimitedFiles
import Distributed
import SharedArrays

function forward(madsdata::AbstractDict; all::Bool=false)
	paramdict = Mads.getparamdict(madsdata)
	forward(madsdata, paramdict; all=all)
end
function forward(madsdata::AbstractDict, paramdict::AbstractDict; all::Bool=false, checkpointfrequency::Integer=0, checkpointfilename::AbstractString="checkpoint_forward")
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
	else
		madsdata_c = madsdata
	end
	f = makemadscommandfunction(madsdata_c)
	kk = collect(keys(paramdict))
	l = length(paramdict[kk[1]])
	for k = kk[2:end]
		l2 = length(paramdict[k])
		@assert l == l2
	end
	paraminitdict = Mads.getparamdict(madsdata)
	if l == 1
		p = merge(paraminitdict, paramdict)
		r = convert(OrderedCollections.OrderedDict{Union{String,Symbol},Float64}, f(p))
		return r
	else
		optkeys = Mads.getoptparamkeys(madsdata_c)
		if length(optkeys) == length(kk)
			paramarray = permutedims(hcat(map(i->collect(paramdict[i]), optkeys)...))
		else
			@warn("Something is wrong!")
		end
		return forward(madsdata_c, paramarray; all=all, checkpointfrequency=checkpointfrequency, checkpointfilename=checkpointfilename)
	end
end
function forward(madsdata::AbstractDict, paramarray::AbstractArray; parallel::Bool=true, robustpmap::Bool=false, all::Bool=false, checkpointfrequency::Integer=0, checkpointfilename::AbstractString="checkpoint_forward")
	if sizeof(paramarray) == 0
		return forward(madsdata; all=all)
	end
	pk = Mads.getoptparamkeys(madsdata)
	np = length(pk)
	s = size(paramarray)
	if length(s) > 2
		error("Incorrect array size: size(paramarray) = $(size(paramarray))")
		return
	elseif length(s) == 2
		nrow, ncol = s
		if nrow != np && ncol != np
			Mads.madswarn("Incorrect array size: size(paramarray) = $(size(paramarray))")
			return
		elseif nrow == np
			ncases = ncol
		elseif ncol == np
			ncases = nrow
		end
	else
		np = s[1]
		ncases = 1
	end
	if all
		madsdata_c = deepcopy(madsdata)
		if haskey(madsdata_c, "Wells")
			setwellweights!(madsdata_c, 1)
		elseif haskey(madsdata_c, "Observations")
			setobsweights!(madsdata_c, 1)
		end
	else
		madsdata_c = madsdata
	end
	func_forward = Mads.makearrayfunction(madsdata_c)
	local r
	if length(s) == 2
		local rv
		restartdir = getrestartdir(madsdata_c)
		if checkpointfrequency != 0 && restartdir != ""
			@info("RobustPmap for parallel execution of forward runs with checkpoint frequency...")
			if s[1] == np
				rv = RobustPmap.crpmap(i->func_forward(vec(paramarray[:, i])), checkpointfrequency, joinpath(restartdir, checkpointfilename), 1:ncases)
			else
				rv = RobustPmap.crpmap(i->func_forward(vec(paramarray[i, :])), checkpointfrequency, joinpath(restartdir, checkpointfilename), 1:ncases)
			end
			r = hcat(collect.(values.(rv))...)
		elseif parallel && Distributed.nprocs() > 1
			if robustpmap
				@info("RobustPmap for parallel execution of forward runs ...")
				if s[1] == np
					# @show paramarray[:, 1]
					# @show collect(values(func_forward(vec(paramarray[:, 1]))))
					rv = RobustPmap.rpmap(func_forward, permutedims(collect(paramarray)))
				else
					# @show paramarray[1, :]
					# @show collect(values(func_forward(vec(paramarray[1, :]))))
					rv = RobustPmap.rpmap(func_forward, collect(paramarray))
				end
				r = hcat(collect.(values.(rv))...)
			else
				@info("Parallel execution of forward runs ...")
				if s[1] == np
					rv1 = collect(values(func_forward(vec(paramarray[:, 1]))))
					psa = permutedims(collect(paramarray)) # collect to avoid issues if paramarray is a SharedArray

				else
					rv1 = collect(values(func_forward(vec(paramarray[1, :]))))
					psa = collect(paramarray) # collect to avoid issues if paramarray is a SharedArray
				end
				r = SharedArrays.SharedArray{Float64}(length(rv1), ncases)
				r[:, 1] = rv1
				@Distributed.everywhere madsdata_c = $madsdata_c
				@sync @Distributed.distributed for i = 2:ncases
					func_forward = Mads.makearrayfunction(madsdata_c) # this is needed to avoid issues with the closure
					r[:, i] = collect(values(func_forward(vec(psa[i, :]))))
				end
				# @info("Distributed.pmap for parallel execution of forward runs ...") # this fails! func_forward is not defined on workers
				# p = collect(paramarray) # collect to avoid issues if paramarray is a SharedArray
				# if s[2] == np
				# 	rv = Distributed.pmap(i->func_forward(vec(p[i, :])), 1:ncases)
				# else
				# 	rv = Distributed.pmap(i->func_forward(vec(p[:, i])), 1:ncases)
				# end
				# r = hcat(collect.(values.(rv))...)
			end
		else
			@info("Serial execution of forward runs ...")
			rv = Array{Array{Float64}}(undef, ncases)
			if s[2] == np
				@ProgressMeter.showprogress 4 for i = 1:ncases
					rv[i] = collect(values(func_forward(vec(paramarray[i, :]))))
				end
			else
				@ProgressMeter.showprogress 4 for i = 1:ncases
					rv[i] = collect(values(func_forward(vec(paramarray[:, i]))))
				end
			end
			r = hcat(rv...)
		end
	else
		r = values(func_forward(paramarray))
	end
	return collect(r)
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

function forwardgrid(madsdata::AbstractDict)
	paramvalues = Mads.getparamdict(madsdata)
	forwardgrid(madsdata, paramvalues)
end

function forwardgrid(madsdatain::AbstractDict, paramvalues::AbstractDict)
	if !haskey(madsdatain, "Grid")
		madswarn("Grid properties are not defined in the Mads dictionary")
		return
	end
	madsdata = copy(madsdatain)
	xmin = madsdata["Grid"]["xmin"]
	ymin = madsdata["Grid"]["ymin"]
	zmin = madsdata["Grid"]["zmin"]
	xmax = madsdata["Grid"]["xmax"]
	ymax = madsdata["Grid"]["ymax"]
	zmax = madsdata["Grid"]["zmax"]
	time = madsdata["Grid"]["time"]
	if haskey(madsdata["Grid"], "dx")
		dx = madsdata["Grid"]["dx"]
		nx = convert(Int64, floor((xmax - xmin) / dx)) + 1
	else
		nx = madsdata["Grid"]["xcount"]
		dx = nx == 1 ? 0 : dx = ( xmax - xmin ) / ( nx - 1 )
	end
	if haskey(madsdata["Grid"], "dy")
		dy = madsdata["Grid"]["dy"]
		ny = convert(Int64, floor((ymax - ymin) / dy)) + 1
	else
		ny = madsdata["Grid"]["ycount"]
		dy = ny == 1 ? 0 : dy = ( ymax - ymin ) / ( ny - 1 )
	end
	if haskey(madsdata["Grid"], "dz")
		dz = madsdata["Grid"]["dz"]
		nz = convert(Int64, floor((zmax - zmin) / dz)) + 1
	else
		nz = madsdata["Grid"]["zcount"]
		dz = nz == 1 ? 0 : dz = ( zmax - zmin ) / ( nz - 1 )
	end

	x = xmin
	dictwells = OrderedCollections.OrderedDict{String,OrderedCollections.OrderedDict}()
	for i in 1:nx
		x += dx
		y = ymin
		for j in 1:ny
			y += dy
			z = zmin
			for k in 1:nz
				z += dz
				wellname = "w_$(i)_$(j)_$(k)"
				dictwells[wellname] = OrderedCollections.OrderedDict{String,Any}()
				dictwells[wellname]["x"] = x
				dictwells[wellname]["y"] = y
				dictwells[wellname]["z0"] = z
				dictwells[wellname]["z1"] = z
				dictwells[wellname]["on"] = true
				arrayobs = Array{OrderedCollections.OrderedDict}(undef, 0)
				dictobs = OrderedCollections.OrderedDict{String,Any}()
				dictobs["t"] = time
				dictobs["c"] = 0
				dictobs["weight"] = 1
				push!(arrayobs, dictobs)
				dictwells[wellname]["obs"] = arrayobs
			end
		end
	end
	resetdict = false
	if haskey(madsdata, "Wells")
		dictwells_orig = madsdata["Wells"]
		resetdict = true
	end
	madsdata["Wells"] = dictwells
	Mads.wells2observations!(madsdata)
	f = Mads.makemadscommandfunction(madsdata)
	forward_results = f(paramvalues)
	s = Array{Float64}(undef, nx, ny, nz)
	for i in 1:nx
		for j in 1:ny
			for k in 1:nz
				obsname = "w_$(i)_$(j)_$(k)_$(time)"
				s[i, j, k] = forward_results[obsname]
			end
		end
	end
	if resetdict
		madsdata["Wells"] = dictwells_orig
	else
		delete!(madsdata, "Wells")
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