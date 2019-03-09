import DocumentFunction

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
function test(testname::String=""; madstest::Bool=true, plotting::Bool=true)
	if !plotting
		ENV["MADS_NO_GADFLY"] = ""
		ENV["MADS_NO_PLOT"] = ""
	end
	graphoff()
	orig_dir = pwd()
	d = Mads.madsdir
	if isdir(d)
		@info("Testing Mads in $d")
	else
		d = Mads.madsdir
		@info("Testing Mads in $d")
	end
	if testname == ""
		madstest && include(joinpath(d, "test", "runtests.jl"))
		@info("Mads modules testing:")
		for i in madsmodules[2:end]
			printstyled("* $i testing ...\n", color=:cyan)
			@elapsed include(joinpath(dirname(pathof(eval(Symbol(i)))), "..", "test", "runtests.jl"))
		end
	else
		file = joinpath(d, "examples", testname, "runtests.jl")
		if isfile(file)
			printstyled("* $testname testing ...\n", color=:cyan)
			@elapsed include(file)
		else
			file = joinpath(d, "test", "$testname.jl")
			if isfile(file)
				printstyled(:cyan, "* $testname testing ...\n", color=:cyan)
				@elapsed include(file)
			else
				Core.eval(Mads, :(@tryimport $(Symbol(testname))))
				if isdefined(Mads, Symbol(testname))
					printstyled("* $testname testing ...\n", color=:cyan)
					file = joinpath(dirname(pathof(eval(Symbol(testname)))), "..", "test", "runtests.jl")
					if isfile(file)
						@elapsed include(file)
					else
						@warn("Test $file for module $testname is missing!")
					end
				end
			end
		end
	end
	cd(orig_dir)
	graphon()
	nothing
end
