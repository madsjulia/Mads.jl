md = Mads.loadmadsfile("w01-w13a_w20a-opt.mads")
pd = Mads.getparamdict(md)
srand(2017)
for i = 1:100
	rpd = Mads.getparamrandom(md)
	mp = merge(pd, rpd)
	g = Mads.forwardgrid(md, mp)[:,:,1]
	JLD.save("set$(@sprintf "%06d" i).jld", "vx", rpd["vx"], "source_x", rpd["source1_x"], "source_y", rpd["source1_y"], "grid", g)
end