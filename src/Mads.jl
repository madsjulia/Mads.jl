module Mads

import DataStructures # import is needed for parallel calls
import Distributions
import Gadfly
import Compose
import Colors
import Compat
import Optim
import Lora
import Distributions
import Logging
import JSON
import NLopt
import MPTools
import HDF5 # HDF5 installation is problematic on some machines
import Conda
import PyCall
import PyPlot
@PyCall.pyimport yaml # PyYAML installation is problematic on some machines
import YAML # use YAML if PyYAML is not available

if VERSION < v"0.4.0-rc"
	using Docile # default for v > 0.4
	using Lexicon
	using Dates
	typealias AbstractString String
end
if !in(dirname(Base.source_path()), LOAD_PATH)
	push!(LOAD_PATH, dirname(Base.source_path())) # add MADS path if not already there
end
include("MadsIO.jl")
include("MadsYAML.jl")
include("MadsASCII.jl")
include("MadsJSON.jl")
include("MadsSine.jl")
include("MadsMisc.jl")
include("MadsHelpers.jl")
include("MadsParallel.jl")
include("MadsPlot.jl")
include("MadsForward.jl")
include("MadsCalibrate.jl")
include("MadsFunc.jl")
include("MadsLM.jl")
include("MadsSA.jl")
include("MadsMC.jl")
include("MadsParameters.jl")
include("MadsObservations.jl")
include("MadsBIG.jl")
include("MadsAnasol.jl")
include("MadsTestFunctions.jl")
include("MadsLog.jl") # messages higher than specified level are printed
# Logging.configure(level=OFF) # OFF
# Logging.configure(level=CRITICAL) # ONLY CRITICAL
Logging.configure(level=Logging.DEBUG)
quiet = true
verbositylevel = 1
debuglevel = 1
modelruns = 0
madsinputfile = ""
create_tests = false # dangerous if true
const madsdir = join(split(Base.source_path(), '/')[1:end - 1], '/')

#@document
#@docstrings

@doc "Save calibration results" ->
function savecalibrationresults(madsdata::Associative, results)
	#TODO map estimated parameters on a new madsdata structure
	#TODO save madsdata in yaml file using dumpyamlmadsfile
	#TODO save residuals, predictions, observations (yaml?)
end

@doc "Make a version of the mads file where the targets are given by the model predictions" ->
function maketruth(infilename::AbstractString, outfilename::AbstractString)
	md = loadyamlmadsfile(infilename)
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
end

## Types necessary for SVR; needs to be defined here because types don't seem to work when not defined at top level
type svrOutput
	alpha::Array{Float64,1}
	b::Float64
	kernel::Function
	kernelType::ASCIIString
	train_data::Array{Float64, 2}
	varargin::Array

	svrOutput(alpha::Array{Float64,1}, b::Float64, kernel::Function, kernelType::ASCIIString, train_data::Array{Float64, 2}, varargin::Array) = new(alpha, b, kernel, kernelType, train_data, varargin); # constructor for the type
end

type svrFeature
	feature::Array{Float64,1}
end

end # Module end
