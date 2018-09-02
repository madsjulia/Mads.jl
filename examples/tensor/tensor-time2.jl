import Mads

md = Mads.loadmadsfile("w01-tensor2.mads")
s = size(Mads.forwardgrid(md)[:,:,1])
Mads.addsource!(md; dict=Dict("t0"=>200., "x"=>1100., "y"=>1450.))
Mads.addsource!(md; dict=Dict("t0"=>400., "x"=>1200., "y"=>1550.))
nstep = 10
T = Array{Float64}(s[2],s[1],nstep)
srand(2017)
for i = 1:nstep
	md["Grid"]["time"] = i * 100
	g = Mads.forwardgrid(md)[:,:,1]
	isnan(g) = minimum(g)
	g[g.>4.e5] = 4.e5
	info("Time: $(md["Grid"]["time"]) Max conc $(maximum(g)) Min conc $(minimum(g))")
	T[:,:,i] = g'
end
JLD.save("tensor.jld", "T", T)
NTFk.plottensor(T,3)
Mads.createobservations!(md, collect(1:10:1000))
Mads.plotmatches(md; display=true)