import Mads
md = Mads.loadmadsfile("models/internal-polynomial.mads")

if !isdir("uncertainty_results")
	mkdir("uncertainty_results")
end

info("Local uncertainty analysis")
p, c = Mads.calibrate(md, save_results=false)
f = Mads.forward(md, p)
of = Mads.of(md, f)
l = Mads.localsa(md, datafiles=false, imagefiles=false, param=collect(values(p)), obs=collect(values(f)))
np = length(Mads.getoptparamkeys(md))
no = length(Mads.gettargetkeys(md))
dof = (no > np) ? no - np : 1
stddev_scale = of / dof
Mads.setparamsdistnormal!(md, collect(values(p)), l["stddev"] * stddev_scale)
r = Mads.parametersample(md, 100)
r = hcat(map(i->collect(values(r))[i], 1:length(p))...)'
o = Mads.forward(md, r)
n = length(o)
o = hcat(map(i->collect(values(o[i])), 1:n)...)'

info("Spaghetti plot of posterior predictions")
Mads.spaghettiplot(md, o, filename="uncertainty_results/spaghetti.png")

info("Histogram of `o5` predictions")
f = Gadfly.plot(x=o[:,5], Gadfly.Guide.xlabel("o5"), Gadfly.Geom.histogram())
Gadfly.draw(Gadfly.PNG("uncertainty_results/histogram.png", 6Gadfly.inch, 4Gadfly.inch), f)
