import Mads
md = Mads.loadmadsfile("w01-tensor.mads")
s = size(Mads.forwardgrid(md)[:,:,1])
nstep = 10
T = Array{Float64}(s[2],s[1],nstep)
srand(2017)
for i = 1:nstep
	md["Grid"]["time"] = i * 10
	g = Mads.forwardgrid(md)[:,:,1]
	isnan(g) = minimum(g)
	info("Time: $(md["Grid"]["time"]) Max conc $(maximum(g)) Min conc $(minimum(g))")
	T[:,:,i] = g'
end
JLD.save("tensor.jld", "T", T)