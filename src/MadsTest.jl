
"""
Execute Mads tests using Julia Pkg.test (the default Pkg.test in Julia is executed in serial)

$(DocumentFunction.documentfunction(testj;
argtext=Dict("coverage"=>"[default=`false`]")))
"""
function testj(coverage::Bool=false)
	orig_dir = pwd()
	for i in madsmodules
		Pkg.test(i; coverage=coverage)
	end
	cd(orig_dir)
end

"""
Remove Mads coverage files

$(DocumentFunction.documentfunction(cleancoverage))
"""
function cleancoverage()
	orig_dir = pwd()
	for i in madsmodules
		cd(dirname(pathof(Mads)))
		Mads.rmfiles_ext("cov")
	end
	cd(orig_dir)
end

"""
Perform Mads tests (the tests will be in parallel if processors are defined; tests use the current Mads version in the workspace; `reload("Mads.jl")` if needed)

$(DocumentFunction.documentfunction(test;
argtext=Dict("testname"=>"name of the test to execute; module or example"),
keytext=Dict("madstest"=>"test Mads [default=`true`]")))
"""
function test(testname::AbstractString=""; madstest::Bool=true, plotting::Bool=true)
	if !plotting
		ENV["MADS_NO_GADFLY"] = ""
		ENV["MADS_NO_PLOT"] = ""
	end
	graphoff()
	orig_dir = pwd()
	d = Mads.dir
	if isdir(d)
		@info("Testing Mads in $d")
	else
		d = Mads.dir
		@info("Testing Mads in $d")
	end
	if testname == ""
		madstest && include(joinpath(d, "test", "runtests.jl"))
		@info("Mads modules testing:")
		for i in madsmodules[2:end]
			testmodule(i)
		end
	else
		file = joinpath(d, "examples", testname, "runtests.jl")
		if isfile(file)
			printstyled("* $testname testing ...\n"; color=:cyan)
			@elapsed include(file)
		else
			file = joinpath(d, "test", "$testname.jl")
			if isfile(file)
				printstyled(:cyan, "* $testname testing ...\n"; color=:cyan)
				@elapsed include(file)
			else
				testmodule(testname)
			end
		end
	end
	cd(orig_dir)
	graphon()
	return nothing
end

function testmodule(testname::AbstractString="")
	printstyled("* $testname testing ...\n"; color=:cyan)
	if testname != "RobustPmap" && testname != "ReusableFunctions" && isdefined(Mads, Symbol(testname))
		m = getfield(Mads, Symbol(testname))
		file = joinpath(dirname(pathof(eval(Symbol(testname)))), "..", "test", "runtests.jl")
		if isdefined(m, :test)
			m.test()
		elseif isfile(file)
			@elapsed include(file)
		else
			@warn("Module $testname is not going to be tested!")
		end
	end
	return nothing
end