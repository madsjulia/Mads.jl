"""
MADS: Model Analysis & Decision Support
"""
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
# import NLopt # creates problems on some machines
import MPTools
import HDF5 # HDF5 installation might be problematic on some machines
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

#=
TODO IMPORTANT

MADS function documnetation should include the following sections:
"""
Description:

Usage:

Arguments:

Returns:

Examples:

Details:

References:

See Also:
"""
=#

end
