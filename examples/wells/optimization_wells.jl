import Mads

info("Levenberg-Marquardt optimization of an external call problem using the code WELLS ...")
cdir = pwd()
problemdir = string((dirname(Base.source_path()))) * "/"
cd(problemdir)
md = Mads.loadmadsfile("w01.mads")
params, results = Mads.calibrate(md)
display(params)
cd(cdir)

return
