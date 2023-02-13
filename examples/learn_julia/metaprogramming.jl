q = quote
	i = 1
end
dump(q)
Core.eval(Main, q)

q = quote
	function $(Symbol(string("havingfun")))(x, y)
		return exp.(x) + log.(y)
	end
end
dump(q)
Core.eval(Main, q)

functions_to_apply = ["log", "exp", "cos"]
for function_name1 in functions_to_apply
	for function_name2 in functions_to_apply
		q = quote
			function $(Symbol(string("havingfun_with_", function_name1, "_", function_name2)))(x, y)
				return $(Symbol(function_name1)).(x) + $(Symbol(function_name2)).(y)
			end
		end
		# dump(q)
		Core.eval(Main, q)
	end
end

d = Dict("x"=>[1,3,5], "y"=>[2,5,6], "z"=>[6,4,6])
for k in keys(d)
	for function_name in functions_to_apply
		q = quote
			function $(Symbol(string("havingfun_with_dictionary_", k, "_", function_name)))(d)
				v = d[$k]
				return $(Symbol(function_name)).(v)
			end
		end
		# dump(q)
		Core.eval(Main, q)
	end
end

function havingfun_with_dictionary(d, k, f)
	v = d[k]
	return f.(v)
end