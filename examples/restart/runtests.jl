import Mads
import Base.Test

Mads.madsinfo("Restarting ...")
workdir = string((dirname(Base.source_path()))) * "/"
if workdir == ""
	workdir = joinpath(Mads.madsdir, "..", "examples", "restart")
end

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

Mads.madsinfo("Restarting internal calibration problem ...")
md = Mads.loadmadsfile(joinpath(workdir, "w01-v01.mads"))
Mads.madsinfo("... no restart ...")
no_restart_results = Mads.calibrate(md, np_lambda=1, maxEval=2, maxJacobians=1)
md["Restart"] = true
Mads.madsinfo("... create restart ...")
create_restart_results = Mads.calibrate(md, np_lambda=1, maxEval=2, maxJacobians=1)
Mads.madsinfo("... use restart ...")
use_restart_results = Mads.calibrate(md, np_lambda=1, maxEval=2, maxJacobians=1)
Mads.savemadsfile(md)

@Base.Test.test no_restart_results[1] == create_restart_results[1]
@Base.Test.test create_restart_results[1] == use_restart_results[1]

Mads.rmdir(joinpath(workdir, "w01_restart"))
rm(joinpath(workdir, "w01-v01.iterationresults"))
rm(joinpath(workdir, "w01-v02.mads"))

if Mads.long_tests
	Mads.rmdir(joinpath(workdir, "/internal-linearmodel_restart"))

	Mads.madsinfo("Restarting internal sensitivity analysis problem ...")
	md = Mads.loadmadsfile(joinpath(workdir, "internal-linearmodel.mads"))
	Mads.madsinfo("... no restart ...")
	no_restart_results = Mads.saltelli(md, N=5, seed=2016)
	md["Restart"] = true
	Mads.madsinfo("... create restart ...")
	create_restart_results = Mads.saltelli(md, N=5, seed=2016)
	Mads.madsinfo("... use restart ...")
	use_restart_results = Mads.saltelli(md, N=5, seed=2016)

	@Base.Test.test no_restart_results == create_restart_results
	@Base.Test.test create_restart_results == use_restart_results

	Mads.rmdir(joinpath(workdir, "/internal-linearmodel_restart"))
end