import Mads
import AffineInvariantMCMC
import Test
import Random
import ProgressMeter
import Statistics

Mads.seed!(2017, Random.MersenneTwister)

Mads.veryquieton()
Mads.graphoff()

numdims = 5
numwalkers = 100
thinning = 10
numsamples_perwalker = 1000
burnin = 100

Test.@testset "Emcee" begin
	ProgressMeter.@showprogress 1 "Computing Affine Invariant MCMC ..." for _ in 1:3
		stds = exp.(5 .* randn(Mads.rng, numdims))
		means = 1 .+ 5 .* rand(Mads.rng, numdims)
		llhood = x->begin
			retval = 0.
			for i = eachindex(x)
				retval -= .5 * ((x[i] - means[i]) / stds[i]) ^ 2
			end
			return retval
		end
		xemcee0 = rand(numdims, numwalkers) .* 10 .- 5
		chain, llhoodvals = AffineInvariantMCMC.sample(llhood, numwalkers, xemcee0, burnin, 1)
		chain, llhoodvals = AffineInvariantMCMC.sample(llhood, numwalkers, chain[:, :, end], numsamples_perwalker, thinning)
		flatchain, flatllhoodvals = AffineInvariantMCMC.flattenmcmcarray(chain, llhoodvals)
		for i = 1:numdims
			Test.@test isapprox(Statistics.mean(flatchain[i, :]), means[i], atol=(0.5 * stds[i]))
			Test.@test isapprox(Statistics.std(flatchain[i, :]), stds[i], atol=(5 * stds[i]))
		end
	end
end

Mads.veryquietoff()
Mads.graphon()

:passed