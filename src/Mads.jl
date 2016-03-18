# __precompile__()

"""
MADS: Model Analysis & Decision Support in Julia (Mads.jl v1.0) 2016

http://mads.lanl.gov
http://madsjulia.lanl.gov
http://gitlab.com/mads/Mads.jl
http://madsjulia.github.io/Mads.jl/

Licensing: GPLv3: http://www.gnu.org/licenses/gpl-3.0.html
"""
module Mads

import MetaProgTools
import RobustPmap
import DataStructures
import DataFrames
import Distributions
import Compose
import Colors
import Compat
import Optim
import Lora
import Distributions
import JSON
import JLD
import YAML
import HDF5 # HDF5 installation might be problematic on some machines

if !haskey(ENV, "MADS_NO_PLOT")
	import Gadfly
	if !haskey(ENV, "MADS_NO_PYTHON")
		import PyPlot
	end
else
	warn("Mads plotting is disabled")
end

if !haskey(ENV, "MADS_NO_PYTHON")
	import PyCall
	try
		eval(:(@PyCall.pyimport yaml))
	catch
		ENV["PYTHON"] = ""
	end
	if haskey(ENV, "PYTHON") && ENV["PYTHON"] == ""
		import Conda
	end
	eval(:(@PyCall.pyimport yaml))
end

quiet = true
verbositylevel = 1
debuglevel = 1
modelruns = 0
madsinputfile = ""
create_tests = false # dangerous if true
const madsdir = join(split(Base.source_path(), '/')[1:end - 1], '/')

include("MadsLog.jl") # messages higher than verbosity level are printed
include("MadsHelp.jl")
include("MadsTest.jl")
include("MadsCreate.jl")
include("MadsIO.jl")
include("MadsYAML.jl")
include("MadsASCII.jl")
include("MadsJSON.jl")
include("MadsSine.jl")
include("MadsMisc.jl")
include("MadsHelpers.jl")
include("MadsParallel.jl")
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
if !haskey(ENV, "MADS_NO_PLOT")
	include("MadsPlot.jl")
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

end
