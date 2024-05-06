import Distributed

include(joinpath(Mads.dir, "src", "MadsParallel.jl"))
@info("Set processors ...")
setprocs(ntasks_per_node=1)

@info("Import MADS ...")
import Mads
Distributed.@everywhere Mads.quietoff()

@info("Test MADS ... ")
Mads.test()
