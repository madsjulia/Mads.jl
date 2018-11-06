import Test

cwd = pwd()
workdir = joinpath(Mads.madsdir, "examples", "embed_c")
cd(workdir)

@Mads.stderrcapture if Sys.isapple()
	const embed_c_mylib = joinpath(workdir, "libmy.dylib")
elseif Sys.islinux()
	const embed_c_mylib = joinpath(workdir, "libmy.so")
else
	const embed_c_mylib = ""
end

if embed_c_mylib == ""
	@warn("embed_c test is skipped!")
else
	# Build the C library if it doesn't exist
	if isfile(joinpath(workdir, embed_c_mylib)) != true
		run(`make`)
	end

	@Test.testset "Calling C" begin
		if isfile(joinpath(workdir, embed_c_mylib))
			global d = 4.
			n = 5
			function fcsqrt(d)
				ccall( (:my_c_sqrt, embed_c_mylib), Float64, (Float64,), d )
			end

			@Test.test fcsqrt(d) ≈ sqrt(d)

			function fcfunc_ex1(n, d)
				ccall( (:my_c_func_ex1, embed_c_mylib), Float64, (Int64, Float64), n, d )
			end

			r = 0
			for i = 1:n
				r += i / d
			end

			@Test.test fcfunc_ex1(n,d) ≈ r
		else
			@warn("C library does not exist!")
		end
	end
end

cd(cwd)

:passed