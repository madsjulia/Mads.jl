"Execute Mads tests (the default tests are in serial)"
function testj(coverage=false)
	Pkg.test("Mads"; coverage=coverage)
	Pkg.test("Anasol"; coverage=coverage)
	Pkg.test("BIGUQ"; coverage=coverage)
	Pkg.test("ReusableFunctions"; coverage=coverage)
	Pkg.test("MetaProgTools"; coverage=coverage)
	Pkg.test("RobustPmap"; coverage=coverage)
end

"Execute Mads tests (the tests will be in parallel if processors are defined)"
function test(testmod="")
	if testmod == ""
		include(Pkg.dir("Mads") * "/test/runtests.jl")
		println("* Mads modules ...")
		println("* Anasol testing ...")
		include(Pkg.dir("Anasol") * "/test/runtests.jl")
		println("* BIGUQ testing ...")
		include(Pkg.dir("BIGUQ") * "/test/runtests.jl")
		println("* ReusableFunctions testing ...")
		include(Pkg.dir("ReusableFunctions") * "/test/runtests.jl")
		println("* MetaProgTools testing ...")
		include(Pkg.dir("MetaProgTools") * "/test/runtests.jl")
		println("* RobustPmap testing ...")
		include(Pkg.dir("RobustPmap") * "/test/runtests.jl")
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