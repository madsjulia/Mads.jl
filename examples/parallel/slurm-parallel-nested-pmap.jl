@info("start")
include(joinpath(Mads.dir, "src-interactive", "MadsParallel.jl"))
@info("setprocs")
setprocs()

import Mads
Mads.setprocs()
@Distributed.everywhere import Mads

@Distributed.everywhere nt = 2
@Distributed.everywhere np = Distributed.nworkers()

@Distributed.everywhere function fp(i::Integer, j::Integer)
	sleep(j)
	println("fp $i $j done")
end

@Distributed.everywhere function Distributed.pmaping(i::Integer)
	println("Distributed.pmaping $i ...")
	Distributed.pmap(j->(fp(i, j)), 1:nt)
end

@time Distributed.pmap(i->(println("Distributed.pmap $i"); Distributed.pmaping(i)), 1:np)
