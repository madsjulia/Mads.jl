# __precompile__()

"""
MADS: Model Analysis & Decision Support in Julia (Mads.jl v1.0) 2016

http://mads.lanl.gov
https://github.com/madsjulia

Licensing: GPLv3: http://www.gnu.org/licenses/gpl-3.0.html
"""
module Mads

madsgit = true
try
	run(pipeline(`git help`, stdout=DevNull, stderr=DevNull))
catch
	madsgit = false
end

madsbash = true
if !is_windows()
	try
		run(pipeline(`bash --help`, stdout=DevNull, stderr=DevNull))
	catch
		madsbash = false
	end
end

"""
Mads Modules: $madsmodules
"""
madsmodules = ["Mads", "Anasol", "AffineInvariantMCMC", "GeostatInversion", "BIGUQ", "ReusableFunctions", "RobustPmap", "MetaProgTools", "SVR", "DocumentFunction"]

import GeostatInversion
import SVR
import DocumentFunction

"Try to import a module"
macro tryimport(s::Symbol)
	importq = string(:(import $s))
	warnstring = string("Module ", s, " is not available")
	q = quote
		try
			eval(parse($importq))
		catch
			warn($warnstring)
		end
	end
	return :($(esc(q)))
end

if !haskey(ENV, "MADS_NO_PYTHON")
	@tryimport PyCall
	if isdefined(:PyCall)
		try
			eval(:(@PyCall.pyimport yaml))
		catch
			ENV["PYTHON"] = ""
			warn("PyYAML is not available")
		end
		if !isdefined(Mads, :yaml)
			if haskey(ENV, "PYTHON") && ENV["PYTHON"] == ""
				@tryimport Conda
			end
			pyyamlok = false
			try
				eval(:(@PyCall.pyimport yaml))
				pyyamlok = true
			catch
				warn("PyYAML is not available (under Conda)")
			end
			if pyyamlok
				eval(:(@PyCall.pyimport yaml))
			end
		end
	end
end

quiet = true
restart = false
graphoutput = true
graphbackend = "SVG"
dpi=300
verbositylevel = 1
debuglevel = 1
modelruns = 0
madsinputfile = ""
executionwaittime = 0.0
create_tests = false # dangerous if true
long_tests = false # execute long tests
madsservers = ["madsmax", "madsmen", "madsdam", "madszem", "madskil", "madsart", "madsend"]
nprocs_per_task = 1
const madsdir = splitdir(Base.source_path())[1]

if haskey(ENV, "MADS_LONG_TESTS")
	long_tests = true
end

if haskey(ENV, "MADS_QUIET")
	quiet = true
end

if haskey(ENV, "MADS_NOT_QUIET")
	quiet = false
end

include("MadsSTDOUT.jl")
# include("MadsDocumentation.jl")
include("MadsTypes.jl")
include("MadsLog.jl")
include("MadsHelp.jl")
include("MadsCreate.jl")
include("MadsIO.jl")
include("MadsYAML.jl")
include("MadsASCII.jl")
include("MadsJSON.jl")
include("MadsSineTransformations.jl")
include("MadsMisc.jl")
include("MadsHelpers.jl")
include("MadsParameters.jl")
include("MadsObservations.jl")
include("MadsForward.jl")
include("MadsFunc.jl")
include("MadsExecute.jl")
include("MadsCalibrate.jl")
include("MadsLevenbergMarquardt.jl")
include("MadsMonteCarlo.jl")
# include("MadsEmcee.jl")
include("MadsKriging.jl")
include("MadsBayesInfoGap.jl")
include("MadsModelSelection.jl")
include("MadsAnasol.jl")
include("MadsTestFunctions.jl")
include("MadsSVR.jl")

if !haskey(ENV, "MADS_TRAVIS")
	include("MadsMathProgBase.jl")
	include(joinpath("..", "src-interactive", "MadsPublish.jl"))
	include(joinpath("..", "src-interactive", "MadsParallel.jl"))
	include(joinpath("..", "src-interactive", "MadsTest.jl"))
	include(joinpath("..", "src-interactive", "MadsDisplay.jl"))
	include(joinpath("..", "src-external", "MadsSimulators.jl"))
	include(joinpath("..", "src-external", "MadsParsers.jl"))
	include(joinpath("..", "src-old", "MadsCMads.jl"))
	# include(joinpath("..", "src-new", "MadsInfoGap.jl"))
	include(joinpath("..", "src-new", "MadsBSS.jl"))
end

if Mads.pkgversion("Gadfly") == v"0.6.1"
	ENV["MADS_NO_GADFLY"] = ""
	warn("Gadfly v0.6.1 has bugs; update or downgrade to another version!")
	warn("Gadfly plotting is disabled!")
end

include("MadsSenstivityAnalysis.jl")

if !haskey(ENV, "MADS_NO_PLOT")
	if !haskey(ENV, "MADS_NO_GADFLY")
		@tryimport Gadfly
		if !isdefined(:Gadfly)
			ENV["MADS_NO_GADFLY"] = ""
		end
	end
	if !haskey(ENV, "MADS_NO_PYTHON") && !haskey(ENV, "MADS_NO_PYPLOT")
		@tryimport PyCall
		@tryimport PyPlot
		if !isdefined(:PyPlot)
			ENV["MADS_NO_PYPLOT"] = ""
		end
	end
else
	ENV["MADS_NO_GADFLY"] = ""
	ENV["MADS_NO_PYPLOT"] = ""
	warn("Mads plotting is disabled")
end

if !haskey(ENV, "MADS_NO_GADFLY")
	include("MadsAnasolPlot.jl")
	include("MadsBayesInfoGapPlot.jl")
	include("MadsPlot.jl")
end

if !haskey(ENV, "MADS_NO_PYPLOT")
	include("MadsPlotPy.jl")
end

end
