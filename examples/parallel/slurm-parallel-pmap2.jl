info("start")
include(joinpath(Pkg.dir("Mads"), "src-interactive", "MadsParallel.jl"))
info("setprocs")
setprocs()

# import Mads 
# Mads.setprocs()
# reload("Mads")
# @everywhere @show isdefined(:Mads)

@everywhere nt = 10000
@everywhere np = nworkers()

@everywhere function fp(i::Integer, j::Integer)
	# println("fp $i $j done")
	return [[1, i * j] [2, i^j]]
end

@time A=vcat(pmap((i,j)->(fp(i,j)), repeat(1:np; inner=1, outer=nt), repeat(1:nt; inner=np, outer=1))...)
# display(A)
# println("")
