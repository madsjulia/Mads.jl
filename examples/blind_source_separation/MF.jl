import Mads
@Mads.tryimport NMFk

nk = 3
s1 = sin(0.05:0.05:5)+1
s2 = sin(0.1:0.1:10)+1
s3 = sin(0.2:0.2:20)+1

S = [s1 s2 s3]
Mads.plotseries(S, "sin_original_sources.svg", title="Original sources", name="Source", combined=true)

# X = [s1+s2+s3 s1+s2*2 s1+s2 s1+3*s3]
X = [s2 s1 s2+s1]
# X = [s1 s1*10 s2 s2*5 s1+s2*2 s3 s3+s2]
Mads.plotseries(X, "sin_mixed_signals.svg", title="Mixed signals", name="Signal", combined=true)

if isdefined(:NMFk)
	W, H, p, s = NMFk.execute(X, 30, nk)
end

if isdefined(:NMFk)
	W, H, p, s = NMFk.execute(X, 30, nk; mixmatch=true, quiet=true, regularizationweight=1e-3)
end

Wlm, Hlm, plm = Mads.MFlm(X, nk)
Mads.plotseries(Wlm, "sin_unmixed_sources.svg", title="Reconstruncted sources", name="Source", combined=true)

srand(2015)
nk = 3
s1 = rand(nS)
s2 = rand(nS)
s3 = rand(nS)

S = [s1 s2 s3]
Mads.plotseries(S, "rand_original_sources.svg", title="Original sources", name="Source", combined=false)

# X = [s1+s2+s3 s1+s2*2 s1+s2 s1+3*s3]
# X = [s2 s1]
X = [s1 s1*10 s2 s2*5 s1+s2*2 s3 s3+s2]
Mads.plotseries(X, "rand_mixed_signals.svg", title="Mixed signals", name="Signal", combined=false)

if isdefined(:NMFk)
	W, H, p, s = NMFk.execute(X, 30, nk)
end

if isdefined(:NMFk)
	W, H, p, s = NMFk.execute(X, 30, nk; mixmatch=true, quiet=true, regularizationweight=1e-3)
end

Wlm, Hlm, plm = Mads.MFlm(X, nk)
Mads.plotseries(Wlm, "rand_unmixed_sources.svg", title="Reconstruncted sources", name="Source", combined=false)
