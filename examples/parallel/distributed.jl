import Distributed
Distributed.addprocs(4)
iii = 50
@Distributed.everywhere @show @isdefined iii
@Distributed.everywhere iii = $iii
@Distributed.everywhere @show iii

@Distributed.everywhere include("a.jl")

@Distributed.everywhere import CSV
@Distributed.everywhere @show @isdefined CSV

@Distributed.everywhere function_test(x) = (sleep(1); y = x^2; println(y); return y)
@Distributed.everywhere @show @isdefined function_test

@time map(function_test, 1:4)
@time Distributed.pmap(function_test, 1:4)
@time @sync @Distributed.distributed for i = 1:4
	function_test(4)
end