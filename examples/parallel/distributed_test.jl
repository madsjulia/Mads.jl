import Distributed
Distributed.addprocs(4)

Distributed.@everywhere @show Distributed.myid()
import SharedArrays
si = SharedArrays.SharedArray{Float64,2}((5, 23))
so = SharedArrays.SharedArray{Float64,2}((5, 8))

sil = Array{Float64,2}(undef, 5, 23)
sil = rand(5, 23)

sol = Array{Float64,2}(undef, 5, 8)
sol .= 0

@Distributed.everywhere function_test(x) = rand(8) .+ sum(x)

@sync @Distributed.distributed for i = 1:5
	so[i, :] .= function_test(sil[i, :])
end