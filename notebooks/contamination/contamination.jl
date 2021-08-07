import Pkg; Pkg.resolve()
import Revise
import Mads

cd(joinpath(Mads.dir, "examples", "contamination"))

md = Mads.loadmadsfile("w01.mads")

Mads.plotmadsproblem(md, keyword="all_wells")

Mads.allwellsoff!(md) # turn off all wells
Mads.wellon!(md, "w13a") # use well w13a
Mads.wellon!(md, "w20a") # use well w20a

Mads.plotmadsproblem(md; keyword="w13a_w20a")

Mads.plotmatches(md, "w13a"; display=true)

Mads.plotmatches(md, "w20a"; display=true)

calib_param, calib_results = Mads.calibrate(md)

calib_predictions = Mads.forward(md, calib_param)

Mads.plotmatches(md, calib_predictions, "w13a")

Mads.plotmatches(md, calib_predictions, "w20a")

Mads.showparameters(md)

Mads.showparameterestimates(md, calib_param)


