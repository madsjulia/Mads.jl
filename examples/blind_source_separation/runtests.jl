import Mads
import JLD2

import Test
import Random

Mads.veryquieton()
Mads.graphoff()

suffix = Sys.iswindows() ? "-win" : ""
suffix = Sys.islinux() ? "-linux" : suffix

Mads.@tryimport Ipopt

if !isdefined(Mads, :Ipopt) || !isdefined(Mads, :NMFipopt)
	@warn("Ipopt not available; blind source separation test (BSS) skipped!")
else
	workdir = joinpath(Mads.dir, "examples", "blind_source_separation")
	d = joinpath(workdir, "test_results")

	R = 1
	nk = 3

	Test.@testset "BSS" begin
		# Mads.@stderrcapture function reconstruct_rand(R, nk)
		Mads.seed!(2015, Random.MersenneTwister)

		s1 = rand(Mads.rng, 100)
		s2 = rand(Mads.rng, 100)
		s3 = rand(Mads.rng, 100)
		S = [s1 s2 s3]

		H = [[1,1,1] [0,2,1] [1,0,2] [1,2,0]]
		X = S * H

		Wipopt, Hipopt, pipopt = Base.redirect_stdio(stdout=Base.devnull, stderr=Base.devnull) do
			Mads.NMFipopt(X, nk, R; quiet=true)
		end
		reconstructed_X::Matrix{Float64} = Wipopt * Hipopt

		if Mads.create_tests
			Mads.mkdir(d)
			JLD2.save(joinpath(d, "rand$(suffix).jld2"), "Wipopt", Wipopt)
		end

		# NMF factors may be permuted or rescaled while preserving their product.
		Test.@test isapprox(reconstructed_X, X; atol=1e-5, rtol=0)

		# Mads.@stderrcapture function reconstruct_sin.(R, nk)
		Mads.seed!(2015, Random.MersenneTwister)
		s1 = (sin.(0.05:0.05:5) .+ 1) ./ 2
		s2 = (sin.(0.3:0.3:30) .+ 1) ./ 2
		s3 = (sin.(0.2:0.2:20) .+ 1) ./ 2

		S = [s1 s2 s3]
		H = [[1,1,1] [0,2,1] [1,0,2] [1,2,0]]

		X = S * H

		Wipopt, Hipopt, pipopt = Mads.NMFipopt(X, nk, R; quiet=true)

		reconstructed_X = Wipopt * Hipopt

		if Mads.create_tests
			Mads.mkdir(d)
			JLD2.save(joinpath(d, "sin_1$(suffix).jld2"), "Wipopt", Wipopt)
			JLD2.save(joinpath(d, "sin_2$(suffix).jld2"), "Hipopt", reconstructed_X)
		end

		Test.@test isapprox(reconstructed_X, X; atol=1e-5, rtol=0)

		# Mads.@stderrcapture function reconstruct_sin_rand(R, nk)
		Mads.seed!(2015, Random.MersenneTwister)

		s1 = (sin.(0.05:0.05:5) .+ 1) ./ 2
		s2 = (sin.(0.3:0.3:30) .+ 1) ./ 2
		s3 = rand(Mads.rng, 100)
		S = [s1 s2 s3]

		H = [[1,1,1] [0,2,1] [1,0,2] [1,2,0]]
		X = S * H

		Wipopt, Hipopt, pipopt = Mads.NMFipopt(X, nk, 1; quiet=true)

		reconstructed_X = Wipopt * Hipopt

		if Mads.create_tests
			Mads.mkdir(d)
			JLD2.save(joinpath(d, "sin_rand_1$(suffix).jld2"), "Wipopt", Wipopt)
			JLD2.save(joinpath(d, "sin_rand_2$(suffix).jld2"), "Hipopt", reconstructed_X)
		end

		Test.@test isapprox(reconstructed_X, X; atol=1e-5, rtol=0)

		# Mads.@stderrcapture function reconstruct_disturbance(R, nk)
		Mads.seed!(2015, Random.MersenneTwister)

		s1 = (sin.(0.3:0.3:30) .+ 1) ./ 2
		s2 = rand(Mads.rng, 100) .* 0.5
		s3 = rand(Mads.rng, 100)
		s3[1:50] .= 0
		s3[70:end] .= 0
		S = [s1 s2 s3]

		H = [[1,1,1] [0,2,1] [0,2,1] [1,0,2] [2,0,1] [1,2,0] [2,1,0]]
		X = S * H

		Wipopt, Hipopt, pipopt = Mads.NMFipopt(X, nk, 1; quiet=true)

		reconstructed_X = Wipopt * Hipopt

		if Mads.create_tests
			Mads.mkdir(d)
			JLD2.save(joinpath(d, "disturb_1$(suffix).jld2"), "Wipopt", Wipopt)
			JLD2.save(joinpath(d, "disturb_2$(suffix).jld2"), "Hipopt", reconstructed_X)
		end

		Test.@test isapprox(reconstructed_X, X; atol=1e-5, rtol=0)
	end
end

Mads.veryquietoff()
Mads.graphon()

:passed
