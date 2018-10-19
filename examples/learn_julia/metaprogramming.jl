functions_to_apply = ["min", "max", "log", "exp", "cos"]
for function_name1 in functions_to_apply
	for function_name2 in functions_to_apply
		q = quote
			function $(Symbol(string("havingfun_with_", function_name1, "_", function_name2)))(x, y)
				return $(Symbol(function_name1))(x) + $(Symbol(function_name2))(y)
			end
		end
		# dump(q)
		Core.eval(Base, q)
	end
end
