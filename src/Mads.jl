# __precompile__()

"""
MADS: Model Analysis & Decision Support in Julia (Mads.jl v1.0) 2016

http://mads.lanl.gov
http://github.com/madsjulia
http://mads.readthedocs.org

Licensing: GPLv3: http://www.gnu.org/licenses/gpl-3.0.html
"""
module Mads

madsmodules = ["Mads", "Anasol", "BIGUQ", "ReusableFunctions", "MetaProgTools", "RobustPmap"]

macro tryimport(s)
	importq = string(:(import $s))
	warnstring = string(s, " is not available")
	q = quote
		try 
			eval(parse($importq))
		catch
			warn($warnstring)
		end
	end
	return :($(esc(q)))
end

@tryimport LMLin

if !haskey(ENV, "MADS_NO_PLOT")
	if !haskey(ENV, "MADS_NO_GADFLY")
		@tryimport Gadfly
		if !isdefined(:Gadfly)
			ENV["MADS_NO_GADFLY"] = ""
		end
	end
	if !haskey(ENV, "MADS_NO_PYTHON") && !haskey(ENV, "MADS_NO_PYPLOT")
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

if !haskey(ENV, "MADS_NO_PYTHON")
	@tryimport PyCall
	if isdefined(:PyCall)
		try
			eval(:(@PyCall.pyimport yaml))
		catch
			ENV["PYTHON"] = ""
		end
		if haskey(ENV, "PYTHON") && ENV["PYTHON"] == ""
			@tryimport Conda
		end
		pyyamlok = false
		try
			eval(:(@PyCall.pyimport yaml))
			pyyamlok = true
		catch
			warn("PyYAML is not available")
		end
		if pyyamlok
			eval(:(@PyCall.pyimport yaml))
		end
	end
end

quiet = true
verbositylevel = 1
debuglevel = 1
modelruns = 0
madsinputfile = ""
create_tests = false # dangerous if true
long_tests = false # execute long tests
const madsdir = join(split(Base.source_path(), '/')[1:end - 1], '/')

if haskey(ENV, "MADS_LONG_TESTS")
	long_tests = true
end

if haskey(ENV, "MADS_QUIET")
	quiet = true
end

if haskey(ENV, "MADS_NOT_QUIET")
	quiet = false
end

include("MadsTypes.jl")
include("MadsLog.jl")
include("MadsPublish.jl")
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
include("MadsParameters.jl")
include("MadsObservations.jl")
include("MadsForward.jl")
include("MadsCalibrate.jl")
include("MadsFunc.jl")
include("MadsLM.jl")
include("MadsSA.jl")
include("MadsMC.jl")
# include("MadsBSS.jl")
# include("MadsInfoGap.jl")
include("MadsBIG.jl")
include("MadsModelSelection.jl")
include("MadsAnasol.jl")
include("MadsTestFunctions.jl")
include("MadsParsers.jl")
if !haskey(ENV, "MADS_NO_GADFLY")
	include("MadsAnasolPlot.jl")
	include("MadsBIGPlot.jl")
	include("MadsSAPlot.jl")
	include("MadsPlot.jl")
end
if !haskey(ENV, "MADS_NO_PYPLOT")
	include("MadsPlotPy.jl")
end

end
