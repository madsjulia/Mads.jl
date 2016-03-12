"Execute Mads tests (the default tests are in serial)"
function testj()
	Pkg.test("Mads")
	Pkg.test("Anasol")
	Pkg.test("BIGUQ")
	Pkg.test("ReusableFunctions")
	Pkg.test("MetaProgTools")
	Pkg.test("RobustPmap")
end

"Execute Mads tests (the tests will be in parallel if processors are defined)"
function test(testmod="")
	if testmod == ""
		include(Pkg.dir("Mads") * "/test/runtests.jl")
		include(Pkg.dir("Anasol") * "/test/runtests.jl")
		include(Pkg.dir("BIGUQ") * "/test/runtests.jl")
		include(Pkg.dir("ReusableFunctions") * "/test/runtests.jl")
		include(Pkg.dir("MetaProgTools") * "/test/runtests.jl")
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