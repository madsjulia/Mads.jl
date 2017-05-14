info("start")
include(joinpath(Pkg.dir("Mads"), "src-interactive", "MadsParallel.jl"))
info("setprocs")
setprocs()

# import Mads 
# Mads.setprocs()
# reload("Mads")
# @everywhere @show isdefined(:Mads)

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
