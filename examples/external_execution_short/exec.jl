import Distributed

@info("Load Mads.setprocs ...")
include(joinpath(Mads.dir, "src", "MadsParallel.jl"))

@info("Set SLURM processors ...")
Distributed.addprocs()
# setprocs(ntasks_per_node=2)

@info("Number of processors = $(length(Distributed.workers()))")

@info("Import mads ...")
import Mads
Mads.quietoff()

@info("Set the correct working directory on all the processors ...")
Distributed.@everywhere Mads.setdir()
Distributed.@everywhere @show pwd()

Mads.madsinfo("Load Mads problem ...")
Distributed.@everywhere md = Mads.loadmadsfile("exec.mads")

Mads.madsinfo("eFast sensitivity analysis ...")
efast_results = Mads.efast(md; N=30, seed=2015)
JLD2.save("efast_results.jld2", "efast_results", efast_results)

Mads.madsinfo("Saltelli sensitivity analysis ...")
saltelli_results = Mads.saltelliparallel(md, length(Distributed.workers()), N=50, seed=2016)
JLD2.save("saltelli_results.jld2", "saltelli_results", saltelli_results)

if !haskey(ENV, "MADS_NO_PLOT")
	Mads.madsinfo("Local sensitivity analysis ...")
	Mads.localsa(md)
end