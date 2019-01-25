using Distributed
import Mads

@info("start")
include(joinpath(Mads.madsdir, "src-interactive/MadsParallel.jl"))
@info("setprocs")
Mads.setprocs(ntasks_per_node=16)

@info("import")
@everywhere import Mads
@everywhere Mads.quietoff()
@info("set")

@info("load")
f = "external-linearmodel+template+instruction.mads"
filename = Mads.getnextmadsfilename(f)
@info("$filename")
md = Mads.loadmadsfile(filename)
# Mads.addkeyword!(md, "respect_space")
md["Restart"]= true
@info("forward")
Mads.forward(md)
@show ReusableFunctions.restarts
@info("local SA")
lsa_results = Mads.localsa(md, datafiles=true, imagefiles=true)
@show ReusableFunctions.restarts
FileIO.save("lsa_results.jld2", "lsa_results", lsa_results)
@info("calibrate")
inverse_parameters, inverse_results = Mads.calibrate(md; np_lambda=36, lambda_mu=1.5, tolX=1e-16)
@show ReusableFunctions.restarts
Mads.setparamsinit!(md, inverse_parameters)
Mads.savemadsfile(md)
