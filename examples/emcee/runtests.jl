import Mads
import AffineInvariantMCMC
import Base.Test

srand(0)

numdims = 5
numwalkers = 100
thinning = 10
numsamples_perwalker = 1000
burnin = 100

@Mads.stderrcapture function testemcee()
	const stds = exp(5 * randn(numdims))
	const means = 1 + 5 * rand(numdims)
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
	return flatchain, means, stds
end

@Base.Test.testset "Emcee" begin
	for _ in 1:10
		flatchain, means, stds = testemcee()
		@Base.Test.testset "AffineInvariantMCMC" begin
			for i = 1:numdims
				@Base.Test.test isapprox(mean(flatchain[i, :]), means[i], atol=(0.1*stds[i]))
			end
		end
	end
end
:passed