"""
MADS: Model Analysis & Decision Support in Julia (Mads.jl v1.0) 2019

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
	else
		@warn "Arguments should be provided on the command line!"
	end
	md = Mads.loadmadsfile(filename)
	Mads.calibrate(md)
	return 0
end

include("MadsModules.jl")

try
	run(pipeline(`git help`; stdout=devnull, stderr=devnull))
	global madsgit = true
catch
	global madsgit = false
end

try
	run(pipeline(`bash --help`; stdout=devnull, stderr=devnull))
	global madsbash = true
catch
	global madsbash = false
end

try
	run(pipeline(`python --help`; stdout=devnull, stderr=devnull))
	global madspython = true
catch
	global madspython = false
end

include("MadsHelpers.jl")
include("MadsTryImport.jl")

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
global madsservers = ["madsmax", "madsmen", "madsdam", "madszem", "madskil", "madsart", "madsend"]
global nprocs_per_task_default = 1
global parallel_optimization = false
const dir = Base.pkgdir(Mads)

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

try
	testlinks()
	global createlinks = true
catch
	@info("Symbolic links cannot be created! Microsoft Windows may require to execute julia as an administrator or in a windows developers mode.")
	global createlinks = false
end

if haskey(ENV, "MADS_TRAVIS")
	@info("Travis testing environment")
	ENV["MADS_NO_PYPLOT"] = ""
end

if !haskey(ENV, "MADS_NO_PLOT")
	if !haskey(ENV, "MADS_NO_GADFLY")
		@Mads.tryimport Gadfly
		if !isdefined(Mads, :Gadfly)
			ENV["MADS_NO_GADFLY"] = ""
		end
	end
	if !haskey(ENV, "MADS_NO_PYTHON") && !haskey(ENV, "MADS_NO_PYPLOT")
		@Mads.tryimport Conda
		@Mads.tryimport PyCall
		@Mads.tryimport PyPlot
		if !isdefined(Mads, :PyPlot)
			ENV["MADS_NO_PYPLOT"] = ""
			@warn("PyPlot is not available")
		end
	end
else
	ENV["MADS_NO_GADFLY"] = ""
	ENV["MADS_NO_PYPLOT"] = ""
	ENV["MADS_NO_DISPLAY"] = ""
	global graphoutput = false
	@warn("Mads plotting is disabled")
end

include("MadsPublish.jl")
include("MadsParallel.jl")
include("MadsTest.jl")
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

if !haskey(ENV, "MADS_NO_PYTHON") && !haskey(ENV, "MADS_NO_PYPLOT")
	include("MadsPlotPy.jl")
end

Mads.seedrng()

end