import DocumentFunction
import Base

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
		cd(joinpath(Pkg.dir(i), "src"))
		Mads.rmfiles_ext("cov")
	end
	cd(orig_dir)
end

"""
Reload Mads modules

$(DocumentFunction.documentfunction(reload))
"""
function reload()
	for i in madsmodules[end:-1:1]
		println("* $i reloading ...")
		Base.reload(i)
	end
end

"""
Perform Mads tests (the tests will be in parallel if processors are defined; tests use the current Mads version in the workspace; `reload("Mads.jl")` if needed)

$(DocumentFunction.documentfunction(test;
argtext=Dict("testname"=>"name of the test to execute \(module or example\)"),
keytext=Dict("madstest"=>"test Mads [default=`true`]")))
"""
function test(testname::String=""; madstest::Bool=true)
	graphoff()
	orig_dir = pwd()
	if testname == ""
		madstest && include(joinpath(Pkg.dir("Mads"), "test", "runtests.jl"))
		info("Mads modules testing:")
		for i in madsmodules[2:end]
			print_with_color(:cyan, "* $i testing ...\n")
			tic()
			include(joinpath(Pkg.dir(i), "test", "runtests.jl"))
			toc()
		end
	else
		file = joinpath(Pkg.dir("Mads"), "examples", testname, "runtests.jl")
		if isfile(file)
			print_with_color(:cyan, "* $testname testing ...\n")
			tic()
			include(file)
			toc()
		else
			file = joinpath(Pkg.dir("Mads"), "test", "$testname.jl")
			if isfile(file)
				print_with_color(:cyan, "* $testname testing ...\n")
				tic()
				include(file)
				toc()
			else
				eval(Mads, :(@tryimport $(Symbol(testname))))
				if isdefined(Symbol(testname))
					print_with_color(:cyan, "* $testname testing ...\n")
					file = joinpath(Pkg.dir(testname), "test", "runtests.jl")
					if isfile(file)
						tic()
						include(file)
						toc()
					else
						warn("Test $file for module $testname is missing!")
					end
				end
			end
		end
	end
	cd(orig_dir)
	graphon()
end
