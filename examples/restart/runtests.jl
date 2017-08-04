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
		Mads.rmdir(joinpath(workdir, "external-jld_restart"))

		Mads.madsinfo("Restarting external calibration problem ...")
		md = Mads.loadmadsfile(joinpath(workdir, "external-jld.mads"))
		md["Restart"] = true
		md["RestartDir"] = joinpath(workdir, "external-jld_restart_test")
		Mads.madsinfo("... create restart ...")
		create_restart_results = Mads.calibrate(md, maxEval=2, np_lambda=1, maxJacobians=1)
		Mads.madsinfo("... use restart ...")
		use_restart_results = Mads.calibrate(md, maxEval=2, np_lambda=1, maxJacobians=1)

		@Base.Test.test create_restart_results[1] == use_restart_results[1]

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
	@Base.Test.test ReusableFunctions.restarts == 0
	# @show ReusableFunctions.restarts
	# @show ReusableFunctions.computes

	md["Restart"] = true
	Mads.madsinfo("... create restart ...")
	create_restart_results = Mads.calibrate(md, np_lambda=1, maxEval=10, maxJacobians=2)
	@Base.Test.test ReusableFunctions.restarts == 0

	Mads.madsinfo("... use restart ...")
	use_restart_results = Mads.calibrate(md, np_lambda=1, maxEval=10, maxJacobians=2)
	@Base.Test.test ReusableFunctions.restarts == 5
	@Base.Test.test no_restart_results[1] == create_restart_results[1]
	@Base.Test.test create_restart_results[1] == use_restart_results[1]

	Mads.localsa(md, imagefiles=false, datafiles=false)

	@Base.Test.test ReusableFunctions.restarts == 9
	Mads.localsa(md, imagefiles=false, datafiles=false)

	@Base.Test.test ReusableFunctions.restarts == 11
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
	@Base.Test.test ReusableFunctions.restarts == 0
	@Base.Test.test ReusableFunctions.computes == 0
	md["Restart"] = true
	Mads.madsinfo("... create restart ...")
	create_restart_results = Mads.saltelli(md, N=5, seed=2016)
	@Base.Test.test ReusableFunctions.restarts == 0
	@Base.Test.test ReusableFunctions.computes == 20
	Mads.madsinfo("... use restart ...")
	use_restart_results = Mads.saltelli(md, N=5, seed=2016)
	@Base.Test.test ReusableFunctions.restarts == 0
	@Base.Test.test ReusableFunctions.computes == 20

	@Base.Test.test no_restart_results == create_restart_results
	@Base.Test.test create_restart_results == use_restart_results

	Mads.rmdir(joinpath(workdir, "internal-linearmodel_restart"))

	delete!(md, "Restart")
	Mads.madsinfo("... no restart ...")
	ReusableFunctions.resetrestarts()
	ReusableFunctions.resetcomputes()
	no_restart_results = Mads.efast(md, N=5, seed=2016)
	@Base.Test.test ReusableFunctions.restarts == 0
	@Base.Test.test ReusableFunctions.computes == 0
	md["Restart"] = true
	Mads.madsinfo("... create restart ...")
	create_restart_results = Mads.efast(md, N=5, seed=2016)
	@Base.Test.test ReusableFunctions.restarts == 0
	@Base.Test.test ReusableFunctions.computes == 770
	Mads.madsinfo("... use restart ...")
	use_restart_results = Mads.efast(md, N=5, seed=2016)
	@Base.Test.test ReusableFunctions.restarts == 770
	@Base.Test.test ReusableFunctions.computes == 770

	@Base.Test.test no_restart_results == create_restart_results
	@Base.Test.test create_restart_results == use_restart_results

	Mads.rmdir(joinpath(workdir, "internal-linearmodel_restart"))
end

cd(cwd)