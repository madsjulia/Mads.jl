
import DataFrames
import Gadfly
import rMF

rMF.loaddata("test", nw=7, nc=6, ns=3)

observations = DataFrames.DataFrame()

nw = length(rMF.uniquewells)
ns = length(rMF.uniquespecies)
observations[:Well] = repeat(rMF.uniquewells, outer=ns)
observations[:Species] = repeat(rMF.uniquespecies, inner=nw)
observations[:Concentration] = [rMF.datamatrix...]

p = Gadfly.plot(observations, xgroup="Well", x="Species", y="Concentration", color="Species", Gadfly.Geom.subplot_grid(Gadfly.Geom.bar()))
Gadfly.draw(Gadfly.PNG("observations.png", 10Gadfly.inch, 4Gadfly.inch, dpi=300), p)

rMF.execute(3)

mixer = DataFrames.DataFrame()

mixer[:Well] = repeat(rMF.uniquewells, outer=3)
mixer[:Sources] = repeat(["S1", "S2", "S3"], inner=nw)
mixer[:Ratio] = [rMF.mixers[3]...]

p = Gadfly.plot(mixer, xgroup="Well", x="Sources", y="Ratio", color="Sources", Gadfly.Geom.subplot_grid(Gadfly.Geom.bar(position=:stack)), Gadfly.Scale.color_discrete_manual("blue","red","green"))
Gadfly.draw(Gadfly.PNG("mixer.png", 7Gadfly.inch, 4Gadfly.inch, dpi=300), p)

source = DataFrames.DataFrame()

source[:Sources] = repeat(["S1", "S2", "S3"], outer=ns)
source[:Species] = repeat(rMF.uniquespecies, inner=3)
source[:Concentration] = [rMF.buckets[3]...]

p = Gadfly.plot(source, xgroup="Sources", x="Species", y="Concentration", color="Species", Gadfly.Geom.subplot_grid(Gadfly.Geom.bar(position=:stack)))
Gadfly.draw(Gadfly.PNG("source.png", 5Gadfly.inch, 4Gadfly.inch, dpi=300), p)
