import Mads
import AffineInvariantMCMC
import Base.Test
import ProgressMeter

srand(2017)

numdims = 5
numwalkers = 100
thinning = 10
numsamples_perwalker = 1000
burnin = 100

@Base.Test.testset "Emcee" begin
	@ProgressMeter.showprogress 1 "Computing Affine Invariant MCMC ..." for _ in 1:3
		stds = exp.(5 * randn(numdims))
		means = 1 + 5 * rand(numdims)
		llhood = x->begin
			retval = 0.
			for i in 1:length(x)
				retval -= .5 * ((x[i] - means[i]) / stds[i]) ^ 2
			end
			return retval
		end

		x0 = rand(numdims, numwalkers) * 10 - 5
		chain, llhoodvals = AffineInvariantMCMC.sample(llhood, numwalkers, x0, burnin, 1)
		chain, llhoodvals = AffineInvariantMCMC.sample(llhood, numwalkers, chain[:, :, end], numsamples_perwalker, thinning)
		flatchain, flatllhoodvals = AffineInvariantMCMC.flattenmcmcarray(chain, llhoodvals)
		for i = 1:numdims
			@Base.Test.test isapprox(mean(flatchain[i, :]), means[i], atol=(0.5 * stds[i]))
			@Base.Test.test isapprox(std(flatchain[i, :]), stds[i], atol=(5 * stds[i]))
		end
	end
end
:passed