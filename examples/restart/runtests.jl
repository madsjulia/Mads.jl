import Mads
import Base.Test

Mads.madsinfo("Restarting ...")
problemdir = string((dirname(Base.source_path()))) * "/"
if problemdir == ""
	problemdir = Mads.madsdir * "/../examples/restart/"
end

if Mads.long_tests
	Mads.rmdir(problemdir * "/external-jld_restart")

	Mads.madsinfo("Restarting external calibration problem ...")
	md = Mads.loadmadsfile(problemdir * "external-jld.mads")
	md["Restart"] = true
	md["RestartDir"] = "$(problemdir)/external-jld_restart_test"
	Mads.madsinfo("... create restart ...")
	create_restart_results = Mads.calibrate(md, maxEval=2, np_lambda=1, maxJacobians=1)
	Mads.madsinfo("... use restart ...")
	use_restart_results = Mads.calibrate(md, maxEval=2, np_lambda=1, maxJacobians=1)

	@Base.Test.test create_restart_results[1] == use_restart_results[1]

	Mads.rmdir(problemdir * "/external-jld_restart")
	Mads.rmdir(problemdir * "/external-jld_restart_test")
end

Mads.madsinfo("Restarting internal calibration problem ...")
md = Mads.loadmadsfile(problemdir * "w01-v01.mads")
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

Mads.rmdir(problemdir * "/w01_restart")
rm("$(problemdir)/w01-v01.iterationresults")
rm("$(problemdir)/w01-v02.mads")

if Mads.long_tests
	Mads.rmdir(problemdir * "/internal-linearmodel_restart")

	Mads.madsinfo("Restarting internal sensitivity analysis problem ...")
	md = Mads.loadmadsfile(problemdir * "internal-linearmodel.mads")
	Mads.madsinfo("... no restart ...")
	no_restart_results = Mads.saltelli(md, N=5, seed=2016)
	md["Restart"] = true
	Mads.madsinfo("... create restart ...")
	create_restart_results = Mads.saltelli(md, N=5, seed=2016)
	Mads.madsinfo("... use restart ...")
	use_restart_results = Mads.saltelli(md, N=5, seed=2016)

	@Base.Test.test no_restart_results == create_restart_results
	@Base.Test.test create_restart_results == use_restart_results

	Mads.rmdir(problemdir * "/internal-linearmodel_restart")
end