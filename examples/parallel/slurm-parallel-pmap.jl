import Distributed

@info("start")
include(joinpath(Mads.madsdir, "src-interactive", "MadsParallel.jl"))
@info("setprocs")
Distributed.addprocs()

import Mads
Mads.setprocs()
@Distributed.everywhere import Mads

@Distributed.everywhere nt = 2
@Distributed.everywhere np = Distributed.nprocs()

@Distributed.everywhere function fp(i::Integer, j::Integer)
	sleep(j)
	println("fp $i $j done")
	return i * j
end

@time A=reshape(Distributed.pmap((i,j)->(println("$i, $j"); fp(i,j)), repeat(1:np; inner=1, outer=nt), repeat(1:nt; inner=np, outer=1)), np, nt)
display(A)
println("done")
