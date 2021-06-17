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
function createmadsobservations(obs::AbstractVector; obskeys::AbstractVector=["o$i" for i=1:size(obs, 1)], obsweight::AbstractVector=repeat([1.0], size(obs, 1)), obstimes::Union{AbstractVector,Nothing}=nothing)
	mdo = OrderedCollections.OrderedDict()
	for i = 1:length(obs)
		d = OrderedCollections.OrderedDict("target"=>obs[i], "weight"=>obsweight[i])
		if obstimes !== nothing
			push!(d, "time"=>obstimes[i])
		end
		push!(d, "target"=>obs[i])
		push!(d, "weight"=>obsweight[i])
		mdo[obskeys[i]] = d
	end
	return mdo
end

function createmadsobservations(obs::AbstractMatrix; obskeys::AbstractVector=["o$i" for i=1:size(obs, 1)], obsweight::AbstractVector=repeat([1.0], size(obs, 1)), obstimes::Union{AbstractVector,Nothing}=collect(1:size(obs, 2)))
	mdo = OrderedCollections.OrderedDict()
	for i = 1:size(obs, 1)
		for j = 1:size(obs, 2)
			d = OrderedCollections.OrderedDict("target"=>obs[i], "weight"=>obsweight[i])
			if obstimes !== nothing
				push!(d, "time"=>obstimes[j])
			else
				push!(d, "time"=>j)
			end
			push!(d, "target"=>obs[i])
			push!(d, "weight"=>obsweight[i])
			mdo[obskeys[i] * "_t$(j)"] = d
		end
	end
	return mdo
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

function createmadsobservations!(md::AbstractDict, obs::Union{AbstractVector,AbstractMatrix}; obskeys::AbstractVector=["o$i" for i=1:size(obs, 1)], obsweight::AbstractVector=repeat([1.0], size(obs, 1)), obstimes::Union{AbstractVector,Nothing}=collect(1:size(obs, 2)))
	md["Observations"] = createmadsobservations(obs; obskeys=obskeys, obsweight=obsweight, obstimes=obstimes)
end

function createmadsproblem(param::AbstractVector, obs::Union{AbstractVector,AbstractMatrix}, f::Union{Function,AbstractString}; problemname::AbstractString="", paramkeys::AbstractVector=["p$i" for i=1:length(param)], paramnames::AbstractVector=paramkeys, paramplotnames::AbstractVector=paramkeys, paramtype::AbstractVector=["opt" for i=1:length(param)], parammin::AbstractVector=zeros(length(param)), parammax::AbstractVector=ones(length(param)), paramdist::AbstractVector=["Uniform($(parammin[i]), $(parammax[i]))" for i=1:length(param)], paramlog::AbstractVector=falses(length(param)), obskeys::AbstractVector=["o$i" for i=1:length(obs)], obsweight::AbstractVector=repeat([1.0], length(obs)), obstimes::Union{AbstractVector,Nothing}=nothing)
	md = Dict()
	md["Parameters"] = OrderedCollections.OrderedDict()
	for i = 1:length(param)
		d = OrderedCollections.OrderedDict("init"=>param[i], "type"=>paramtype[i], "dist"=>paramdist[i], "log"=>paramlog[i])
		if paramkeys[i] != paramnames[i]
			push!(d, "longname"=>paramnames[i])
		end
		if paramkeys[i] != paramplotnames[i]
			push!(d, "plotname"=>paramplotnames[i])
		end
		md["Parameters"][paramkeys[i]] = d
	end
	createmadsobservations!(md, obs; obskeys=obskeys, obsweight=obsweight, obstimes=obstimes)
	if problemname != ""
		md["Filename"] = problemname .* ".mads"
	end
	if typeof(f) <: AbstractString
		md["Julia command"] = f
	else
		md["Julia function"] = f
	end
	makemadscommandfunction(md)
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