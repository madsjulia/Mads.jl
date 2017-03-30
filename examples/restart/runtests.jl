import Mads
import Base.Test

Mads.madsinfo("Restarting ...")
cwd = pwd()
workdir = string((dirname(Base.source_path()))) * "/"
if workdir == ""
	workdir = joinpath(Mads.madsdir, "..", "examples", "restart")
end
cd(workdir)

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

Mads.rmdir(joinpath(workdir, "w01_restart"))
md = Mads.loadmadsfile(joinpath(workdir, "w01-v01.mads"))
Mads.madsinfo("... no restart ...")
no_restart_results = Mads.calibrate(md, np_lambda=1, maxEval=10, maxJacobians=2)
# @show ReusableFunctions.restarts
@Base.Test.test ReusableFunctions.restarts == 0

md["Restart"] = true
Mads.madsinfo("... create restart ...")
create_restart_results = Mads.calibrate(md, np_lambda=1, maxEval=10, maxJacobians=2)
# @show ReusableFunctions.restarts
@Base.Test.test ReusableFunctions.restarts == 7

Mads.madsinfo("... use restart ...")
use_restart_results = Mads.calibrate(md, np_lambda=1, maxEval=10, maxJacobians=2)
@Base.Test.test ReusableFunctions.restarts == 15
@Base.Test.test no_restart_results[1] == create_restart_results[1]
@Base.Test.test create_restart_results[1] == use_restart_results[1]

# @show ReusableFunctions.restarts
Mads.localsa(md, imagefiles=false, datafiles=false)

# @show ReusableFunctions.restarts
@Base.Test.test ReusableFunctions.restarts == 16
Mads.localsa(md, imagefiles=false, datafiles=false)

# @show ReusableFunctions.restarts
@Base.Test.test ReusableFunctions.restarts == 17
Mads.savemadsfile(md)


Mads.rmdir(joinpath(workdir, "w01_restart"))
rm(joinpath(workdir, "w01-v01.iterationresults"))
rm(joinpath(workdir, "w01-v02.mads"))
Mads.rmfiles_ext("svg")
Mads.rmfiles_ext("dat")

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

cd(cwd)