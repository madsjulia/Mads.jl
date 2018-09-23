import Mads

@everywhere workdir = Mads.getmadsdir()
if workdir == "."
	@everywhere workdir = joinpath(Mads.madsdir, "examples", "wells")
end
@everywhere cdir = pwd()
@everywhere cd(workdir)

info("Levenberg-Marquardt optimization of an external call problem using the code WELLS ...")

md = Mads.loadmadsfile("w01.mads")
params, results = Mads.calibrate(md)
display(params)

md = Mads.loadmadsfile("w01-restart.mads")
params, results = Mads.calibrate(md)
display(params)
params, results = Mads.calibrate(md)
display(params)

@everywhere cd(cdir)