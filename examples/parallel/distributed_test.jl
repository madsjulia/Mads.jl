Distributed.@everywhere md_pta = $md_pta
Distributed.@everywhere f = Mads.makearrayfunction(md_pta)
Distributed.@everywhere @show f(rand(23))

Distributed.@everywhere @show myid()
import SharedArrays
sa = SharedArrays.SharedArray{Float64}(23, 5)
sa = zeros(23, 5)

@sync @Distributed.distributed for i = 1:5
	sa[:, i] .= rand(23) .+ 2
end
