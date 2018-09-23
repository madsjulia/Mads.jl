workdir = joinpath(Mads.madsdir, "examples", "restart")
Mads.rmdir(joinpath(workdir, "w01_restart"))
md = Mads.loadmadsfile(joinpath(workdir, "w01-v01.mads"))
md["Restart"] = true
create_restart_results = Mads.calibrate(md, np_lambda=1, maxEval=10, maxJacobians=2)

