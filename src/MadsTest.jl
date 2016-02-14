"Execute Mads tests"
function test()
	Pkg.test("Mads")
	Pkg.test("Anasol")
	Pkg.test("BIGUQ")
	Pkg.test("ReusableFunctions")
	Pkg.test("MetaProgTools")
end