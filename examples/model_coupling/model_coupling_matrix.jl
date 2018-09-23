import Mads

workdir = Mads.getmadsdir() # get the directory where the problem is executed
if workdir == "."
    workdir = joinpath(Mads.madsdir, "examples", "model_coupling")
end

md = Mads.loadmadsfile(joinpath(workdir, "internal-linearmodel-matrix.mads"))
md["Observations"] = Mads.createmadsobservations(10, 2)
md["Model"] = "internal-linearmodel-matrix.jl"
fp = Mads.forward(md)
Mads.createobservations!(md, fp)
Mads.setobsweights!(md, 1)
Mads.showobservations(md)
Mads.savemadsfile(md, "internal-linearmodel-matrix_complete.mads")
Mads.rmfile("internal-linearmodel-matrix_complete.mads")

md = Mads.loadmadsfile(joinpath(workdir, "external-linearmodel-matrix.mads"))
md["Observations"] = Mads.createmadsobservations(10, 2, pretext="l4\n", prestring="!dum! !dum!", filename=joinpath(workdir, "external-linearmodel-matrix.inst"))
md["Command"] = "julia external-linearmodel-matrix.jl"
md["Instructions"] = [Dict("ins"=>"external-linearmodel-matrix.inst", "read"=>"model_output.dat")]
fp = Mads.forward(md)
Mads.createobservations!(md, fp)
Mads.setobsweights!(md, 1)
Mads.showobservations(md)
Mads.savemadsfile(md, "external-linearmodel-matrix_complete.mads")
Mads.rmfile("external-linearmodel-matrix_complete.mads")
Mads.rmfile("external-linearmodel-matrix.inst")