import Mads
md = Mads.loadmadsfile("w01-w13a_w20a-opt-tensor.mads")
pd = Mads.getparamdict(md)
s = size(Mads.forwardgrid(md, pd)[:,:,1])
nstep = 10
T = Array{Float64}(s[1],s[2],nstep)
srand(2017)
for i = 1:nstep
	md["Grid"]["time"] = i * 0.02
	g = Mads.forwardgrid(md, pd)[:,:,1]
	isnan(g) = minimum(g)
	@show maximum(g)
	T[:,:,i] = g
end
JLD.save("tensor.jld", "T", T)