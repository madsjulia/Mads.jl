"""
Create a new version of a mads file `infilename` and save it as `outfilename` where the observation targets are computed based on the model predictions

`createtruth(infilename, outfilename)`
`createtruth(infilename::AbstractString, outfilename::AbstractString)

Arguments:

- `infilename` : input Mads file
- `outfilename` : output Mads file

Returns: `none`

"""
function createtruth(infilename::AbstractString, outfilename::AbstractString)
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
	return
end

function createtruth(infilename::AbstractString, outfilename::AbstractString)