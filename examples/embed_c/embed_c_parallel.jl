import Test
import Distributed

Distributed.addprocs(4)

@Distributed.everywhere fcmxv_bad(n_x, x, M, n_o, o) = ccall( (:my_c_mxv_bad, "libmy.dylib"), Int32, (Int64, Ptr{Float64}, Ptr{Float64}, Int64, Ptr{Float64}), n_x, x, M, n_o, o )
@Distributed.everywhere fcmxv(n_x, x, M, n_o, o) = ccall( (:my_c_mxv, "libmy.dylib"), Int32, (Int64, Ptr{Float64}, Ptr{Float64}, Int64, Ptr{Float64}), n_x, x, M, n_o, o )
@Distributed.everywhere fjmxv(M, x) = M * x

@Distributed.everywhere nP = 100
@Distributed.everywhere nO = 1000000
@Distributed.everywhere x = rand(nP)
@Distributed.everywhere o_c = Array{Float64}(undef, nO)
@Distributed.everywhere o_j = Array{Float64}(undef, nO)

@Distributed.everywhere M = ones(nO, nP)
@Distributed.everywhere M[:,end] = 100000

@info("Matrix vector multiplication in parallel ...")
println("C (bad) ...")
@time fcmxv_bad(nP, x, M, nO, o_c);
@time map(i->fcmxv_bad(nP, x, M, nO, o_c), 1:10);
@time Distributed.pmap(i->fcmxv_bad(nP, x, M, nO, o_c), 1:10);

println("C ...")
@time fcmxv(nP, x, M, nO, o_c);
@time map(i->fcmxv(nP, x, M, nO, o_c), 1:10);
@time Distributed.pmap(i->fcmxv(nP, x, M, nO, o_c), 1:10);

println("Julia ...")
@time fjmxv(M, x);
@time map(i->fjmxv(M, x), 1:10);
@time Distributed.pmap(i->fjmxv(M, x), 1:10);

Distributed.rmprocs()(Distributed.workers())

println("Done.")