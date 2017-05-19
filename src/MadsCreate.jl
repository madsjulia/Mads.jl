import DataStructures
import DocumentFunction

function createmadsproblem(infilename::String, outfilename::String)
	madsdata = Mads.loadmadsfile(infilename)
	f = Mads.makemadscommandfunction(madsdata)
	result = f(DataStructures.OrderedDict{String,Float64}(zip(getparamkeys(madsdata), getparamsinit(madsdata))))
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
function createmadsproblem(madsdata::Associative, outfilename::String)
	f = Mads.makemadscommandfunction(madsdata)
	predictions = f(DataStructures.OrderedDict{String,Float64}(zip(getparamkeys(madsdata), getparamsinit(madsdata))))
	createmadsproblem(madsdata, predictions, outfilename)
end
function createmadsproblem(madsdata::Associative, predictions::Associative, outfilename::String)
	newmadsdata = createmadsproblem(madsdata, predictions)
	Mads.dumpyamlmadsfile(newmadsdata, outfilename)
end
function createmadsproblem(madsdata::Associative, predictions::Associative)
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
""" createmadsproblem
