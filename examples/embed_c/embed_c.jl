import Mads
using Base.Test

@everywhere fcsqrt(d) = ccall( (:my_c_sqrt, "libmy.dylib"), Float64, (Float64,), d )
@everywhere fcfunc_ex1(n, d) = ccall( (:my_c_func_ex1, "libmy.dylib"), Float64, (Int64, Float64), n, d )
@everywhere function fjfunc_ex1( n, d )
	r = 0
	for i = 1:n
		r += i / d
	end
	r
end
@everywhere fcfunc_ex2(n_x, x, n_o, o) = ccall( (:my_c_func_ex2, "libmy.dylib"), Int32, (Int64, Ptr{Float64}, Int64, Ptr{Float64}), n_x, x, n_o, o )
@everywhere function fjfunc_ex2( x, o )
	n_o = length(o)
	for j = 1:n_o
		o[j] = 0
	end
	for i = 1:length(x)
		for j = 1:n_o
			o[j] += x[i] * i / j
		end
	end
end
@everywhere fcmxv_bad(n_x, x, M, n_o, o) = ccall( (:my_c_mxv_bad, "libmy.dylib"), Int32, (Int64, Ptr{Float64}, Ptr{Float64}, Int64, Ptr{Float64}), n_x, x, M, n_o, o )
@everywhere fcmxv(n_x, x, M, n_o, o) = ccall( (:my_c_mxv, "libmy.dylib"), Int32, (Int64, Ptr{Float64}, Ptr{Float64}, Int64, Ptr{Float64}), n_x, x, M, n_o, o )
@everywhere fjmxv(M, x) = M .* x

# sqrt comparison
println("sqrt ...")
@time fcsqrt(2)
@time sqrt(2)
@test_approx_eq fcsqrt(2) sqrt(2)

# function example #1
println("func #1 ...")
@time fcfunc_ex1( 100, 6.4 )
@time fjfunc_ex1( 100, 6.4 )
@test_approx_eq fcfunc_ex1( 100, 6.4 ) fjfunc_ex1( 100, 6.4 )

nP = 100
nO = 1000000
x = rand(nP)
o_c = Array(Float64, nO)
o_j = Array(Float64, nO)

# function example #2
println("func #2 ...")
@time fcfunc_ex2(nP, x, nO, o_c)
@time fjfunc_ex2(x, o_j)
@test_approx_eq maximum(abs(o_c - o_j)) 0

M = ones(nO, nP)
M[:,end] = 100000

println("Matrix vector multiplication ...")
@time fcmxv_bad(nP, x, M, nO, o_c);
@time fcmxv(nP, x, M, nO, o_c)
@time o_julia = fjmxv(M, x)
@test_approx_eq maximum( o_c - o_julia ) 0

Mads.setprocs(4)

println("Matrix vector multiplication in parallel ...")
println("C (bad) ...")
@time fcmxv_bad(nP, x, M, nO, o_c);
@time map(i->fcmxv_bad(nP, x, M, nO, o_c), 1:10);
@time pmap(i->fcmxv_bad(nP, x, M, nO, o_c), 1:10);

println("C ...")
@time fcmxv(nP, x, M, nO, o_c);
@time map(i->fcmxv(nP, x, M, nO, o_c), 1:10);
@time pmap(i->fcmxv(nP, x, M, nO, o_c), 1:10);

println("Julia ...")
@time fjmxv(M, x);
@time map(i->fjmxv(M, x), 1:10);
@time pmap(i->fjmxv(M, x), 1:10);

println("Done!")
