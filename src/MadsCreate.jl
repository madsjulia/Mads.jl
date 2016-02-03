
"""
Create a new Mads problem where the observation targets are computed based on the model predictions

- `Mads.createmadsproblem(infilename, outfilename)`
- `Mads.createmadsproblem(madsdata, outfilename)`
- `Mads.createmadsproblem(madsdata, predictions, outfilename)

Arguments:

- `infilename` : input Mads file
- `outfilename` : output Mads file
- `madsdata` : MADS problem dictionary
- `predictions` : dictionary of model predictions
"""
function createmadsproblem(infilename::AbstractString, outfilename::AbstractString)
	madsdata = Mads.loadmadsfile(infilename)
	f = Mads.makemadscommandfunction(madsdata)
	result = f(Dict(zip(getparamkeys(madsdata), getparamsinit(madsdata))))
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

function createmadsproblem(madsdata::Associative, outfilename::AbstractString)
	f = Mads.makemadscommandfunction(madsdata)
	predictions = f(Dict(zip(getparamkeys(madsdata), getparamsinit(madsdata))))
	createmadsproblem(madsdata, predictions, outfilename)
end

function createmadsproblem(madsdata::Associative, predictions::Associative, outfilename::AbstractString)
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
	Mads.dumpyamlmadsfile(newmadsdata, outfilename)
end
