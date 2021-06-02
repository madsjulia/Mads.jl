import OrderedCollections
import DocumentFunction

"""
Load a predefined Mads problem

$(DocumentFunction.documentfunction(loadmadsproblem;
argtext=Dict("name"=>"predefined MADS problem name")))

Returns:

- MADS problem dictionary
"""
function loadmadsproblem(name::String)
	if name == "polynomial"
		madsdata = Mads.loadmadsfile(joinpath(Mads.madsdir, "examples", "models", "internal-polynomial-model", "internal-polynomial.mads"))
	elseif name == "external"
		madsdata = Mads.loadmadsfile(joinpath(Mads.madsdir, "examples", "models", "external-linear-model", "external-jld.mads"))
	else
		madsdata = nothing
	end
	return madsdata
end

function createmadsproblem(param::AbstractVector, obs::AbstractVector, f::Function; problemname::AbstractString="", paramkeys::AbstractVector=["p$i" for i=1:length(param)], paramtype::AbstractVector=["opt" for i=1:length(param)], parammin::AbstractVector=zeros(length(param)), parammax::AbstractVector=ones(length(param)), paramdist::AbstractVector=["Uniform($(parammin[i]), $(parammax[i]))" for i=1:length(param)], paramlog::AbstractVector=falses(length(param)), paramnames::AbstractVector=paramkeys, obskeys::AbstractVector=["o$i" for i=1:length(obs)], obsweight::AbstractVector=repeat([1.0], length(obs)), obstimes::AbstractVector=collect(1:length(obs)))
	md = Dict()
	md["Parameters"] = OrderedCollections.OrderedDict()
	for i = 1:length(param)
		md["Parameters"][paramkeys[i]] = OrderedCollections.OrderedDict("init"=>param[i], "type"=>paramtype[i], "dist"=>paramdist[i], "log"=>paramlog[i], "longname"=>paramnames[i])
	end
	md["Observations"] = OrderedCollections.OrderedDict()
	for i = 1:length(obs)
		md["Observations"][obskeys[i]] = OrderedCollections.OrderedDict("target"=>obs[i], "weight"=>obsweight[i], "time"=>obstimes[i])
	end
	if problemname != ""
		md["Filename"] = problemname .* ".mads"
	end
	md["Julia function"] = f
	makemadscommandfunction(md)
	return md
end
function createmadsproblem(infilename::String, outfilename::String)
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
function createmadsproblem(madsdata::AbstractDict, outfilename::String)
	f = Mads.makemadscommandfunction(madsdata)
	predictions = f(Mads.getparamdict(madsdata))
	createmadsproblem(madsdata, predictions, outfilename)
end
function createmadsproblem(madsdata::AbstractDict, predictions::AbstractDict, outfilename::String)
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

"""
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
"""
function createmadsobservations(nrow::Int, ncol::Int=1; obstring::String="", pretext::String="", prestring::String="", poststring::String="", filename::String="")
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
