import Mads
#md = Mads.loadmadsfile("models/internal-linear.mads")
#md = Mads.loadmadsfile("models/internal-polynomial3.mads")
md = Mads.loadmadsfile("models/internal-polynomial.mads")

problem = split(Mads.getmadsrootname(md),"-")[2]

info("Problem: $(problem)")

if !isdir("uncertainty_results")
	mkdir("uncertainty_results")
end
info("Local uncertainty analysis")
# Mads.setobsweights!(md, 10)
p, c = Mads.calibrate(md, save_results=false)
pv = collect(values(p))
f = Mads.forward(md, p)
of = Mads.of(md, f)
np = length(Mads.getoptparamkeys(md))
no = length(Mads.gettargetkeys(md))
dof = (no > np) ? no - np : 1
w = Mads.getobsweight(md)
det_w = prod(w)
ln_det_w = log(det_w)
gf = of / dof
println("Posterior measurement variance                         : $(gf)")
ln_det_v = ln_det_w + no * log(sqrt(gf))
l = Mads.localsa(md, datafiles=false, imagefiles=false, param=pv, obs=collect(values(f)))
aopt = sum(diag(l["covar"]))
copt = abs(l["eigenvalues"][end])/abs(l["eigenvalues"][1])
eopt = abs(l["eigenvalues"][end])
dopt = prod(l["eigenvalues"])
println("Optimality criteria based on covariance matrix of observation errors:")
println("A-optimality (matrix trace)                            : $(aopt)")
println("C-optimality (matrix conditioning number)              : $(copt)")
println("E-optimality (matrix maximum eigenvalue)               : $(eopt)")
println("D-optimality (matrix determinant)                      : $(dopt)")
println("Determinant of covariance matrix of observation errors : ln(det S) = $(log(dopt))")
println("Determinant of observation weight matrix               : ln(det W) = $(ln_det_w)")
println("Determinant of covariance matrix of measurement errors : ln(det V) = $(ln_det_v)")

sml = dof + ln_det_v + no * 1.837877
aic = sml + 2 * np
bic = sml + np * log(no)
aicc = sml + 2 * np * log(log(no))
kic = sml + np * log(no * 0.159154943) - log(dopt)
println("Log likelihood function                            : $(-sml/2)")
println("Maximum likelihood                                 : $(sml)")
println("AIC  (Akaike   Information Criterion)              : $(aic)")
println("AICc (Akaike   Information Criterion + correction) : $(aicc)")
println("BIC  (Bayesian Information Criterion)              : $(bic)")
println("KIC  (Kashyap  Information Criterion)              : $(kic)")
#var_scale = no / sum(w) + gf
var_scale = .5
#=
covar = l["covar"] .* var_scale
display(l["jacobian"])
display(l["stddev"]) 
@show log(det(covar))
@show var_scale
=#
samples, llhoods = Mads.sampling(pv, l["jacobian"], 1000, seed=2016, scale=var_scale)
#Mads.setparamsdistnormal!(md, collect(values(p)), l["stddev"] * stddev_scale)
#r = Mads.parametersample(md, 100)
#r = hcat(map(i->collect(values(r))[i], 1:length(p))...)'
o = Mads.forward(md, samples)
n = length(o)
o = hcat(map(i->collect(values(o[i])), 1:n)...)'

#use the importance sampling to the 95% of the solutions, keeping the most likely solutions
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


sp2 = var(o, 1)
@show sp2

info("Spaghetti plot of posterior predictions")
Mads.spaghettiplot(md, o, filename="uncertainty_results/spaghetti-$(problem).png")
info("Spaghetti plot of posterior predictions with importance sampling")
Mads.spaghettiplot(md, goodoprime', filename="uncertainty_results/spaghetti-importance-$(problem).png")

info("Histogram of `o5` predictions")
fig = Gadfly.plot(x=o[:,5], Gadfly.Guide.xlabel("o5"), Gadfly.Geom.histogram())
Gadfly.draw(Gadfly.PNG("uncertainty_results/histogram-$(problem).png", 6Gadfly.inch, 4Gadfly.inch), fig)
info("Histogram of `o5` predictions")
fig = Gadfly.plot(x=goodoprime'[:,5], Gadfly.Guide.xlabel("o5"), Gadfly.Geom.histogram())
Gadfly.draw(Gadfly.PNG("uncertainty_results/histogram-importance-$(problem).png", 6Gadfly.inch, 4Gadfly.inch), fig)

info("Spaghetti plot of posterior predictions using Bayesian analysis")
Mads.setparamsinit!(md, p)
mcmcchain = Mads.bayessampling(md; nsteps=10000, burnin=1000, thinning=1, seed=2016)
pred = Mads.forward(md, mcmcchain.value)
pred = hcat(map(i->collect(values(pred[i])), 1:length(pred))...)'
Mads.spaghettiplot(md, pred, filename="uncertainty_results/spaghetti-$(problem)-bayes.png")
fig = Gadfly.plot(x=pred[:,5], Gadfly.Guide.xlabel("o5"), Gadfly.Geom.histogram())
Gadfly.draw(Gadfly.PNG("uncertainty_results/histogram-$(problem)-bayes.png", 6Gadfly.inch, 4Gadfly.inch), fig)
