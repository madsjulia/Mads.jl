import Mads
@tryimport NMFk

srand(2015)
nS = 100
nk = 3
a = rand(nS)
b = rand(nS)
c = rand(nS)
X = [a a*10 b b*5 a+b*2 c c+b]

if isdefined(:NMFk)
	W, H, p, s = NMFk.execute(X, 30, nk)
end

if isdefined(:NMFk)
	W, H, p, s = NMFk.execute(X, 30, nk; mixmatch=true, quiet=true, regularizationweight=1e-3)
end

Wlm, Hlm, plm = Mads.MFlm(X, nk)
[Wlm * Hlm X]
