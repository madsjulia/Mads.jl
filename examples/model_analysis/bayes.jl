import Mads
import Gadfly
md = Mads.loadmadsfile("internal-polynomial.mads")
info("Bayesian analysis with different observation weights (standard deviation errors)")
info("Using initial parameter guesses:")
for w = (1000000, 1000, 1)
	Mads.setobsweights!(md, w)
	mcmcchain = Mads.bayessampling(md; nsteps=100000, burnin=1000, thinning=1, seed=2016)
	Mads.scatterplotsamples(md, mcmcchain.value', "bayes_init_w$w.png")
	r = Mads.forward(md, mcmcchain.value)
	n = length(r)
	o = hcat(map(i->collect(values(r[i])), 1:n)...)'
	@printf "Observation Weight %d StdDev %f ->`o5` prediction: min = %f max = %f\n" w 1/w min(o[:,5]...) max(o[:,5]...)
	p = Gadfly.plot(x=o[:,5], Gadfly.Guide.xlabel("o5"), Gadfly.Geom.histogram())
	Gadfly.draw(Gadfly.PNG("bayes_init_w$(w)_o5.png", 6Gadfly.inch, 4Gadfly.inch), p)
end
pinit = Dict(zip(Mads.getparamkeys(md), Mads.getparamsinit(md)))
p, r = Mads.calibrate(md)
Mads.setparamsinit!(md, p)
rm("internal-polynomial.iterationresults")
info("Using optimal parameter estimates:")
for w = (1000000, 1000, 1)
	Mads.setobsweights!(md, w)
	mcmcchain = Mads.bayessampling(md; nsteps=100000, burnin=1000, thinning=1, seed=2016)
	Mads.scatterplotsamples(md, mcmcchain.value', "bayes_opt_w$w.png")
	r = Mads.forward(md, mcmcchain.value)
	n = length(r)
	o = hcat(map(i->collect(values(r[i])), 1:n)...)'
	@printf "Observation Weight %d StdDev %f -> `o5` prediction: min = %f max = %f\n" w 1/w min(o[:,5]...) max(o[:,5]...)
	p = Gadfly.plot(x=o[:,5], Gadfly.Guide.xlabel("o5"), Gadfly.Geom.histogram())
	Gadfly.draw(Gadfly.PNG("bayes_opt_w$(w)_o5.png", 6Gadfly.inch, 4Gadfly.inch), p)
end
Mads.setparamsinit!(md, pinit)