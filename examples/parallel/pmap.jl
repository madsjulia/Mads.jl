import Distributed

Distributed.addprocs(4)

@Distributed.everywhere function fp()
	sleep(10)
	@show "fp"
end

@Distributed.everywhere function Distributed.pmap1()
	@show "Distributed.pmap1"
	Distributed.pmap(i->(sleep(2); fp()), 1:10)
end

Distributed.pmap(i->(@show "Distributed.pmap"; sleep(1); Distributed.pmap1()), 1:10)