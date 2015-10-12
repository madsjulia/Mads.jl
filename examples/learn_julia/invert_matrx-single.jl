srand(20151001)
n = 10000
X = rand(n, n)
h = rand(n)
# @assert isposdef(A)
@printf( "Size of matrix X is %d MB\n", sizeof(X) ÷ (1048576))
@printf( "Number of processors %d\n", nprocs())
@time A = X * X';
@time x = A \ h;
@printf( "Done.")
