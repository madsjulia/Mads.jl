import Printf

Random.seed!(20151001)
n = 5000
X = rand(n, n)
h = rand(n)
# @assert isposdef(A)
@Printf.printf( "Size of matrix X is %d MB\n", sizeof(X) ÷ (1048576))
rmprocs(workers())
blas_set_num_threads(1)
sleep(1)
@Printf.printf( "Number of processors %d\n", nworkers())
@time A = X * X';
@time x = A \ h;
Distributed.addprocs(8)
blas_set_num_threads(8)
@Printf.printf( "Number of processors %d\n", nworkers())
@time A = X * X';
@time x = A \ h;
@Printf.printf( "Done.")
