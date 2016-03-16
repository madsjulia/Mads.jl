import Mads
using Base.Test

@everywhere fjmxv(M, x) = M .* x

println("Julia ...")
@time fjmxv(M, x);
@time map(i->fjmxv(M, x), 1:10);
@time pmap(i->fjmxv(M, x), 1:10);

println("Done!")
