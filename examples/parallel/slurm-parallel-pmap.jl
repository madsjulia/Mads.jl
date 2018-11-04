using Distributed

@info("start")
include(joinpath(Mads.madsdir, "src-interactive", "MadsParallel.jl"))
@info("setprocs")
setprocs()

# import Mads
# Mads.setprocs()
# reload("Mads")
# @everywhere @show isdefined(Base, :Mads)

@everywhere nt = 2
@everywhere np = nprocs()

@everywhere function fp(i::Integer, j::Integer)
	sleep(j)
	println("fp $i $j done")
	return i * j
end

@time A=reshape(pmap((i,j)->(println("$i, $j"); fp(i,j)), repeat(1:np; inner=1, outer=nt), repeat(1:nt; inner=np, outer=1)), np, nt)
display(A)
println("done")
