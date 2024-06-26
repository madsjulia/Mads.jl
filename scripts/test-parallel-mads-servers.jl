import Distributed

include(joinpath(Mads.dir, "src", "MadsParallel.jl"))
@info("Set processors ...")
setprocs(mads_servers=true, ntasks_per_node=2)
Distributed.@everywhere display(ENV["PATH"])

@info("Import MADS ...")
import Mads
Distributed.@everywhere Mads.quietoff()

@info("Test MADS ... ")
Mads.test()
