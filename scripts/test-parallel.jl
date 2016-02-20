include(joinpath(Pkg.dir("Mads"), "src/MadsParallel.jl"))
info("setprocs")
setprocs(ntasks_per_node=1)
@everywhere display(ENV["PATH"])

info("import")
import Mads
@everywhere Mads.quietoff()

info("test")
Mads.test()
