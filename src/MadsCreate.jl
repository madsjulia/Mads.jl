import OrderedCollections
import DelimitedFiles

"""
Load a predefined Mads problem

$(DocumentFunction.documentfunction(loadmadsproblem;
argtext=Dict("name"=>"predefined MADS problem name")))

Returns:

- MADS problem dictionary
"""
function loadmadsproblem(name::AbstractString)
	if name == "polynomial"
		madsdata = Mads.loadmadsfile(joinpath(Mads.dir, "examples", "models", "internal-polynomial-model", "internal-polynomial.mads"))
	elseif name == "external"
		madsdata = Mads.loadmadsfile(joinpath(Mads.dir, "examples", "models", "external-linear-model", "external-jld.mads"))
	else
		madsdata = nothing
	end
	return madsdata
end

function createobservations(nrow::Integer, ncol::Integer=1; obstring::AbstractString="", pretext::AbstractString="", prestring::AbstractString="", poststring::AbstractString="", filename::AbstractString="")
	dump = filename != "" ? true : false
	dump && (f = open(filename, "w"))
	dump && write(f, pretext)
	uniquecolumns = map(i->string(Char(65 + (i-1)%26))^Int(ceil(i/26)), 1:ncol)
	observationdict = OrderedCollections.OrderedDict{String,Dict}()
	for i = 1:nrow
		dump && write(f, prestring)
		for j in uniquecolumns
			obsname = string(obstring, j, i)
			dump && write(f, string(" !", obsname, "!"))
			observationdict[obsname] = Dict{String,Float64}("target"=>0.)
		end
		dump && write(f, string(poststring, "\n"))
	end
	dump && close(f)
	return observationdict
end
function createobservations(obs::AbstractVector; key::AbstractVector=["o$i" for i=1:size(obs, 1)], weight::AbstractVector=repeat([1.0], size(obs, 1)), time::AbstractVector=[], min::Union{Number,AbstractVector}=[], max::Union{Number,AbstractVector}=[],  minorig::Union{Number,AbstractVector}=min, maxorig::Union{Number,AbstractVector}=max, dist::AbstractVector=[], distribution::Bool=false)
	md = OrderedCollections.OrderedDict{String,OrderedCollections.OrderedDict}()
	@assert length(obs) == length(key)
	@assert length(obs) == length(weight)
	if length(time) > 0
		@assert length(obs) == length(time)
	end
	if length(min) > 0 && length(max) > 0
		@assert length(obs) == length(min)
		@assert length(obs) == length(max)
		@assert length(obs) == length(minorig)
		@assert length(obs) == length(maxorig)
	end
	for i = eachindex(obs)
		d = OrderedCollections.OrderedDict{String,Any}("target"=>obs[i], "weight"=>weight[i])
		if length(time) > 0
			push!(d, "time"=>time[i])
		end
		if length(dist) == length(obs) && dist[i] != ""
			push!(d, "dist"=>dist[i])
		elseif (distribution && length(dist) == 0)
			push!(d, "dist"=>"Uniform($(min[i]), $(max[i]))")
		elseif length(min) > 0 && length(max) > 0
			push!(d, "min"=>min[i])
			push!(d, "max"=>max[i])
		end
		if minorig != min
			push!(d, "minorig"=>minorig[i])
		end
		if maxorig != max
			push!(d, "maxorig"=>maxorig[i])
		end
		md[key[i]] = d
	end
	return md
end

function createobservations(obs::AbstractMatrix; key::AbstractVector=["o$i" for i=1:size(obs, 1)], weight::AbstractVector=repeat([1.0], size(obs, 1)), time::AbstractVector=collect(1:size(obs, 2)))
	md = OrderedCollections.OrderedDict{String,OrderedCollections.OrderedDict}()
	for i = 1:size(obs, 1)
		for j = 1:size(obs, 2)
			d = OrderedCollections.OrderedDict{String,Number}("target"=>obs[i], "weight"=>weight[i])
			if length(time) > 0
				push!(d, "time"=>time[j])
			else
				push!(d, "time"=>j)
			end
			push!(d, "target"=>obs[i])
			push!(d, "weight"=>weight[i])
			md[key[i] * "_t$(j)"] = d
		end
	end
	return md
