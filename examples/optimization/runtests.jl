import Mads
import Base.Test

workdir = Mads.getmadsdir() # get the directory where the problem is executed
if workdir == ""
	workdir = joinpath(Mads.madsdir, "..", "examples", "optimization")
end

if Mads.long_tests
	Mads.madsinfo("External optimization ...")

	md = Mads.loadmadsfile(joinpath(workdir, "external-jld.mads"))
	jparam, jresults = Mads.calibrate(md, maxEval=2, np_lambda=1, maxJacobians=1)

	if !haskey(ENV, "MADS_NO_PYTHON") && isdefined(Mads, :yaml)
		md = Mads.loadmadsfile(joinpath(workdir, "external-yaml.mads"))
		yparam, yresults = Mads.calibrate(md, maxEval=2, np_lambda=1, maxJacobians=1)
		@Base.Test.test yparam == jparam
	end
end

include(joinpath(workdir, "optimization-lm.jl"))
include(joinpath(workdir, "optimization_rosenbrock.jl"))
include(joinpath(workdir, "optimization_callback.jl"))
include(joinpath(workdir, "optimization_linear_problem.jl"))
# include(joinpath(workdir, "optimization_linear_problem_nlopt.jl")) # requires NLopt
include(joinpath(workdir, "optimization_linear_problem+template.jl"))

Mads.addkeyword!(md, "ssdr")
Mads.residuals(md)

if isdefined(:Gadfly)
    Mads.setobstime!(md, "o")
    Mads.plotmatches(md, filename="internal-linearmodel+template-match.svg")
    Mads.rmfile("internal-linearmodel+template-match.svg")
end

p = Mads.getparamdict(md)
f = Mads.makemadscommandfunctionandgradient(md) # make MADS command gradient function
f(p)
f = Mads.makemadscommandgradient(md)
f(p)

files = Mads.searchdir(r"y.*\.jld", path = workdir)
for i in files
	Mads.rmfile(joinpath(workdir, i))
end