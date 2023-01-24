import Distributed
Distributed.addprocs(4)

cd("C:\\Users\\monty\\.julia\\dev\\Mads\\examples\\model_coupling")
@Distributed.everywhere include("internal-linearmodel-juliafunction.jl")
md = Mads.loadmadsfile("internal-linearmodel-juliafunction.mads")

@time Mads.calibraterandom(md, 100; quiet=false)
@time Mads.calibraterandom_parallel(md, 100; quiet=false)