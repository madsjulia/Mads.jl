@info("start")
include(joinpath(Mads.madsdir, "src-interactive", "MadsParallel.jl"))
@info("setprocs")
setprocs(ntasks_per_node=2)

cd(joinpath(Pkg.dir("rMF"), "LANSCE"))
include(joinpath(Pkg.dir("rMF"), "LANSCE", "nmfk-1000interpolated.jl"))
