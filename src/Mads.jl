__precompile__()

"""
MADS: Model Analysis & Decision Support in Julia (Mads.jl v1.0) 2016

http://mads.lanl.gov
https://github.com/madsjulia

Licensing: GPLv3: http://www.gnu.org/licenses/gpl-3.0.html
"""
module Mads

import Pkg
import OrderedCollections
import Printf
using Distributed
using DelimitedFiles
using LinearAlgebra
using Statistics
using SparseArrays
using Random

import JLD2
import FileIO
import YAML
import JSON

import Anasol
import AffineInvariantMCMC
# import GeostatInversion
import Kriging
import MetaProgTools
import ReusableFunctions
import RobustPmap
import SVR
import DocumentFunction

function pin()
	Pkg.pin("RobustPmap", v"0.3.0")
	Pkg.pin("DocumentFunction", v"0.2.0")
	Pkg.pin("SVR", v"0.3.0")
	Pkg.pin("MetaProgTools", v"0.3.0")
	Pkg.pin("Kriging", v"0.2.0")
	Pkg.pin("Anasol", v"0.3.1")
	Pkg.pin("AffineInvariantMCMC", v"0.3.0")
	Pkg.pin("GeostatInversion", v"0.3.0")
	Pkg.pin("ReusableFunctions", v"0.3.0")
end

global madsgit = true
try
	run(pipeline(`git help`; stdout=devnull, stderr=devnull))
catch
	global madsgit = false
end

global madsbash = true
if !Sys.Sys.iswindows()
	try
		run(pipeline(`bash --help`; stdout=devnull, stderr=devnull))
	catch
		global madsbash = false
	end
end

"""
Mads Modules: $madsmodules
"""
global madsmodules = ["Mads", "Anasol", "AffineInvariantMCMC", "Kriging", "ReusableFunctions", "RobustPmap", "MetaProgTools", "SVR", "DocumentFunction"]

"""
Mads Modules: $madsmodulesdoc
"""
global madsmodulesdoc = [Mads, Anasol, AffineInvariantMCMC, Kriging, ReusableFunctions, RobustPmap, MetaProgTools, SVR, DocumentFunction]
# global madsmodules = ["Mads", "Anasol", "AffineInvariantMCMC", "GeostatInversion", "Kriging", "BIGUQ", "ReusableFunctions", "RobustPmap", "MetaProgTools", "SVR", "DocumentFunction"]

include("MadsHelpers.jl")

"Try to import a module"
macro tryimport(s::Symbol)
	mname = string(s)
	importq = string(:(import $s))
	infostring = string("Module ", s, " is not available")
	q = quote
		try
			Core.eval(Mads, Meta.parse($importq))
		catch errmsg
			Mads.printerrormsg(errmsg)
			@warn($infostring)
		end
	end
	return :($(esc(q)))
end

macro tryimportmain(s::Symbol)
	mname = string(s)
	importq = string(:(import $s))
	infostring = string("Module ", s, " is not available")
	warnstring = string("Module ", s, " cannot be imported")
	q = quote
		if Mads.ispkgavailable($mname; quiet=true)
			try
				Core.eval(Main, Meta.parse($importq))
			catch errmsg
				Mads.printerrormsg(errmsg)
				@warn($warnstring)
			end
		else
			@info($infostring)
		end
	end
	return :($(esc(q)))
end

if !haskey(ENV, "MADS_NO_PYTHON")
	@tryimport PyCall
	if isdefined(Mads, :PyCall)
		const pyyaml = PyCall.PyNULL()
		function __init__()
			try
				copy!(pyyaml, PyCall.pyimport("yaml"))
				# info("PyYAML is available (in Conda)")
			catch
				ENV["PYTHON"] = ""
				@warn("PyYAML is not available (in the available python installation)")
			end
			if pyyaml == PyCall.PyNULL()
				if haskey(ENV, "PYTHON") && ENV["PYTHON"] == ""
					@tryimport Conda
				end
				global pyyamlok = false
				try
					copy!(pyyaml, PyCall.pyimport("yaml"))
					global pyyamlok = true
				catch
					@warn("PyYAML is not available (in Conda)")
				end
				if pyyamlok
					copy!(pyyaml, PyCall.pyimport("yaml"))
					# info("PyYAML is available (in Conda)")
				end
			end
		end
	else
		ENV["MADS_NO_PYTHON"] = ""
	end
