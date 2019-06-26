import Pkg
!haskey(Pkg.installed(), "OrderedCollections") && Pkg.add("OrderedCollections")
import OrderedCollections

obs = OrderedCollections.OrderedDict{String, Dict}()
for i=1:4
	t = i * 3 - 1
	obs[string("o", i)] = Dict("target"=>t, "weight"=>1, "min"=>-20, "max"=>20)
end

obs