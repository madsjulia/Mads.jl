import Mads
#md = Mads.loadmadsfile("models/internal-linear.mads")
md = Mads.loadmadsfile("models/internal-polynomial3.mads")
#md = Mads.loadmadsfile("models/internal-polynomial.mads")

problem = split(Mads.getmadsrootname(md),"-")[2]

info("Problem: $(problem)")

if !isdir("uncertainty_results")
	mkdir("uncertainty_results")
end

info("Local uncertainty analysis")

info("Model calibration")
p, c = Mads.calibrate(md, save_results=false)
# selected_index = Mads.indexkeys(md["Observations"], r"o[1-3]")
pv = Mads.getoptparams(md, collect(values(p)))
f = Mads.forward(md, p)
var_scale = .5

info("Local sensitivity analysis")
lsa_results = Mads.localsa(md, datafiles=false, imagefiles=false, par=pv, obs=collect(values(f)))

info("Model parameter samping")
samples, llhoods = Mads.sampling(pv, lsa_results["jacobian"], 1000, seed=2016, scale=var_scale)

info("Model forward runs")
pred = Mads.forward(md, samples)
n = length(pred)
o = hcat(map(i->collect(values(pred[i])), 1:n)...)'
# o_s = hcat(map(i->collect(values(pred[i]))[selected_index], 1:n)...)'

info("Use importance sampling to the 95% of the solutions, keeping the most likely solutions")
newllhoods = Mads.reweightsamples(md, o, llhoods)
sortedllhoods = sort(newllhoods, rev=true)
sortedprobs = sort(exp(newllhoods), rev=true) / sum(exp(newllhoods))
cumprob = 0.
i = 1
while cumprob < .95
	cumprob += sortedprobs[i]
	i += 1
end
thresholdllhood = sortedllhoods[i - 1]
goodoprime = Array(Float64, size(o, 2), 0)
for i = 1:length(newllhoods)
	if newllhoods[i] > thresholdllhood
		goodoprime = hcat(goodoprime, vec(o[i, :]))
	end
end

info("Variance of posterior predictions (wrong)")
display(diag(lsa_results["jacobian"] * lsa_results["covar"] * lsa_results["jacobian"]')')

info("Variance of posterior predictions using all samples")
display(var(o, 1))
# display(var(o_s, 1))

info("Variance of posterior predictions using importance sampling")
display(var(goodoprime, 2)')
# display(var(goodoprime[selected_index,:], 2)')
# JLD.save("uncertainty_results/variance-important-sampling.jld", "goodoprime", goodoprime)

info("Spaghetti plot of posterior predictions")
Mads.spaghettiplot(md, o, filename="uncertainty_results/spaghetti-$(problem).png")

info("Spaghetti plot of posterior predictions using importance sampling")
Mads.spaghettiplot(md, goodoprime', filename="uncertainty_results/spaghetti-$(problem)-importance-sampling.png")

info("Histogram of `o5` predictions")
fig = Gadfly.plot(x=o[:,5], Gadfly.Guide.xlabel("o5"), Gadfly.Geom.histogram())
Gadfly.draw(Gadfly.PNG("uncertainty_results/histogram-$(problem).png", 6Gadfly.inch, 4Gadfly.inch), fig)

info("Histogram of `o5` predictions using importance sampling")
fig = Gadfly.plot(x=goodoprime'[:,5], Gadfly.Guide.xlabel("o5"), Gadfly.Geom.histogram())
Gadfly.draw(Gadfly.PNG("uncertainty_results/histogram-$(problem)-importance-sampling.png", 6Gadfly.inch, 4Gadfly.inch), fig)

info("Spaghetti plot of posterior predictions using Bayesian analysis")
Mads.setparamsinit!(md, p)
mcmcchain = Mads.bayessampling(md; nsteps=10000, burnin=1000, thinning=1, seed=2016)
pred = Mads.forward(md, mcmcchain.value)
pred = hcat(map(i->collect(values(pred[i])), 1:length(pred))...)'
Mads.spaghettiplot(md, pred, filename="uncertainty_results/spaghetti-$(problem)-bayes.png")

info("Histogram of `o5` predictions using Bayesian analysis")
fig = Gadfly.plot(x=pred[:,5], Gadfly.Guide.xlabel("o5"), Gadfly.Geom.histogram())
Gadfly.draw(Gadfly.PNG("uncertainty_results/histogram-$(problem)-bayes.png", 6Gadfly.inch, 4Gadfly.inch), fig)

info("Variance of posterior predictions using Bayesian analysis")
display(var(pred, 1))