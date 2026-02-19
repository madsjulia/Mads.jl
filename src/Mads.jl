"""
MADS: Model Analysis & Decision Support in Julia (Mads.jl v1.0) 2024

https://github.com/madsjulia

Licensing: GPLv3: http://www.gnu.org/licenses/gpl-3.0.html
"""
module Mads

import Pkg
import DocumentFunction
import OrderedCollections
import Printf
import Distributed
import DelimitedFiles
import Random
import SparseArrays
import LinearAlgebra
import Statistics

import JLD2
import YAML
import JSON

import Cairo
import Fontconfig

import JuMP
import Ipopt

function julia_main()::Cint
	if length(ARGS) > 0
		filename = ARGS[1]
		@info("Loading information from $(filename) ...")
		md = Mads.loadmadsfile(filename)
		@info("Executing calibration ...")
		Mads.calibrate(md)
	else
		@warn("Arguments should be provided on the command line!")
	end
	return 0
end

include("MadsModules.jl")

_cmd_exists(cmd::AbstractString) = Sys.which(cmd) !== nothing

madsgit::Bool = _cmd_exists("git")
madsbash::Bool = _cmd_exists("bash")
madspython::Bool = _cmd_exists("python")

global vectorflag = false
global quiet = true
global veryquiet = false
global capture = true
global restart = false
global graphoutput = true
global graphbackend = "SVG"
global imagedpi=300
global verbositylevel = 1
global debuglevel = 1
global modelruns = 0
global madsinputfile = ""
global executionwaittime = 0.0
global sindxdefault = 0.1
global create_tests = false # dangerous if true
global long_tests = false # execute long tests
global createlinks::Bool = !Sys.iswindows()
if !isdefined(@__MODULE__, :rng)
	global rng = Random.TaskLocalRNG()
end
global madsservers = [] # ["madsmax", "madsmen", "madsdam", "madszem", "madskil", "madsart", "madsend"]
global nprocs_per_task_default = 1
global parallel_optimization = false
const dir = Base.pkgdir(Mads)

include("MadsHelpers.jl")
include("MadsTryImport.jl")

if haskey(ENV, "MADS_LONG_TESTS")
	global long_tests = true
end

if haskey(ENV, "MADS_QUIET")
	global quiet = true
end

if haskey(ENV, "MADS_NOT_QUIET")
	global quiet = false
end

include("MadsHelp.jl")
# Mads.welcome()
include("MadsExamples.jl")
include("MadsCapture.jl")
include("MadsLog.jl")
include("MadsFunc.jl")
include("MadsCreate.jl")
include("MadsIO.jl")
include("MadsYAML.jl")
include("MadsXLSX.jl")
include("MadsASCII.jl")
include("MadsJSON.jl")
include("MadsSineTransformations.jl")
include("MadsMisc.jl")
include("MadsParameters.jl")
include("MadsObservations.jl")
include("MadsForward.jl")
include("MadsExecute.jl")
include("MadsCalibrate.jl")
include("MadsMinimization.jl")
include("MadsLevenbergMarquardt.jl")
include("MadsKriging.jl")
include("MadsModelSelection.jl")
include("MadsAnasol.jl")
include("MadsTestFunctions.jl")
include("MadsSVR.jl")
include("MadsBayesInfoGap.jl")
include("MadsMonteCarlo.jl")
include("MadsCoordinates.jl")

if !haskey(ENV, "MADS_NO_PLOT")
	if !haskey(ENV, "MADS_NO_GADFLY")
		import Gadfly
		import Compose
	end
else
	ENV["MADS_NO_GADFLY"] = ""
	ENV["MADS_NO_DISPLAY"] = ""
	global graphoutput = false
	@warn("Mads plotting is disabled")
end

include("MadsPublish.jl")
include("MadsParallel.jl")

const _mads_test_loaded = Ref(false)
function _ensure_mads_test_loaded()::Nothing
	if !_mads_test_loaded[]
		Base.include(@__MODULE__, joinpath(@__DIR__, "MadsTest.jl"))
		_mads_test_loaded[] = true
	end
	return nothing
end

function test(args...; kw...)
	_ensure_mads_test_loaded()
	return Base.invokelatest(getfield(Mads, :test), args...; kw...)
end

function testj(args...; kw...)
	_ensure_mads_test_loaded()
	return Base.invokelatest(getfield(Mads, :testj), args...; kw...)
end

function cleancoverage(args...; kw...)
	_ensure_mads_test_loaded()
	return Base.invokelatest(getfield(Mads, :cleancoverage), args...; kw...)
end

if !haskey(ENV, "MADS_NO_DISPLAY")
	include("MadsDisplay.jl")
end
include("MadsNotebooks.jl")
include("MadsSimulators.jl")
include("MadsParsers.jl")

include("MadsCMads.jl")

include("MadsInfoGap.jl")
include("MadsBlindSourceSeparation.jl")
include("MadsMathOptInterface.jl")

include("MadsSensitivityAnalysis.jl")

if !haskey(ENV, "MADS_NO_GADFLY")
	include("MadsAnasolPlot.jl")
	include("MadsBayesInfoGapPlot.jl")
	include("MadsPlot.jl")
end

end