end

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
global madsservers2 = ["madsmin"; map(i->(@Printf.sprintf "mads%02d" i), 1:18); "es05"; "es06"]
global nprocs_per_task_default = 1
const madsdir = splitdir(splitdir(pathof(Mads))[1])[1]

if haskey(ENV, "MADS_LONG_TESTS")
	global long_tests = true
end

if haskey(ENV, "MADS_QUIET")
	global quiet = true
end

if haskey(ENV, "MADS_NOT_QUIET")
	global quiet = false
end

include("MadsCapture.jl")
include("MadsLog.jl")
include("MadsHelp.jl")
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
include("MadsFunc.jl")
include("MadsExecute.jl")
include("MadsCalibrate.jl")
include("MadsMinimization.jl")
include("MadsLevenbergMarquardt.jl")
include("MadsKriging.jl")
include("MadsModelSelection.jl")
include("MadsAnasol.jl")
include("MadsTestFunctions.jl")
include("MadsSVR.jl")

ENV["MADS_NO_BIGUQ"] = ""
ENV["MADS_NO_KLARA"] = ""

if !haskey(ENV, "MADS_NO_BIGUQ")
	@tryimport BIGUQ
	if isdefined(Mads, :BIGUQ)
		include("MadsBayesInfoGap.jl")
	else
		ENV["MADS_NO_BIGUQ"] = ""
	end
end

if !haskey(ENV, "MADS_NO_KLARA")
	@tryimport Klara
	if !isdefined(Mads, :Klara)
		ENV["MADS_NO_KLARA"] = ""
	end
end

include("MadsMonteCarlo.jl")

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
		@Mads.tryimport PyCall
		@Mads.tryimport PyPlot
		if !isdefined(Mads, :PyPlot)
			ENV["MADS_NO_PYPLOT"] = ""
			@warn("PyPlot is not available")
		else
			# info("PyPlot is available")
		end
	end
else
	ENV["MADS_NO_GADFLY"] = ""
	ENV["MADS_NO_PYPLOT"] = ""
	ENV["MADS_NO_DISPLAY"] = ""
	global graphoutput = false
	@warn("Mads plotting is disabled")
end

if !haskey(ENV, "MADS_TRAVIS")
	include(joinpath("..", "src-interactive", "MadsPublish.jl"))
	include(joinpath("..", "src-interactive", "MadsParallel.jl"))
	include(joinpath("..", "src-interactive", "MadsTest.jl"))
	if !haskey(ENV, "MADS_NO_DISPLAY")
		include(joinpath("..", "src-interactive", "MadsDisplay.jl"))
	end
	include(joinpath("..", "src-external", "MadsSimulators.jl"))
	include(joinpath("..", "src-external", "MadsParsers.jl"))
	include(joinpath("..", "src-old", "MadsCMads.jl"))
	@tryimport JuMP
	@tryimport Ipopt
	if isdefined(Mads, :JuMP) && isdefined(Mads, :Ipopt)
		include(joinpath("..", "src-new", "MadsInfoGap.jl"))
		include(joinpath("..", "src-new", "MadsBSS.jl"))
		include(joinpath("..", "src-new", "MadsMathProgBase.jl"))
	end
end

include("MadsSenstivityAnalysis.jl")

if !haskey(ENV, "MADS_NO_GADFLY")
	include("MadsAnasolPlot.jl")
	include("MadsBayesInfoGapPlot.jl")
	include("MadsPlot.jl")
end

if !haskey(ENV, "MADS_NO_PYTHON") && !haskey(ENV, "MADS_NO_PYPLOT")
	include("MadsPlotPy.jl")
end

end
