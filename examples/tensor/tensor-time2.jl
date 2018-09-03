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
JLD.save("tensor2.jld", "T", T)
NTFk.plottensor(T,3)

Mads.createobservations!(md, collect(0:10:1000))
Mads.plotmatches(md; display=true)

Mads.setobservationtargets!(md, Mads.forward(md))
wt = Mads.getwelltargets(md)
M = hcat(wt...)
M = M./maximum(M)

V = Vector{Matrix{Float64}}(0)
for i = 1:3
	mdo = deepcopy(md)
	for s = 3:-1:1
		if s == i
			continue
		else
			Mads.removesource!(mdo, s)
		end
	end
	warn("Source starting at $(mdo["Sources"][1]["gauss"]["t0"]["init"])")
	Mads.plotmatches(mdo; display=true)
	Mads.setobservationtargets!(mdo, Mads.forward(mdo))
	wt = Mads.getwelltargets(mdo)
	M = hcat(wt...)
	M = M./maximum(M)
	push!(V, M)
end

C = reshape(hcat(V...), (101,9,3))
W = C ./ maximum(sum(C, 3)) .* 0.5

rMF.loaddata("test", ns=3, nc=4, nw=9, nt=101, seed=5)
Ht = deepcopy(rMF.truebucket)
B = minimum(Ht,1) .- 4

T = zeros(Float32, 9,4,101);
for t = 1:101
	for w = 1:9
		for s = 1:3
			T[w,:,t] += W[t,w,s] * Ht[s,:]
		end
		# T[w,:,t] += (1-sum(W[t,w,:])) .* B'
	end
end

Mads.plotseries(T[:,1,:]')
Mads.plotseries(T[:,2,:]')
Mads.plotseries(T[:,3,:]')
Mads.plotseries(T[:,4,:]')

We, He, of = NMFk.execute(T, 2:5, 10; maxouteriters=1000, tol=1e-7, tolX=1e-7)
for i=2:5
	Xe = NMFk.mixmatchcompute(X, We[i], He[i])
	info("Norm($i): $(vecnorm(Xe .- T))")
end

NTFk.plot2d(permutedims(T, (1,3,2)), permutedims(Xe, (1,3,2)))