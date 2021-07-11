import OrderedCollections

obs = OrderedCollections.OrderedDict{String, Dict}()
for i=1:4
	tloop = i * 3 - 1
	obs[string("o", i)] = Dict("target"=>tloop, "weight"=>1, "min"=>-20, "max"=>20)
end

obs