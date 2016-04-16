info("Load Mads.setprocs ...")
include(joinpath(Pkg.dir("Mads"), "src/MadsParallel.jl"))

info("Set SLURM processors ...")
setprocs()
# setprocs(ntasks_per_node=2)

info("Number of processors = $(length(workers()))")

info("Import mads ...")
reload("Mads")
Mads.quietoff()

info("Set the correct working directory on all the processors ...")
@everywhere Mads.setdir()
@everywhere @show pwd()

Mads.madsinfo("Load Mads problem ...")
@everywhere md = Mads.loadmadsfile("exec.mads")

Mads.madsinfo("eFast sensitivity analysis ...")
efast_results = Mads.efast(md, N=30, seed=2015)
JLD.save("efast_results.jld", "efast_results", efast_results)

Mads.madsinfo("Saltelli sensitivity analysis ...")
saltelli_results = Mads.saltelliparallel(md, length(workers()), N=50, seed=2016)
JLD.save("saltelli_results.jld", "saltelli_results", saltelli_results)

if !haskey(ENV, "MADS_NO_PLOT")
	Mads.madsinfo("Local sensitivity analysis ...")
	Mads.localsa(md)
end