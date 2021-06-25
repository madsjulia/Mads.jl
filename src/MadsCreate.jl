import OrderedCollections
import DocumentFunction

"""
Load a predefined Mads problem

$(DocumentFunction.documentfunction(loadmadsproblem;
argtext=Dict("name"=>"predefined MADS problem name")))

Returns:

- MADS problem dictionary
"""
function loadmadsproblem(name::AbstractString)
	if name == "polynomial"
		madsdata = Mads.loadmadsfile(joinpath(Mads.madsdir, "examples", "models", "internal-polynomial-model", "internal-polynomial.mads"))
	elseif name == "external"
		madsdata = Mads.loadmadsfile(joinpath(Mads.madsdir, "examples", "models", "external-linear-model", "external-jld.mads"))
	else
		madsdata = nothing
	end
	return madsdata
end

function createmadsobservations(nrow::Int, ncol::Int=1; obstring::AbstractString="", pretext::AbstractString="", prestring::AbstractString="", poststring::AbstractString="", filename::AbstractString="")
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
			observationdict[obsname] = Dict("target"=>0)
		end
		dump && write(f, string(poststring, "\n"))
	end
	dump && close(f)
	return observationdict
end
function createmadsobservations(obs::AbstractVector; key::AbstractVector=["o$i" for i=1:size(obs, 1)], weight::AbstractVector=repeat([1.0], size(obs, 1)), time::Union{AbstractVector,Nothing}=nothing, min::AbstractVector=zeros(length(obs)), max::AbstractVector=ones(length(obs)), dist::AbstractVector=["Uniform($(min[i]), $(max[i]))" for i=1:length(obs)])
	md = OrderedCollections.OrderedDict()
	@show dist
	for i = 1:length(obs)
		d = OrderedCollections.OrderedDict{String, Any}("target"=>obs[i], "weight"=>weight[i])
		if time !== nothing
			push!(d, "time"=>time[i])
		end
		push!(d, "target"=>obs[i])
		push!(d, "weight"=>weight[i])
		push!(d, "dist"=>dist[i])
		md[key[i]] = d
	end
	return md
end

function createmadsobservations(obs::AbstractMatrix; key::AbstractVector=["o$i" for i=1:size(obs, 1)], weight::AbstractVector=repeat([1.0], size(obs, 1)), time::Union{AbstractVector,Nothing}=collect(1:size(obs, 2)))
	md = OrderedCollections.OrderedDict()
	for i = 1:size(obs, 1)
		for j = 1:size(obs, 2)
			d = OrderedCollections.OrderedDict{String, Any}("target"=>obs[i], "weight"=>weight[i])
			if time !== nothing
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

