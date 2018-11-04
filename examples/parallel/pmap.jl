using Distributed

addprocs(4)

@everywhere function fp()
	sleep(10)
	@show "fp"
end

@everywhere function pmap1()
	@show "pmap1"
	pmap(i->(sleep(2); fp()), 1:10)
end

pmap(i->(@show "pmap"; sleep(1); pmap1()), 1:10)