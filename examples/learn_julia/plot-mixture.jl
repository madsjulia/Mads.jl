import DataFrames
import Gadfly
import rMF
import Mads

nsource = 3
nwell = 7
ncomponent = 5
sourcevec = map(i->"S$i", 1:nsource)

cwd = pwd()
cd(joinpath(rMF.rmfdir, "AquiferMixing"))
rMF.loaddata("test"; nw=nwell, nc=ncomponent, ns=nsource, seed=2017)
rMF.execute(nsource)
cd(cwd)

observations = DataFrames.DataFrame()

observations[:Well] = repeat(rMF.uniquewells, outer=ncomponent)
observations[:Species] = repeat(rMF.uniquespecies, inner=nwell)
observations[:Concentration] = [rMF.datamatrix...]

p = Gadfly.plot(observations, xgroup="Well", x="Species", y="Concentration", color="Species", Gadfly.Geom.subplot_grid(Gadfly.Geom.bar()))
Mads.display(p)
Gadfly.draw(Gadfly.PNG("observations.png", 10Gadfly.inch, 4Gadfly.inch, dpi=300), p)

p = Gadfly.spy(rMF.datamatrix, Gadfly.Scale.x_discrete(labels = i->rMF.uniquespecies[i]), Gadfly.Scale.y_discrete(labels = i->rMF.uniquewells[i]), Gadfly.Guide.YLabel("Wells"), Gadfly.Guide.XLabel("Species"), Gadfly.Scale.ContinuousColorScale(Gadfly.Scale.lab_gradient(Base.parse(Colors.Colorant, "green"), Base.parse(Colors.Colorant, "yellow"), Base.parse(Colors.Colorant, "red")), minvalue = 0, maxvalue = 1), Gadfly.Theme(key_position = :none))
Mads.display(p)
Gadfly.draw(Gadfly.PNG("observations-matrix.png", 1.5Gadfly.inch + 0.1Gadfly.inch * ncomponent, 1.5Gadfly.inch + 0.1Gadfly.inch * nwell, dpi=300), p)

mixer = DataFrames.DataFrame()

mixer[:Well] = repeat(rMF.uniquewells, outer=nsource)
mixer[:Sources] = repeat(sourcevec, inner=nwell)
mixer[:Ratio] = [rMF.mixers[nsource]...]

p = Gadfly.plot(mixer, xgroup="Well", x="Sources", y="Ratio", color="Sources", Gadfly.Geom.subplot_grid(Gadfly.Geom.bar(position=:stack)), Gadfly.Scale.color_discrete_manual("blue","red","green"))
display(p)
Gadfly.draw(Gadfly.PNG("mixer.png", 7Gadfly.inch, 4Gadfly.inch, dpi=300), p)

p = Gadfly.spy(rMF.mixers[nsource], Gadfly.Scale.x_discrete(labels = i->i), Gadfly.Scale.y_discrete(labels = i->rMF.uniquewells[i]), Gadfly.Guide.YLabel("Wells"), Gadfly.Guide.XLabel("Sources"), Gadfly.Scale.ContinuousColorScale(Gadfly.Scale.lab_gradient(Base.parse(Colors.Colorant, "green"), Base.parse(Colors.Colorant, "yellow"), Base.parse(Colors.Colorant, "red")), minvalue = 0, maxvalue = 1), Gadfly.Theme(key_position = :none))
Mads.display(p)
Gadfly.draw(Gadfly.PNG("mixer-matrix.png", 1.5Gadfly.inch + 0.1Gadfly.inch * nsource, 1.5Gadfly.inch + 0.1Gadfly.inch * nwell, dpi=300), p)

source = DataFrames.DataFrame()

source[:Sources] = repeat(sourcevec, outer=ncomponent)
source[:Species] = repeat(rMF.uniquespecies, inner=nsource)
source[:Concentration] = [rMF.buckets[nsource]...]

p = Gadfly.plot(source, xgroup="Sources", x="Species", y="Concentration", color="Species", Gadfly.Geom.subplot_grid(Gadfly.Geom.bar(position=:stack)))
Mads.display(p)
Gadfly.draw(Gadfly.PNG("source.png", 5Gadfly.inch, 4Gadfly.inch, dpi=300), p)

bm = rMF.buckets[nsource]
bm[bm.>1] = 1
p = Gadfly.spy(bm, Gadfly.Scale.x_discrete(labels = i->rMF.uniquespecies[i]), Gadfly.Scale.y_discrete(labels = i->i), Gadfly.Guide.YLabel("Sources"), Gadfly.Guide.XLabel("Species"), Gadfly.Scale.ContinuousColorScale(Gadfly.Scale.lab_gradient(Base.parse(Colors.Colorant, "green"), Base.parse(Colors.Colorant, "yellow"), Base.parse(Colors.Colorant, "red")), minvalue = 0, maxvalue = 1), Gadfly.Theme(key_position = :none))
Mads.display(p)
Gadfly.draw(Gadfly.PNG("source-matrix.png", 1.5Gadfly.inch + 0.1Gadfly.inch * ncomponent, 1.5Gadfly.inch + 0.1Gadfly.inch * nsource, dpi=300), p)
