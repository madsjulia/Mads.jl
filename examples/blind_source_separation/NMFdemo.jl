import Mads
import NMF
@Mads.tryimport MixMatch

Mads.madsinfo("Reconstruction of random signals ...")
srand(2015)
nk = 2
s1 = rand(100)
s2 = rand(100)
S = [s1 s2]
Mads.plotseries(S, "rand_original_sources.svg", title="Original sources", name="Source", combined=false)
X = [s1+s2 s1*3+s2 s1+s2*2]
Mads.plotseries(X, "rand_mixed_signals.svg", title="Mixed signals", name="Signal", combined=false)
Mads.madsinfo("Reconstruction of random signals using NMF ...")
Wnmf, Hnmf, pnmf = Mads.NMFm(X, nk)
Mads.plotseries(Wnmf, "rand_unmixed_sources_nmf.svg", title="Unmixed sources", name="Source", combined=false)
if isdefined(:MixMatch)
	Mads.madsinfo("Reconstruction of random signals using MixMatch ...")
	Wmm, Hmm, pmm = MixMatch.matchdata(X, nk)
	Mads.plotseries(Wmm, "rand_unmixed_sources_nmfmm.svg", title="Unmixed sources", name="Source", combined=false)
end
Mads.madsinfo("Reconstruction of random signals using LM ...")
Wlm, Hlm, plm = Mads.MFlm(X, nk)
Mads.plotseries(Wlm, "rand_unmixed_sources_nmflm.svg", title="Unmixed sources", name="Source", combined=false)

Mads.madsinfo("Reconstruction of sin signals ...")
nk = 2
s1 = sin(0.05:0.05:5)+1
s2 = sin(0.3:0.3:30)+1
# s3 = sin(0.2:0.2:20)+1
S = [s1 s2]
Mads.plotseries(S, "sin_original_sources.svg", title="Original sources", name="Source", combined=true)
X = [s1+s2 s1*3+s2 s1+s2*2]
Mads.plotseries(X, "sin_mixed_signals.svg", title="Mixed signals", name="Signal", combined=true)
Mads.madsinfo("Reconstruction of random signals using NMF ...")
Wnmf, Hnmf, pnmf = Mads.NMFm(X, nk)
Mads.plotseries(Wnmf, "sin_unmixed_sources_nmf.svg", title="Unmixed sources", name="Source", combined=true)
Mads.plotseries(Wnmf * Hnmf, "sin_reproduced_signals_nmf.svg", title="Reproduced signals", name="Signal", combined=true)
if isdefined(:MixMatch)
	Mads.madsinfo("Reconstruction of random signals using MixMatch ...")
	Wmm, Hmm, pmm = MixMatch.matchdata(X, nk)
	Mads.plotseries(Wmm, "sin_unmixed_sources_nmfmm.svg", title="Unmixed sources", name="Source", combined=true)
	Mads.plotseries(Wmm * Hmm, "sin_reproduced_signals_nmfmm.svg", title="Reproduced signals", name="Signal", combined=true)
end
Mads.madsinfo("Reconstruction of random signals using LM ...")
Wlm, Hlm, plm = Mads.MFlm(X, nk)
Mads.plotseries(Wlm, "sin_unmixed_sources_nmflm.svg", title="Unmixed sources", name="Source", combined=true)
Mads.plotseries(Wlm * Hlm, "sin_reproduced_signals_nmflm.svg", title="Reproduced signals", name="Signal", combined=true)

Mads.madsinfo("Reconstruction of exp/sin signals ...")
nk = 2
s1 = exp(-(0.1:0.1:10)) * 20
s2 = 10 + sin(0.1:0.1:10) * 10
S = [s1 s2]
Mads.plotseries(S, "sig_original_sources.svg", title="Original sources", name="Source", combined=true)
X = [s1+s2 s1*3+s2 s1+s2*2]
Mads.plotseries(X, "sig_mixed_signals.svg", title="Mixed signals", name="Signal", combined=true)
Mads.madsinfo("Reconstruction of exp/sin signals using NMF ...")
Wnmf, Hnmf, pnmf = Mads.NMFm(X, nk)
Mads.plotseries(Wnmf, "sig_unmixed_sources_nmf.svg", title="Unmixed sources", name="Source", combined=true)
Mads.plotseries(Wnmf * Hnmf, "sig_reproduced_signals_nmf.svg", title="Reproduced signals", name="Signal", combined=true)
if isdefined(:MixMatch)
	Mads.madsinfo("Reconstruction of exp/sin signals using MixMatch ...")
	Wmm, Hmm, pmm = MixMatch.matchdata(X, nk)
	Mads.plotseries(Wmm, "sig_unmixed_sources_nmfmm.svg", title="Unmixed sources", name="Source", combined=true)
	Mads.plotseries(Wmm * Hmm, "sig_reproduced_signals_nmfmm.svg", title="Reproduced signals", name="Signal", combined=true)
end
Mads.madsinfo("Reconstruction of exp/sin signals using LM ...")
Wlm, Hlm, plm = Mads.MFlm(X, nk)
Mads.plotseries(Wlm, "sig_unmixed_sources_nmflm.svg", title="Unmixed sources", name="Source", combined=true)
Mads.plotseries(Wlm * Hlm, "sig_reproduced_signals_nmflm.svg", title="Reproduced signals", name="Signal", combined=true)
