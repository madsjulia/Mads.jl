import Mads
import NMF
import JLD
import Base.Test
@Mads.tryimport Ipopt

if !isdefined(:Ipopt)
	warn("Ipopt not available; blind source separation test (BSS) skipped!")
else
	workdir = joinpath(Mads.madsdir, "..", "examples", "blind_source_separation")
	d = joinpath(workdir, "test_results")

	R = 1
	nk = 3

	@Base.Test.testset "BSS" begin
	# @Mads.stderrcapture function reconstruct_rand(R, nk)
		srand(2015)

		s1 = rand(100)
		s2 = rand(100)
		s3 = rand(100)
		S = [s1 s2 s3]

		H = [[1,1,1] [0,2,1] [1,0,2] [1,2,0]]
		X = S * H

		Wipopt, Hipopt, pipopt = Mads.NMFipopt(X, nk, R; quiet=true)

		if Mads.create_tests
			Mads.mkdir(d)
			JLD.save(joinpath(d, "rand.jld"), "Wipopt", Wipopt)
		end

		good_Wipopt = JLD.load(joinpath(workdir, "test_results", "rand.jld"), "Wipopt")
		@Base.Test.test isapprox(Wipopt, good_Wipopt, atol=1e-5)

	# @Mads.stderrcapture function reconstruct_sin.(R, nk)
		srand(2015)
		s1 = (sin.(0.05:0.05:5)+1)/2
		s2 = (sin.(0.3:0.3:30)+1)/2
		s3 = (sin.(0.2:0.2:20)+1)/2

		S = [s1 s2 s3]
		H = [[1,1,1] [0,2,1] [1,0,2] [1,2,0]]

		X = S * H

		Wipopt, Hipopt, pipopt = Mads.NMFipopt(X, nk, R; quiet=true)

		WHipopt = (Wipopt*Hipopt)

		if Mads.create_tests
			Mads.mkdir(d)
			JLD.save(joinpath(d, "sin_1.jld"), "Wipopt", Wipopt)
			JLD.save(joinpath(d, "sin_2.jld"), "WHipopt", WHipopt)
		end

		good_Wipopt = JLD.load(joinpath(workdir, "test_results", "sin_1.jld"), "Wipopt")
		good_WHipopt = JLD.load(joinpath(workdir, "test_results", "sin_2.jld"), "WHipopt")

		@Base.Test.test isapprox(Wipopt, good_Wipopt, atol=1e-5)
		@Base.Test.test isapprox(WHipopt, good_WHipopt, atol=1e-5)

	# @Mads.stderrcapture function reconstruct_sin_rand(R, nk)
		srand(2015)

		s1 = (sin.(0.05:0.05:5)+1)/2
		s2 = (sin.(0.3:0.3:30)+1)/2
		s3 = rand(100)
		S = [s1 s2 s3]

		H = [[1,1,1] [0,2,1] [1,0,2] [1,2,0]]
		X = S * H

		Wipopt, Hipopt, pipopt = Mads.NMFipopt(X, nk, 1; quiet=true)

		WHipopt = (Wipopt*Hipopt)

		if Mads.create_tests
			Mads.mkdir(d)
			JLD.save(joinpath(d, "sin_rand_1.jld"), "Wipopt", Wipopt)
			JLD.save(joinpath(d, "sin_rand_2.jld"), "WHipopt", WHipopt)
		end

		good_Wipopt = JLD.load(joinpath(workdir, "test_results", "sin_rand_1.jld"), "Wipopt")
		good_WHipopt = JLD.load(joinpath(workdir, "test_results", "sin_rand_2.jld"), "WHipopt")

		@Base.Test.test isapprox(Wipopt, good_Wipopt, atol=1e-5)
		@Base.Test.test isapprox(WHipopt, good_WHipopt, atol=1e-5)

	# @Mads.stderrcapture function reconstruct_disturbance(R, nk)
		srand(2015)

		s1 = (sin.(0.3:0.3:30)+1)/2
		s2 = rand(100) * 0.5
		s3 = rand(100)
		s3[1:50] = 0
		s3[70:end] = 0
		S = [s1 s2 s3]

		H = [[1,1,1] [0,2,1] [0,2,1] [1,0,2] [2,0,1] [1,2,0] [2,1,0]]
		X = S * H

		Wipopt, Hipopt, pipopt = Mads.NMFipopt(X, nk, 1; quiet=true)

		WHipopt = (Wipopt*Hipopt)

		if Mads.create_tests
			Mads.mkdir(d)
			JLD.save(joinpath(d, "disturb_1.jld"), "Wipopt", Wipopt)
			JLD.save(joinpath(d, "disturb_2.jld"), "WHipopt", WHipopt)
		end

		good_Wipopt = JLD.load(joinpath(workdir, "test_results", "disturb_1.jld"), "Wipopt")
		good_WHipopt = JLD.load(joinpath(workdir, "test_results", "disturb_2.jld"), "WHipopt")

		@Base.Test.test isapprox(Wipopt, good_Wipopt, atol=1e-5)
		@Base.Test.test isapprox(WHipopt, good_WHipopt, atol=1e-5)
	end
end