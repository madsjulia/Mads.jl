"Execute Mads tests (the default tests are in serial)"
function testj(coverage=false)
	for i in madsmodules
		Pkg.test(i; coverage=coverage)
	end
end

"Execute Mads tests (the tests will be in parallel if processors are defined)"
function test(testmod="")
	if testmod == ""
		include(Pkg.dir("Mads") * "/test/runtests.jl")
		println("* Mads modules ...")
		for i in madsmodules[2:end]
			println("* $i testing ...")
			include(Pkg.dir(i) * "/test/runtests.jl")
		end
	else
		file = Pkg.dir("Mads") * "/examples/$(testmod)/runtests.jl"
		if isfile(file)
			include(file)
		elseif isdefined(symbol(testmod))
			file = Pkg.dir(testmod) * "/test/runtests.jl"
			if isfile(file)
				include(file)
			else
				warn("Test $file is missing!")
			end
		else
			warn("Test $file is missing!")
		end
	end
end