srand(20151001)
n = 2000
X = rand(n, n)
h = rand(n)
# @assert isposdef(A)
@printf( "Size of matrix X is %d MB\n", sizeof(X) ÷ (1048576))
rmprocs(workers())
@printf( "Number of processors %d\n", nprocs())
@time A = X * X';
@time x = A \ h;
addprocs(4)
@printf( "Number of processors %d\n", nprocs())
@time A = X * X';
@time x = A \ h;
@printf( "Done.")
