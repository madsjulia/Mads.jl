import Mads
import Base.Test

Mads.madsinfo("Restarting ...")
cwd = pwd()
workdir = string((dirname(Base.source_path()))) * "/"
if workdir == "."
	workdir = joinpath(Mads.madsdir, "..", "examples", "restart")
end
cd(workdir)

@Base.Test.testset "Restarting" begin
	if Mads.long_tests
		@everywhere ReusableFunctions.resetrestarts()
		@everywhere ReusableFunctions.resetcomputes()
		@everywhere ReusableFunctions.quieton()
		Mads.rmdir(joinpath(workdir, "external-jld_restart"))
		Mads.rmdir(joinpath(workdir, "external-jld_restart_test"))

		Mads.madsinfo("Restarting external calibration problem ...")
		md = Mads.loadmadsfile(joinpath(workdir, "external-jld.mads"))
		md["Restart"] = true
		md["RestartDir"] = joinpath(workdir, "external-jld_restart_test")
		Mads.madsinfo("... create restart ...")
		create_restart_results = Mads.calibrate(md, np_lambda=2, maxJacobians=2, maxIter=2)
		@Base.Test.test Mads.getrestarts() == 12
		@Base.Test.test Mads.getcomputes() == 11
		Mads.madsinfo("... use restart ...")
		use_restart_results = Mads.calibrate(md, np_lambda=2, maxJacobians=2, maxIter=2)
		@Base.Test.test Mads.getrestarts() == 27
		@Base.Test.test Mads.getcomputes() == 11

		@Base.Test.test create_restart_results[1] == use_restart_results[1]

		Mads.rmdir(joinpath(workdir, "external-jld_restart"))
		Mads.rmdir(joinpath(workdir, "external-jld_restart_test"))
	end

	@everywhere ReusableFunctions.quieton()
	Mads.madsinfo("Restarting internal calibration problem ...")
	@everywhere ReusableFunctions.resetrestarts()
	@everywhere ReusableFunctions.resetcomputes()

	Mads.rmdir(joinpath(workdir, "w01_restart"))
	Mads.rmdir("w01_restart")
	md = Mads.loadmadsfile(joinpath(workdir, "w01-v01.mads"))
	Mads.madsinfo("... no restart ...")
	no_restart_results = Mads.calibrate(md, np_lambda=1, maxEval=10, maxJacobians=2)
	@Base.Test.test Mads.getrestarts() == 0
	# @show Mads.getrestarts()
	# @show Mads.getcomputes()

	md["Restart"] = true
	Mads.madsinfo("... create restart ...")
	create_restart_results = Mads.calibrate(md, np_lambda=1, maxEval=10, maxJacobians=2)
	@Base.Test.test Mads.getrestarts() == 12

	Mads.madsinfo("... use restart ...")
	use_restart_results = Mads.calibrate(md, np_lambda=1, maxEval=10, maxJacobians=2)
	@Base.Test.test Mads.getrestarts() == 25
	@Base.Test.test no_restart_results[1] == create_restart_results[1]
	@Base.Test.test create_restart_results[1] == use_restart_results[1]

	Mads.localsa(md, imagefiles=false, datafiles=false)

	@Base.Test.test Mads.getrestarts() == 27
	Mads.localsa(md, imagefiles=false, datafiles=false)

	@Base.Test.test Mads.getrestarts() == 29
	Mads.savemadsfile(md)

	Mads.rmdir(joinpath(workdir, "w01_restart"))
	Mads.rmdir("w01_restart")
	Mads.rmfile(joinpath(workdir, "w01-v01.iterationresults"))
	Mads.rmfile(joinpath(workdir, "w01-v02.mads"))
	Mads.rmfiles_ext("svg")
	Mads.rmfiles_ext("dat")

	@everywhere ReusableFunctions.quieton()
	Mads.rmdir(joinpath(workdir, "internal-linearmodel_restart"))
	md = Mads.loadmadsfile(joinpath(workdir, "internal-linearmodel.mads"))
	delete!(md, "Restart")
	Mads.madsinfo("... no restart ...")
	@everywhere ReusableFunctions.resetrestarts()
	@everywhere ReusableFunctions.resetcomputes()
	no_restart_results = Mads.saltelli(md, N=5, seed=2016)
	@Base.Test.test Mads.getrestarts() == 0
	@Base.Test.test Mads.getcomputes() == 0
	md["Restart"] = true
	Mads.madsinfo("... create restart ...")
	create_restart_results = Mads.saltelli(md, N=5, seed=2016)
	@Base.Test.test Mads.getrestarts() == 0
	@Base.Test.test Mads.getcomputes() == 20
	Mads.madsinfo("... use restart ...")
	use_restart_results = Mads.saltelli(md, N=5, seed=2016)
	@Base.Test.test Mads.getrestarts() == 0
	@Base.Test.test Mads.getcomputes() == 20

	@Base.Test.test no_restart_results == create_restart_results
	@Base.Test.test create_restart_results == use_restart_results

	Mads.rmdir(joinpath(workdir, "internal-linearmodel_restart"))

	delete!(md, "Restart")
	Mads.madsinfo("... no restart ...")
	@everywhere ReusableFunctions.resetrestarts()
	@everywhere ReusableFunctions.resetcomputes()
	no_restart_results = Mads.efast(md, N=5, seed=2016)
	@Base.Test.test Mads.getrestarts() == 0
	@Base.Test.test Mads.getcomputes() == 0
	md["Restart"] = true
	Mads.madsinfo("... create restart ...")
	create_restart_results = Mads.efast(md, N=5, seed=2016)
	@Base.Test.test Mads.getrestarts() == 0
	@Base.Test.test Mads.getcomputes() == 770
	Mads.madsinfo("... use restart ...")
	use_restart_results = Mads.efast(md, N=5, seed=2016)
	@Base.Test.test Mads.getrestarts() == 770
	@Base.Test.test Mads.getcomputes() == 770

	@Base.Test.test no_restart_results == create_restart_results
	@Base.Test.test create_restart_results == use_restart_results

	Mads.rmdir(joinpath(workdir, "internal-linearmodel_restart"))
end

cd(cwd)