end
@doc """
Create Mads dictionary of observations and instruction file

$(DocumentFunction.documentfunction(createobservations;
argtext=Dict("nrow"=>"number of rows",
             "ncol"=>"number of columns [default 1]"),
keytext=Dict("obstring"=>"observation string",
             "pretext"=>"preamble instructions",
			 "prestring"=>"pre instruction file string",
			 "poststring"=>"post instruction file string",
			 "filename"=>"file name")
)))

Returns:

- observation dictionary
""" createobservations

function createobservations!(md::AbstractDict, obs::Union{AbstractVector,AbstractMatrix}; kw...)
	md["Observations"] = createobservations(obs; kw...)
	Mads.checkobservationranges(md)
	return nothing
end

function createparameters(param::AbstractVector; key::AbstractVector=["p$i" for i=1:length(param)], name::AbstractVector=[], plotname::AbstractVector=[], type::AbstractVector=["opt" for i=1:length(param)], min::AbstractVector=[], max::AbstractVector=[], minorig::AbstractVector=min, maxorig::AbstractVector=max, dist::AbstractVector=[], expressions::AbstractVector=["" for i=1:length(param)], log::AbstractVector=falses(length(param)), distribution::Bool=false)
	mdp = OrderedCollections.OrderedDict{String,OrderedCollections.OrderedDict}()
	mde = OrderedCollections.OrderedDict{String,OrderedCollections.OrderedDict}()
	global mapping_expression = falses(length(param))
	for i = eachindex(param)
		if typeof(type[i]) === Bool
			t = type[i] == true ? "opt" : "fixed"
		else
			t = type[i]
		end
		if expressions[i] != ""
			mde[key[i]] = OrderedCollections.OrderedDict{String,Any}("exp"=>expressions[i])
			mapping_expression[i] = true
			continue
		else
			d = OrderedCollections.OrderedDict{String,Any}("init"=>param[i], "type"=>t, "log"=>log[i])
			if length(dist) == length(param) && dist[i] != ""
				push!(d, "dist"=>dist[i])
			elseif (distribution && length(dist) == 0)
				push!(d, "dist"=>"Uniform($(min[i]), $(max[i]))")
			elseif length(min) == length(param) && length(max) == length(param)
				push!(d, "min"=>min[i])
				push!(d, "max"=>max[i])
			end
		end
		if minorig != min
			push!(d, "minorig"=>minorig[i])
		end
		if maxorig != max
			push!(d, "maxorig"=>maxorig[i])
		end
		if length(key) == length(name)
			push!(d, "longname"=>name[i])
		end
		if length(key) == length(plotname)
			push!(d, "plotname"=>plotname[i])
		end
		mdp[key[i]] = d
	end
	return mdp, mde, key
end

function createparameters!(md::AbstractDict, param::AbstractVector; key::AbstractVector=["p$i" for i=1:length(param)], name::AbstractVector=key, plotname::AbstractVector=key, type::AbstractVector=["opt" for i=1:length(param)], min::AbstractVector=[], max::AbstractVector=[], minorig::AbstractVector=min, maxorig::AbstractVector=max, dist::AbstractVector=[], distribution::Bool=false, expressions::AbstractVector=["" for i=1:length(param)], log::AbstractVector=falses(length(param)))
	md["Parameters"], mde, order = createparameters(param; key=key, name=name, plotname=plotname, type=type, min=min, max=max, minorig=minorig, maxorig=maxorig, dist=dist, distribution=distribution, expressions=expressions, log=log)
	Mads.checkparameterranges(md)
	if length(mde) > 0
		md["Expressions"] = mde
		md["Order"] = order
	end
end

function removemodel(md::AbstractDict)
	for k in keys(md)
		if contains(k, r"Julia|MADS|[Mm]odel|[Ff]unction|[Cc]ommand")
			delete!(md, k)
		end
	end
	return nothing
end

function checkmodelkey(key::AbstractString, madsmodels::AbstractVector)
	for m in madsmodels
		if key == m
			return true
		end
	end
	madswarn("Model of type $key is not acceptable!")
	return false
end

function setmodel!(md::AbstractDict, f::Union{Symbol,Function,AbstractString}, key::AbstractString="Julia function")
	if !checkmodelkey(key, madsmodels_function)
		return nothing
	end
	removemodel(md)
	md[key] = f
	makemadscommandfunction(md)
	return nothing
end

function setmodel!(md::AbstractDict, f::AbstractString, key::AbstractString="Julia command")
	if !checkmodelkey(key, madsmodels_string)
		return nothing
	end
	removemodel(md)
	md[key] = f
	makemadscommandfunction(md)
	return nothing
end

