import Mads 
Mads.setprocs()
reload("Mads")
@everywhere @show isdefined(:Mads)
nt = 2
np = nprocs()

@everywhere function fp()
	sleep(4)
	@show "fp"
end

@everywhere function pmaping()
	@show "pmaping ..."
	pmap(i->(sleep(2); fp()), 1:nt)
end

pmap(i->(@show "pmap"; sleep(1); pmaping()), 1:np)
