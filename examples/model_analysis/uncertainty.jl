import Mads
# md = Mads.loadmadsfile("models/internal-linear.mads")
md = Mads.loadmadsfile("models/internal-polynomial.mads")

if !isdir("uncertainty_results")
	mkdir("uncertainty_results")
end

info("Local uncertainty analysis")
p, c = Mads.calibrate(md, save_results=false)
f = Mads.forward(md, p)
of = Mads.of(md, f)
np = length(Mads.getoptparamkeys(md))
no = length(Mads.gettargetkeys(md))
dof = (no > np) ? no - np : 1
l = Mads.localsa(md, datafiles=false, imagefiles=false, param=collect(values(p)), obs=collect(values(f)))
covar = l["covar"]
J = l["jacobian"]
sp1 = diag(J * covar * J')
@show sp1
stddev_scale = (of != 0) ? of / dof : 1 
Mads.setparamsdistnormal!(md, collect(values(p)), l["stddev"] * stddev_scale)
r = Mads.parametersample(md, 100)
r = hcat(map(i->collect(values(r))[i], 1:length(p))...)'
try
	d = Distributions.MvNormal(collect(values(p)), covar)
	samples = Distributions.rand(d, 1000);
catch
	samples = r
end
o = Mads.forward(md, samples)
n = length(o)
o = hcat(map(i->collect(values(o[i])), 1:n)...)'

sp2 = std(o, 1)
@show sp2

info("Spaghetti plot of posterior predictions")
Mads.spaghettiplot(md, o, filename="uncertainty_results/spaghetti.png")

info("Histogram of `o5` predictions")
f = Gadfly.plot(x=o[:,5], Gadfly.Guide.xlabel("o5"), Gadfly.Geom.histogram())
Gadfly.draw(Gadfly.PNG("uncertainty_results/histogram.png", 6Gadfly.inch, 4Gadfly.inch), f)
