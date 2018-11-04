import Mads
import Gadfly
import Printf
md = Mads.loadmadsfile(joinpath("models", "internal-polynomial.mads"))

Mads.mkdir("emcee_results")

@info("AffineInvariantMCMC (EMCEE) Bayesian analysis with different number of walkers:")
for nw = (100, 50, 20, 10, 5, 1)
	Mads.setobsweights!(md, 1000000)
	@time chain, llhoods  = Mads.emceesampling(md; numwalkers=nw, nsteps=1000000, burnin=100000, thinning=100, seed=2016)
	Mads.scatterplotsamples(md, chain', "emcee_results/emcee_init_nw$nw.png")
	o = Mads.forward(md, chain')
	Mads.spaghettiplot(md, o, filename="emcee_results/emcee_init_nw$(nw)_spaghetti.png")
	@Printf.printf "Init: Number of walkers %d ->`o5` prediction: min = %f max = %f\n" nw min(o[:,5]...) max(o[:,5]...)
	f = Gadfly.plot(x=o[:,5], Gadfly.Guide.xlabel("o5"), Gadfly.Geom.histogram())
	Gadfly.draw(Gadfly.PNG("emcee_results/emcee_init_nw$(nw)_o5.png", 6Gadfly.inch, 4Gadfly.inch), f)
end