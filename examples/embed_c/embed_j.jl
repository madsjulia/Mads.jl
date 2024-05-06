import Distributed

Distributed.@everywhere fjmxv(M, x) = M' .* x

Distributed.@everywhere nP = 100
Distributed.@everywhere nO = 10000

Distributed.@everywhere x = rand(nP)
Distributed.@everywhere M = ones(nO, nP)
Distributed.@everywhere M[:,end] = 100000

println("Julia ...")
@time fjmxv(M, x);
@time map(i->fjmxv(M, x), 1:10);
@time Distributed.pmap(i->fjmxv(M, x), 1:10);