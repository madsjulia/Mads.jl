import Mads
using Base.Test

info("Restarting ...")
problemdir = string((dirname(Base.source_path()))) * "/"

run(`rm -fR $(problemdir)/internal-linearmodel_restart`)

info("Restarting calibration problem ...")
md = Mads.loadmadsfile(problemdir * "internal-linearmodel.mads")
no_restart_results = Mads.calibrate(md)
md["Restart"] = true
create_restart_results = Mads.calibrate(md)
use_restart_results = Mads.calibrate(md)

@test no_restart_results[1] == create_restart_results[1]
@test create_restart_results[1] == use_restart_results[1]

info("Restarting sensitivity analysis problem ...")
md = Mads.loadmadsfile(problemdir * "internal-linearmodel.mads")
no_restart_results = Mads.saltelli(md, N=50, seed=2016)
md["Restart"] = true
create_restart_results = Mads.saltelli(md, N=50, seed=2016)
use_restart_results = Mads.saltelli(md, N=50, seed=2016)

@test no_restart_results == create_restart_results
@test create_restart_results == use_restart_results

run(`rm -fR $(problemdir)/internal-linearmodel_restart`)
return