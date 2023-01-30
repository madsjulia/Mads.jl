import Distributed
Distributed.addprocs(4)
iii = 50
@Distributed.everywhere @show @isdefined iii
@Distributed.everywhere iii = $iii
@Distributed.everywhere @show iii

@Distributed.everywhere include("a.jl")

@Distributed.everywhere import CSV
@Distributed.everywhere @show @isdefined CSV

@Distributed.everywhere f(x) = (sleep(2); println(x^2))
@Distributed.everywhere @show @isdefined f

@time map(f, 1:4)
@time Distributed.pmap(f, 1:4)
@time @sync @Distributed.distributed for i = 1:4
	f(4)
end