$(DocumentFunction.documentfunction(createmadsobservations;
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
""" createmadsobservations

function createmadsobservations!(md::AbstractDict, obs::Union{AbstractVector,AbstractMatrix}; key::AbstractVector=["o$i" for i=1:size(obs, 1)], weight::AbstractVector=repeat([1.0], size(obs, 1)), time::Union{AbstractVector,Nothing}=collect(1:size(obs, 2)))
	md["Observations"] = createmadsobservations(obs; key=key, weight=weight, time=time)
end

function createmadsparameters(param::AbstractVector; key::AbstractVector=["p$i" for i=1:length(param)], name::AbstractVector=key, plotname::AbstractVector=key, type::AbstractVector=["opt" for i=1:length(param)], min::AbstractVector=zeros(length(param)), max::AbstractVector=ones(length(param)), dist::AbstractVector=["Uniform($(min[i]), $(max[i]))" for i=1:length(param)], log::AbstractVector=falses(length(param)))
	mdp = OrderedCollections.OrderedDict()
	for i = 1:length(param)
		d = OrderedCollections.OrderedDict{String, Any}("init"=>param[i], "type"=>type[i], "dist"=>dist[i], "log"=>log[i])
		if key[i] != name[i]
			push!(d, "longname"=>name[i])
		end
		if key[i] != plotname[i]
			push!(d, "plotname"=>plotname[i])
		end
		mdp[key[i]] = d
	end
	return mdp
end

function createmadsparameters!(md::AbstractDict, param::AbstractVector; key::AbstractVector=["p$i" for i=1:length(param)], name::AbstractVector=key, plotname::AbstractVector=key, type::AbstractVector=["opt" for i=1:length(param)], min::AbstractVector=zeros(length(param)), max::AbstractVector=ones(length(param)), dist::AbstractVector=["Uniform($(min[i]), $(max[i]))" for i=1:length(param)], log::AbstractVector=falses(length(param)))
	md["Parameters"] = createmadsparameters(param; key=key, name=name, plotname=plotname, type=type, min=min, max=max, dist=dist, log=log)
end

function removemadsexecutable!(md::AbstractDict)
	for k in keys(md)
		if contains(k, r"Julia|MADS|[Mm]odel|[Ff]unction|[Cc]ommand")
			delete!(md, k)
		end
	end
end

function createmadsexecutable!(md::AbstractDict, f::Function)
	removemadsexecutable!(md)
	md["Julia function"] = f
	makemadscommandfunction(md)
end

function createmadsexecutable!(md::AbstractDict, f::AbstractString)
	removemadsexecutable!(md)
	md["Julia command"] = f
	makemadscommandfunction(md)
end

function createmadsproblem(param::AbstractVector, obs::Union{AbstractVector,AbstractMatrix}, f::Union{Function,AbstractString}; problemname::AbstractString="", paramkey::AbstractVector=["p$i" for i=1:length(param)], paramname::AbstractVector=paramkey, paramplotname::AbstractVector=paramkey, paramtype::AbstractVector=["opt" for i=1:length(param)], parammin::AbstractVector=zeros(length(param)), parammax::AbstractVector=ones(length(param)), paramdist::AbstractVector=["Uniform($(parammin[i]), $(parammax[i]))" for i=1:length(param)], paramlog::AbstractVector=falses(length(param)), obskey::AbstractVector=["o$i" for i=1:length(obs)], obsweight::AbstractVector=repeat([1.0], length(obs)), obstime::Union{AbstractVector,Nothing}=nothing)
	md = Dict()
	createmadsparameters!(md, param; key=paramkey, name=paramname, plotname=paramplotname, type=paramtype, min=parammin, max=parammax, dist=paramdist, log=paramlog)
	createmadsobservations!(md, obs; key=obskey, weight=obsweight, time=obstime)
	createmadsexecutable!(md, f)
	if problemname != ""
		md["Filename"] = problemname .* ".mads"
	end
	return md
end
function createmadsproblem(infilename::AbstractString, outfilename::AbstractString)
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
	return
end
function createmadsproblem(madsdata::AbstractDict, outfilename::AbstractString)
	f = Mads.makemadscommandfunction(madsdata)
	predictions = f(Mads.getparamdict(madsdata))
	createmadsproblem(madsdata, predictions, outfilename)
end
function createmadsproblem(madsdata::AbstractDict, predictions::AbstractDict, outfilename::AbstractString)
	newmadsdata = createmadsproblem(madsdata, predictions)
	Mads.dumpyamlmadsfile(newmadsdata, outfilename)
end
function createmadsproblem(madsdata::AbstractDict, predictions::AbstractDict)
	newmadsdata = deepcopy(madsdata)
	observationsdict = newmadsdata["Observations"]
	if haskey(newmadsdata, "Wells")
		wellsdict = newmadsdata["Wells"]
	end
	for k in keys(predictions)
		observationsdict[k]["target"] = predictions[k]
		if haskey( observationsdict[k], "well" )
			well = observationsdict[k]["well"]
			i = observationsdict[k]["index"]
			wellsdict[well]["obs"][i]["c"] = predictions[k]
		end
	end
	return newmadsdata
end

@doc """
Create a new Mads problem where the observation targets are computed based on the model predictions

$(DocumentFunction.documentfunction(createmadsproblem;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "infilename"=>"input Mads file",
            "outfilename"=>"output Mads file",
            "predictions"=>"dictionary of model predictions")))

Returns:

- new MADS problem dictionary
""" createmadsproblem