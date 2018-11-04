import Test

rmprocs(workers())

fcsqrt(d) = ccall( (:my_c_sqrt, "libmy.dylib"), Float64, (Float64,), d )
fcfunc_ex1(n, d) = ccall( (:my_c_func_ex1, "libmy.dylib"), Float64, (Int64, Float64), n, d )
function fjfunc_ex1( n, d )
	r = 0
	for i = 1:n
		r += i / d
	end
	r
end
fcfunc_ex2(n_x, x, n_o, o) = ccall( (:my_c_func_ex2, "libmy.dylib"), Int32, (Int64, Ptr{Float64}, Int64, Ptr{Float64}), n_x, x, n_o, o )
function fjfunc_ex2( x, o )
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
fcmxv_bad(n_x, x, M, n_o, o) = ccall( (:my_c_mxv_bad, "libmy.dylib"), Int32, (Int64, Ptr{Float64}, Ptr{Float64}, Int64, Ptr{Float64}), n_x, x, M, n_o, o )
fcmxv(n_x, x, M, n_o, o) = ccall( (:my_c_mxv, "libmy.dylib"), Int32, (Int64, Ptr{Float64}, Ptr{Float64}, Int64, Ptr{Float64}), n_x, x, M, n_o, o )
fjmxv(M, x) = M * x

# sqrt comparison
@info("sqrt ...")
println("c ...")
@time fcsqrt(2)
println("julia ...")
@time sqrt(2)
@Test.test_approx_eq fcsqrt(2) sqrt(2)

# function example #1
@info("func #1 ...")
println("c ...")
@time fcfunc_ex1(100, 6.4)
println("julia ...")
@time fjfunc_ex1(100, 6.4)
@Test.test_approx_eq fcfunc_ex1(100, 6.4) fjfunc_ex1(100, 6.4)

nP = 100
nO = 1000000
x = rand(nP)
o_c = Array{Float64}(undef, nO)
o_j = Array{Float64}(undef, nO)

# function example #2
@info("func #2 ...")
println("c ...")
@time fcfunc_ex2(nP, x, nO, o_c)
println("julia ...")
@time fjfunc_ex2(x, o_j)
@Test.test_approx_eq maximum(abs(o_c - o_j)) 0

M = ones(nO, nP)
M[:,end] = 100000

@info("Matrix vector multiplication ...")
println("c (bad) ...")
@time fcmxv_bad(nP, x, M, nO, o_c);
println("c ...")
@time fcmxv(nP, x, M, nO, o_c)
println("julia ...")
@time o_julia = fjmxv(M, x)
@Test.test_approx_eq maximum( o_c - o_julia ) 0