function createproblem(paramfile::AbstractString, obsfile::AbstractString, f::Union{Function,AbstractString}; kw...)
	pd, _ = DelimitedFiles.readdlm(paramfile, ' '; header=true, quotes=true)
	od, _ = DelimitedFiles.readdlm(obsfile, ' '; header=true, quotes=true)
	paramkey = pd[:, 1]
	param = float.(pd[:, 2])
	paramdist = pd[:,3]
	obs = float.(od[:, 1])
	obsweight = float.(od[:, 2])
	obsdist = od[:,3]
	createproblem(param, obs, f; paramkey=paramkey, paramdist=paramdist, obsweight=obsweight, obsdist=obsdist, kw...)
	return nothing
end
function createproblem(in::Integer, out::Integer, f::Union{Function,AbstractString}; kw...)
	createproblem(rand(Mads.rng, in), rand(Mads.rng, out), f; kw...)
	return nothing
end
function createproblem(param::AbstractVector, obs::Union{AbstractVector,AbstractMatrix}, f::Union{Symbol,Function,AbstractString}; problemname::AbstractString="", paramkey::AbstractVector=["p$i" for i=1:length(param)], paramname::AbstractVector=paramkey, paramplotname::AbstractVector=paramname, paramtype::AbstractVector=["opt" for i=1:length(param)], parammin::AbstractVector=[], parammax::AbstractVector=[], paramminorig::AbstractVector=parammin, parammaxorig::AbstractVector=parammax, paramdist::AbstractVector=[], distribution::Bool=false, expressions::AbstractVector=["" for i=1:length(param)], paramlog::AbstractVector=falses(length(param)), obskey::AbstractVector=["o$i" for i=1:length(obs)], obsweight::AbstractVector=repeat([1.0], length(obs)), obstime::AbstractVector=[], obsmin::Union{Number,AbstractVector}=[], obsmax::Union{Number,AbstractVector}=[], obsminorig::Union{Number,AbstractVector}=obsmin, obsmaxorig::Union{Number,AbstractVector}=obsmax, obsdist::AbstractVector=[])
	md = Dict{String,Any}()
	createparameters!(md, param; key=paramkey, name=paramname, plotname=paramplotname, type=paramtype, min=parammin, max=parammax, minorig=paramminorig, maxorig=parammaxorig, dist=paramdist, distribution=distribution, expressions=expressions, log=paramlog)
	createobservations!(md, obs; key=obskey, weight=obsweight, time=obstime, min=obsmin, max=obsmax, minorig=obsminorig, maxorig=obsmaxorig, dist=obsdist, distribution=distribution)
	setmodel!(md, f)
	if problemname != ""
		md["Filename"] = problemname .* ".mads"
	end
	return md
end
function createproblem(infilename::AbstractString, outfilename::AbstractString)
	madsdata = Mads.loadmadsfile(infilename)
	f = Mads.makemadscommandfunction(madsdata)
	result = f(Mads.getparamdict(madsdata))
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
	Mads.dumpyamlfile(outfilename, outyaml)
	return nothing
end
function createproblem(madsdata::AbstractDict, outfilename::AbstractString)
	f = Mads.makemadscommandfunction(madsdata)
	predictions = f(Mads.getparamdict(madsdata))
	createproblem(madsdata, predictions, outfilename)
	return nothing
end
function createproblem(madsdata::AbstractDict, predictions::AbstractDict, outfilename::AbstractString)
	madsdata_new = createproblem(madsdata, predictions)
	Mads.dumpyamlmadsfile(madsdata_new, outfilename)
	return nothing
end
function createproblem(madsdata::AbstractDict, predictions::AbstractDict)
	madsdata_c = deepcopy(madsdata)
	observationsdict = madsdata_c["Observations"]
	if haskey(madsdata_c, "Wells")
		wellsdict = madsdata_c["Wells"]
	end
	for k in keys(predictions)
		observationsdict[k]["target"] = predictions[k]
		if haskey(observationsdict[k], "well")
			well = observationsdict[k]["well"]
			i = observationsdict[k]["index"]
			wellsdict[well]["obs"][i]["c"] = predictions[k]
		end
	end
	return madsdata_c
end

@doc """
Create a new Mads problem where the observation targets are computed based on the model predictions

$(DocumentFunction.documentfunction(createproblem;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "infilename"=>"input Mads file",
            "outfilename"=>"output Mads file",
            "predictions"=>"dictionary of model predictions")))

Returns:

- new MADS problem dictionary
""" createproblem