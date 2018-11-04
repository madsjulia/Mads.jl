import Printf

Random.seed!(20151001)
n = 5000
X = rand(n, n)
h = rand(n)
# @assert isposdef(A)
@Printf.printf( "Size of matrix X is %d MB\n", sizeof(X) ÷ (1048576))
@Printf.printf( "Number of processors %d\n", nworkers())
blas_set_num_threads(4)
@time A = X * X';
@time x = A \ h;
blas_set_num_threads(1)
@time A = X * X';
@time x = A \ h;
@Printf.printf( "Done.")
