import Mads
import Test

Mads.veryquieton()
Mads.graphoff()

import Distributed

workdir = Mads.getproblemdir() # get the directory where the problem is executed
if workdir == "."
	workdir = joinpath(Mads.dir, "examples", "optimization")
end

Mads.@stderrcapture function clean_directory()
	files = Mads.searchdir(r"y.*\.jld", path = workdir)
	for i in files
		Mads.rmfile(joinpath(workdir, i))
	end

	Mads.rmfiles_ext("svg"; path=workdir)
	Mads.rmfiles_ext("dat"; path=workdir)
	Mads.rmfiles_ext("iterationresults"; path=workdir)

	Mads.rmdir(joinpath(workdir, "..", "model_coupling", "internal-linearmodel+template_restart"))
	Mads.rmdir(joinpath(workdir, "..", "model_coupling", "internal-linearmodel_restart"))
end

Mads.@stderrcapture function run_optimization_tests()
	include(joinpath(workdir, "optimization-lm.jl")) # good
	include(joinpath(workdir, "optimization_rosenbrock.jl")) # good
	include(joinpath(workdir, "optimization_callback.jl")) # good?
	include(joinpath(workdir, "optimization_linear_problem.jl")) # fix
	# include(joinpath(workdir, "optimization_linear_problem_nlopt.jl")) # requires NLopt
	if !Mads.createlinks
		@warn("Links cannot be created on Windows if not executed with admin privileges or under a development mode!")
		@warn("The optimization_linear_problem+template.jl test will be skipped!")
	else
		include(joinpath(workdir, "optimization_linear_problem+template.jl")) # fix
	end
end

Test.@testset "Optimization" begin
	run_optimization_tests()

	if Mads.long_tests
		Mads.madsinfo("External optimization ...")

		global md = Mads.loadmadsfile(joinpath(workdir, "external-jld.mads"))
		jparam, jresults = Mads.calibrate(md; maxEval=2, np_lambda=1, maxJacobians=1)


		global md = Mads.loadmadsfile(joinpath(workdir, "external-yaml.mads"))
		yparam, yresults = Mads.calibrate(md; maxEval=2, np_lambda=1, maxJacobians=1)
		Test.@test yparam == jparam
	end

end

Mads.addkeyword!(md, "ssdr")
Mads.residuals(md)
Mads.calibrate(md; maxEval=1, np_lambda=1, maxJacobians=1)

if !haskey(ENV, "MADS_NO_GADFLY") && !haskey(ENV, "MADS_NO_PLOT")
	Mads.setobstime!(md, "o")
	Mads.plotmatches(md, filename="internal-linearmodel+template-match.svg"; display=false)
	Mads.rmfile("internal-linearmodel+template-match.svg")
end

clean_directory()

Mads.veryquietoff()
Mads.graphon()

:passed