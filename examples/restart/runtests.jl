import Mads
using Base.Test

info("Restarting ...")
problemdir = string((dirname(Base.source_path()))) * "/"
if problemdir == ""
	problemdir = Mads.madsdir * "/../examples/restart/"
end

run(`rm -fR $(problemdir)/external-jld_restart`)

info("Restarting external calibration problem ...")
md = Mads.loadmadsfile(problemdir * "external-jld.mads")
md["Restart"] = true
md["RestartDir"] = "$(problemdir)/external-jld.restart_test"
info("... create restart ...")
create_restart_results = Mads.calibrate(md, maxJacobians=1)
info("... use restart ...")
use_restart_results = Mads.calibrate(md, maxJacobians=1)

@test create_restart_results[1] == use_restart_results[1]

run(`rm -fR $(problemdir)/external-jld.restart_test`)

info("Restarting internal calibration problem ...")
md = Mads.loadmadsfile(problemdir * "internal-linearmodel.mads")
info("... no restart ...")
no_restart_results = Mads.calibrate(md)
md["Restart"] = true
info("... create restart ...")
create_restart_results = Mads.calibrate(md)
info("... use restart ...")
use_restart_results = Mads.calibrate(md)

@test no_restart_results[1] == create_restart_results[1]
@test create_restart_results[1] == use_restart_results[1]

run(`rm -fR $(problemdir)/internal-linearmodel_restart`)

info("Restarting internal sensitivity analysis problem ...")
md = Mads.loadmadsfile(problemdir * "internal-linearmodel.mads")
info("... no restart ...")
no_restart_results = Mads.saltelli(md, N=50, seed=2016)
md["Restart"] = true
info("... create restart ...")
create_restart_results = Mads.saltelli(md, N=50, seed=2016)
info("... use restart ...")
use_restart_results = Mads.saltelli(md, N=50, seed=2016)

@test no_restart_results == create_restart_results
@test create_restart_results == use_restart_results

run(`rm -fR $(problemdir)/internal-linearmodel_restart`)
return
