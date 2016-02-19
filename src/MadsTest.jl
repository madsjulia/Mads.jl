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
function test()
	include(Pkg.dir("Mads") * "/test/runtests.jl")
	include(Pkg.dir("Anasol") * "/test/runtests.jl")
	include(Pkg.dir("BIGUQ") * "/test/runtests.jl")
	include(Pkg.dir("ReusableFunctions") * "/test/runtests.jl")
	include(Pkg.dir("MetaProgTools") * "/test/runtests.jl")
	include(Pkg.dir("RobustPmap") * "/test/runtests.jl")
end