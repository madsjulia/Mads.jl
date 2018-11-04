using Distributed

include(joinpath(Mads.madsdir, "src", "MadsParallel.jl"))
@info("Set processors ...")
setprocs(mads_servers=true, ntasks_per_node=2)
@everywhere display(ENV["PATH"])

@info("Import MADS ...")
import Mads
@everywhere Mads.quietoff()

@info("Test MADS ... ")
Mads.test()
