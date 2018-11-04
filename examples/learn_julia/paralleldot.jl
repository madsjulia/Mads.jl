import Printf
using Distributed

n = 1000; p = 2500

# make normal Arrays
x = randn(n,p)
y = ones(p)
z = zeros(n)

# make SharedArrays
X = convert(SharedArray, x)
Y = convert(SharedArray, y)
Z = convert(SharedArray, z)

@Printf.printf( "Size of matrix X is %d MB\n", sizeof(X) ÷ (1048576))
@Printf.printf( "Size of matrix x is %d MB\n", sizeof(x) ÷ (1048576))

Xt = X'

@everywhere function dotcol(a, B, j)
	length(a) == size(B,1) || throw(DimensionMismatch("a and B must have the same number of rows"))
	s = 0.0
	@inbounds @simd for i = 1:length(a)
		s += a[i]*B[i,j]
	end
	s
end

function run1!(Z, Y, Xt)
	for j = 1:size(Xt, 2)
		Z[j] = dotcol(Y, Xt, j)
	end
	Z
end

function runp!(Z, Y, Xt)
	@sync @distributed for j = 1:size(Xt, 2)
		Z[j] = dotcol(Y, Xt, j)
	end
	Z
end

run1!(Z, Y, Xt);
runp!(Z, Y, Xt);
@time run1!(Z, Y, Xt);
zc = copy(sdata(Z));
fill!(Z, -1);
@time runp!(Z, Y, Xt);

@show sdata(Z) == zc;

blas_set_num_threads(8)

@time A_mul_B!(Z, X, Y);
