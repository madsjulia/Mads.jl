using Distributed

@everywhere fjmxv(M, x) = M' .* x

@everywhere nP = 100
@everywhere nO = 10000

@everywhere x = rand(nP)
@everywhere M = ones(nO, nP)
@everywhere M[:,end] = 100000

println("Julia ...")
@time fjmxv(M, x);
@time map(i->fjmxv(M, x), 1:10);
@time Distributed.pmap(i->fjmxv(M, x), 1:10);