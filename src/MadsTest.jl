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
function test(test="")
	if test == ""
		include(Pkg.dir("Mads") * "/test/runtests.jl")
		include(Pkg.dir("Anasol") * "/test/runtests.jl")
		include(Pkg.dir("BIGUQ") * "/test/runtests.jl")
		include(Pkg.dir("ReusableFunctions") * "/test/runtests.jl")
		include(Pkg.dir("MetaProgTools") * "/test/runtests.jl")
		include(Pkg.dir("RobustPmap") * "/test/runtests.jl")
	else
		file = Pkg.dir("Mads") * "/examples/$(test)/runtests.jl"
		if isfile(file)
			include(Pkg.dir("Mads") * "/examples/$(test)/runtests.jl")
		elseif isdefined(symbol(test))
			file = Pkg.dir(test) * "/test/runtests.jl"
			if isfile(file)
				include(Pkg.dir(test) * "/test/runtests.jl")
			else
				warn("Test $file is missing!")
			end
		else
			warn("Test $file is missing!")
		end
	end
end