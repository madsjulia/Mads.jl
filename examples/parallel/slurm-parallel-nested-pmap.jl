@info("start")
include(joinpath(Mads.madsdir, "src-interactive", "MadsParallel.jl"))
@info("setprocs")
setprocs()

import Mads
Mads.setprocs()
@everywhere import Mads

@everywhere nt = 2
@everywhere np = nworkers()

@everywhere function fp(i::Integer, j::Integer)
	sleep(j)
	println("fp $i $j done")
end

@everywhere function pmaping(i::Integer)
	println("pmaping $i ...")
	pmap(j->(fp(i, j)), 1:nt)
end

@time pmap(i->(println("pmap $i"); pmaping(i)), 1:np)
