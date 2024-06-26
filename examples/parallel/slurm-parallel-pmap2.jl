import Distributed

@info("start")
include(joinpath(Mads.dir, "src-interactive", "MadsParallel.jl"))
@info("setprocs")
Distributed.addprocs()

import Mads
Mads.setprocs()
Distributed.@everywhere import Mads

Distributed.@everywhere nt = 10000
Distributed.@everywhere np = Distributed.nworkers()

Distributed.@everywhere function fp(i::Integer, j::Integer)
	# println("fp $i $j done")
	return [[1, i * j] [2, i^j]]
end

@time A=vcat(Distributed.pmap((i,j)->(fp(i,j)), repeat(1:np; inner=1, outer=nt), repeat(1:nt; inner=np, outer=1))...)
# display(A)
# println("")
