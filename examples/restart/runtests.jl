import Mads
import Test
import ReusableFunctions

Mads.madsinfo("Restarting ...")
cwd = pwd()
workdir = string((dirname(Base.source_path()))) * "/"
if workdir == "."
	workdir = joinpath(Mads.madsdir, "examples", "restart")
end
cd(workdir)

@Test.testset "Restarting" begin
	if Mads.long_tests
		ReusableFunctions.resetrestarts()
		ReusableFunctions.resetcomputes()
		ReusableFunctions.quieton()
		Mads.rmdir(joinpath(workdir, "external-jld_restart"))
		Mads.rmdir(joinpath(workdir, "external-jld_restart_test"))

		Mads.madsinfo("Restarting external calibration problem ...")
		global md = Mads.loadmadsfile(joinpath(workdir, "external-jld.mads"))
		md["Restart"] = true
		md["RestartDir"] = joinpath(workdir, "external-jld_restart_test")
		Mads.madsinfo("... create restart ...")
		create_restart_results = Mads.calibrate(md, np_lambda=2, maxJacobians=2, maxIter=2)
		@Test.test Mads.getrestarts() == 12
		@Test.test Mads.getcomputes() == 11
		Mads.madsinfo("... use restart ...")
		use_restart_results = Mads.calibrate(md, np_lambda=2, maxJacobians=2, maxIter=2)
		@Test.test Mads.getrestarts() == 27
		@Test.test Mads.getcomputes() == 11

		@Test.test create_restart_results[1] == use_restart_results[1]

		Mads.rmdir(joinpath(workdir, "external-jld_restart"))
		Mads.rmdir(joinpath(workdir, "external-jld_restart_test"))
	end

	ReusableFunctions.quieton()
	Mads.madsinfo("Restarting internal calibration problem ...")
	ReusableFunctions.resetrestarts()
	ReusableFunctions.resetcomputes()

	Mads.rmdir(joinpath(workdir, "w01_restart"))
	Mads.rmdir("w01_restart")
	md = Mads.loadmadsfile(joinpath(workdir, "w01-v01.mads"))
	Mads.madsinfo("... no restart ...")
	no_restart_results = Mads.calibrate(md, np_lambda=1, maxEval=10, maxJacobians=2)
	@Test.test Mads.getrestarts() == 0
	# @show Mads.getrestarts()
	# @show Mads.getcomputes()

	md["Restart"] = true
	Mads.madsinfo("... create restart ...")
	create_restart_results = Mads.calibrate(md, np_lambda=1, maxEval=10, maxJacobians=2)
	@Test.test Mads.getrestarts() == 12

	Mads.madsinfo("... use restart ...")
	use_restart_results = Mads.calibrate(md, np_lambda=1, maxEval=10, maxJacobians=2)
	@Test.test Mads.getrestarts() == 25
	@Test.test no_restart_results[1] == create_restart_results[1]
	@Test.test create_restart_results[1] == use_restart_results[1]

	Mads.localsa(md, imagefiles=false, datafiles=false)

	@Test.test Mads.getrestarts() == 27
	Mads.localsa(md, imagefiles=false, datafiles=false)

	@Test.test Mads.getrestarts() == 29
	Mads.savemadsfile(md)

	Mads.rmdir(joinpath(workdir, "w01_restart"))
	Mads.rmdir("w01_restart")
	Mads.rmfile(joinpath(workdir, "w01-v01.iterationresults"))
	Mads.rmfile(joinpath(workdir, "w01-v02.mads"))
	Mads.rmfiles_ext("svg")
	Mads.rmfiles_ext("dat")

	ReusableFunctions.quieton()
	Mads.rmdir(joinpath(workdir, "internal-linearmodel_restart"))
	md = Mads.loadmadsfile(joinpath(workdir, "internal-linearmodel.mads"))
	delete!(md, "Restart")
	Mads.madsinfo("... no restart ...")
	ReusableFunctions.resetrestarts()
	ReusableFunctions.resetcomputes()
	no_restart_results = Mads.saltelli(md, N=5, seed=2016)
	@Test.test Mads.getrestarts() == 0
	@Test.test Mads.getcomputes() == 0
	md["Restart"] = true
	Mads.madsinfo("... create restart ...")
	create_restart_results = Mads.saltelli(md, N=5, seed=2016)
	@Test.test Mads.getrestarts() == 0
	@Test.test Mads.getcomputes() == 20
	Mads.madsinfo("... use restart ...")
	use_restart_results = Mads.saltelli(md, N=5, seed=2016)
	@Test.test Mads.getrestarts() == 20
	@Test.test Mads.getcomputes() == 20

	@Test.test no_restart_results == create_restart_results
	@Test.test create_restart_results == use_restart_results

	Mads.rmdir(joinpath(workdir, "internal-linearmodel_restart"))

	delete!(md, "Restart")
	Mads.madsinfo("... no restart ...")
	ReusableFunctions.resetrestarts()
	ReusableFunctions.resetcomputes()
	no_restart_results = Mads.efast(md, N=5, seed=2016)
	@Test.test Mads.getrestarts() == 0
	@Test.test Mads.getcomputes() == 0
	md["Restart"] = true
	Mads.madsinfo("... create restart ...")
	create_restart_results = Mads.efast(md, N=5, seed=2016)
	@Test.test Mads.getrestarts() == 0
	@Test.test Mads.getcomputes() == 770
	Mads.madsinfo("... use restart ...")
	use_restart_results = Mads.efast(md, N=5, seed=2016)
	@Test.test Mads.getrestarts() == 770
	@Test.test Mads.getcomputes() == 770

	@Test.test no_restart_results == create_restart_results
	@Test.test create_restart_results == use_restart_results

	Mads.rmdir(joinpath(workdir, "internal-linearmodel_restart"))
end

cd(cwd)