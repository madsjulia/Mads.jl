import DataFrames
import Gadfly
import rMF

cwd = pwd()

nsource = 15
nw = 100
nc = 30
sourcevec = map(i->"S$i", 1:nsource)

cd(joinpath(rMF.rmfdir, "AquiferMixing"))
rMF.loaddata("test"; nw=nw, nc=nc, ns=nsource, seed=2017)
rMF.execute(nsource)
cd(cwd)

observations = DataFrames.DataFrame()

nw = length(rMF.uniquewells)
ns = length(rMF.uniquespecies)
observations[:Well] = repeat(rMF.uniquewells, outer=ns)
observations[:Species] = repeat(rMF.uniquespecies, inner=nw)
observations[:Concentration] = [rMF.datamatrix...]

p = Gadfly.plot(observations, xgroup="Well", x="Species", y="Concentration", color="Species", Gadfly.Geom.subplot_grid(Gadfly.Geom.bar()))
Mads.display(p)
Gadfly.draw(Gadfly.PNG("observations.png", 10Gadfly.inch, 4Gadfly.inch, dpi=300), p)

p = Gadfly.spy(rMF.datamatrix, Gadfly.Scale.x_discrete(labels = i->rMF.uniquespecies[i]), Gadfly.Scale.y_discrete(labels = i->rMF.uniquewells[i]), Gadfly.Guide.YLabel("Wells"), Gadfly.Guide.XLabel("Species"), Gadfly.Scale.ContinuousColorScale(Gadfly.Scale.lab_gradient(parse(Colors.Colorant, "green"), parse(Colors.Colorant, "yellow"), parse(Colors.Colorant, "red")), minvalue = 0, maxvalue = 1), Gadfly.Theme(key_position = :none))
Mads.display(p)
Gadfly.draw(Gadfly.PNG("observations-matrix.png", 1Gadfly.inch * ns, 1Gadfly.inch * nw, dpi=300), p)

mixer = DataFrames.DataFrame()

mixer[:Well] = repeat(rMF.uniquewells, outer=nsource)
mixer[:Sources] = repeat(sourcevec, inner=nw)
mixer[:Ratio] = [rMF.mixers[nsource]...]

p = Gadfly.plot(mixer, xgroup="Well", x="Sources", y="Ratio", color="Sources", Gadfly.Geom.subplot_grid(Gadfly.Geom.bar(position=:stack)), Gadfly.Scale.color_discrete_manual("blue","red","green"))
display(p)
Gadfly.draw(Gadfly.PNG("mixer.png", 7Gadfly.inch, 4Gadfly.inch, dpi=300), p)

p = Gadfly.spy(rMF.mixers[nsource], Gadfly.Scale.x_discrete(labels = i->i), Gadfly.Scale.y_discrete(labels = i->rMF.uniquewells[i]), Gadfly.Guide.YLabel("Wells"), Gadfly.Guide.XLabel("Sources"), Gadfly.Scale.ContinuousColorScale(Gadfly.Scale.lab_gradient(parse(Colors.Colorant, "green"), parse(Colors.Colorant, "yellow"), parse(Colors.Colorant, "red")), minvalue = 0, maxvalue = 1), Gadfly.Theme(key_position = :none))
Mads.display(p)
Gadfly.draw(Gadfly.PNG("mixer-matrix.png", 1Gadfly.inch * nsource, 1Gadfly.inch * nw, dpi=300), p)

source = DataFrames.DataFrame()

source[:Sources] = repeat(sourcevec, outer=ns)
source[:Species] = repeat(rMF.uniquespecies, inner=nsource)
source[:Concentration] = [rMF.buckets[nsource]...]

p = Gadfly.plot(source, xgroup="Sources", x="Species", y="Concentration", color="Species", Gadfly.Geom.subplot_grid(Gadfly.Geom.bar(position=:stack)))
Mads.display(p)
Gadfly.draw(Gadfly.PNG("source.png", 5Gadfly.inch, 4Gadfly.inch, dpi=300), p)

bm = rMF.buckets[nsource]
bm[bm.>1] = 1
p = Gadfly.spy(bm, Gadfly.Scale.x_discrete(labels = i->rMF.uniquespecies[i]), Gadfly.Scale.y_discrete(labels = i->i), Gadfly.Guide.YLabel("Sources"), Gadfly.Guide.XLabel("Species"), Gadfly.Scale.ContinuousColorScale(Gadfly.Scale.lab_gradient(parse(Colors.Colorant, "green"), parse(Colors.Colorant, "yellow"), parse(Colors.Colorant, "red")), minvalue = 0, maxvalue = 1), Gadfly.Theme(key_position = :none))
Mads.display(p)
Gadfly.draw(Gadfly.PNG("source-matrix.png", 1Gadfly.inch * ns, 1Gadfly.inch * nsource, dpi=300), p)
