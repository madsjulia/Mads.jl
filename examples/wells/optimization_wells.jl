import Mads
import Distributed

@Distributed.everywhere workdir = Mads.getproblemdir()
if workdir == "."
	@Distributed.everywhere workdir = joinpath(Mads.dir, "examples", "wells")
end
@Distributed.everywhere cdir = pwd()
@Distributed.everywhere cd(workdir)

@info("Levenberg-Marquardt optimization of an external call problem using the code WELLS ...")

md = Mads.loadmadsfile("w01.mads")
params, results = Mads.calibrate(md)
display(params)

md = Mads.loadmadsfile("w01-restart.mads")
params, results = Mads.calibrate(md)
display(params)
params, results = Mads.calibrate(md)
display(params)

@Distributed.everywhere cd(cdir)