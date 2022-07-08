filled_dict = Dict("one"=> 1, "two"=> 2, "three"=> 3)

for k = keys(filled_dict)
	@show filled_dict
	filled_dict[k] = filled_dict[k] + 1
	println(filled_dict[k])
end