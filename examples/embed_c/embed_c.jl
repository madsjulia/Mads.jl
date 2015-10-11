using Mads
using Base.Test

@everywhere fcsqrt(x) = ccall( (:my_c_sqrt, "libmy.dylib"), Float64, (Float64,), x )
@everywhere fcfunc1(i, x) = ccall( (:my_c_func1, "libmy.dylib"), Float64, (Int64, Float64), i, x )
@everywhere fcmodel1(i, x, j, o) = ccall( (:my_c_model1, "libmy.dylib"), Int32, (Int64, Ptr{Float64}, Int64, Ptr{Float64}), i, x, j, o )
@everywhere fcmodel2(i, x, M, j, o) = ccall( (:my_c_model2, "libmy.dylib"), Int32, (Int64, Ptr{Float64}, Ptr{Float64}, Int64, Ptr{Float64}), i, x, M, j, o )
@everywhere fjmodel2(M, x) = M * x

nP = 100
nO = 1000000
x = rand(nP)
M = ones(nO, nP)
M[:,end] = 100000
o_c = Array(Float64, nO)
@time fcmodel2(nP, x, M, nO, o_c)
@time o_julia = fjmodel2(M, x)
@test_approx_eq maximum( o_c - o_julia ) 0

Mads.setnprocs(4)

println("C ...")
@time fcmodel2(nP, x, M, nO, o_c);
@time map(i->fcmodel2(nP, x, M, nO, o_c), 1:100);
@time pmap(i->fcmodel2(nP, x, M, nO, o_c), 1:100);

println("Julia ...")
@time fjmodel2(M, x);
@time map(i->fjmodel2(M, x), 1:100);
@time pmap(i->fjmodel2(M, x), 1:100);

println("Done!")
