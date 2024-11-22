import Test

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
	if Sys.iswindows()
		Mads.fixlinks(joinpath(d, "examples"); test=false)
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
				printstyled("* $testname testing ...\n"; color=:cyan)
				@elapsed include(file)
			elseif Mads.pkginstalled(testname)
				testmodule(testname)
			else
				@warn("Unknown module or test $(testname)!")
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

function test_vector(result::AbstractVector, gold::AbstractVector; param=AbstractString="", show::Bool=false, atol::Number=0.01, _group="", _id="", _module="", _file="", _line="")
	fail_i = falses(length(gold))
	fail_result = 0.
	fail_gold = 0.
	fail_diff = 0.
	for i = eachindex(result)
		it = isapprox(result[i], gold[i]; atol=atol)
		if !it
			fail_i[i] = true
			d = abs(result[i] - gold[i])
			if fail_diff < d
				fail_gold = gold[i]
				fail_result = result[i]
				fail_diff = d
			elseif isnan(d)
				fail_gold = gold[i]
				fail_result = result[i]
				fail_diff = d
			end
		else
			@Test.test it
		end
	end
	if any(fail_i .== true)
		text = param == "" ? "Test failed" : "Test of $(param) failed"
		@warn("$(text) ($(sum(fail_i)) out of $(length(gold)); max discrepency $(fail_diff): $(fail_result) vs $(fail_gold))!", _group=_group, _id=_id, _module=_module, _file=_file, _line=_line)
		if show
			display([result[fail_i] gold[fail_i]])
		end
	end
	return fail_i
end