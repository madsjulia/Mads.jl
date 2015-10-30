functions_to_apply = ["min", "max", "log", "exp", "cos"]
for function_name1 in functions_to_apply
	for function_name2 in functions_to_apply
		q = quote
			function $(symbol(string("havingfun_with_", function_name1, "_", function_name2)))(x, y)
				return $(symbol(function_name1))(x) + $(symbol(function_name2))(y)
			end
		end
		# dump(q)
		eval(q)
	end
end
