import Mads

Random.seed!(2016)
workdir = joinpath(Mads.madsdir, "examples", "anasol")

md = Mads.loadmadsfile(joinpath(workdir, "w01short3.mads"))
Mads.createobservations!(md, collect(0:0.1:50))
Mads.plotmatches(md; plotdata=false, filename="plume_observations.png", notitle=true, xtitle="", hsize=8Gadfly.inch, vsize=4Gadfly.inch, ymax=5000, noise=400, dpi=600, colors=["blue", "red", "green"], separate_files=true, display=true)

md1 = Mads.loadmadsfile(joinpath(workdir, "w01short3.mads"))
Mads.createobservations!(md1, collect(0:0.1:50))
Mads.removesource!(md1, 2)
Mads.plotmatches(md1; plotdata=false, filename="plume_source1.png", notitle=true, xtitle="", hsize=8Gadfly.inch, vsize=4Gadfly.inch, ymax=5000, dpi=600, colors=["blue", "red", "green"], noise=15, separate_files=true, display=true)

md2 = Mads.loadmadsfile(joinpath(workdir, "w01short3.mads"))
Mads.createobservations!(md2, collect(0:0.1:50))
Mads.removesource!(md2, 1)
Mads.plotmatches(md2; plotdata=false, filename="plume_source2.png", notitle=true, xtitle="", hsize=8Gadfly.inch, vsize=4Gadfly.inch, ymax=5000, dpi=600, colors=["blue", "red", "green"], noise=50, separate_files=true, display=true)
