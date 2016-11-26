"Execute Mads tests using Julia Pkg.test (the default Pkg.test in Julia is executed in serial)"
function testj(coverage::Bool=false)
	orig_dir = pwd()
	for i in madsmodules
		Pkg.test(i; coverage=coverage)
	end
	cd(orig_dir)
end

"Remove Mads coverage files"
function cleancoverage()
	orig_dir = pwd()
	for i in madsmodules
		cd(joinpath(Pkg.dir(i), "src"))
		run(`bash -c "rm -f *.cov"`)
	end
	cd(orig_dir)
end

"Reload Mads modules"
function reload()
	for i in madsmodules[end:-1:1]
		println("* $i reloading ...")
		Base.reload(i)
	end
end

"Execute Mads tests (the tests will be in parallel if processors are defined)"
function test(testmod::String="")
	orig_dir = pwd()
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
		elseif isdefined(Symbol(testmod))
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
	cd(orig_dir)
end