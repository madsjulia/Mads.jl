import Mads
import Gadfly
import NMF

R=1

@info("Reconstruction of random signals ...")
Random.seed!(2015)
nk = 3
s1 = rand(100)
s2 = rand(100)
s3 = rand(100)
S = [s1 s2 s3]
Mads.plotseries(S, "rand_original_signals.svg", title="Original signals", name="Signal", combined=false)
H = [[1,1,1] [0,2,1] [1,0,2] [1,2,0]]
X = S * H
Mads.plotseries(X, "rand_mixed_observations.svg", title="Mixed observations", name="Observation", combined=false)
info("Reconstruction of random signals using NMF ...")
Wnmf, Hnmf, pnmf = Mads.NMFm(X, nk; retries=R)
Mads.plotseries(Wnmf, "rand_unmixed_signals_nmf.svg", title="Unmixed signals", name="Signal", combined=false)

info("Reconstruction of random signals using JuMP/ipopt ...")
Wipopt, Hipopt, pipopt = Mads.NMFipopt(X, nk, R)
Mads.plotseries(Wipopt, "rand_unmixed_signals_ipopt.svg", title="Unmixed signals", name="Signal", combined=false)

info("Reconstruction of random signals using Mads LM ...")
Wlm, Hlm, plm = Mads.MFlm(X, nk)
Mads.plotseries(Wlm, "rand_unmixed_signals_nmflm.svg", title="Unmixed signals", name="Signal", combined=false)

info("Reconstruction of sin signals ...")
Random.seed!(2015)
nk = 3
s1 = (sin.(0.05:0.05:5)+1)/2
s2 = (sin.(0.3:0.3:30)+1)/2
s3 = (sin.(0.2:0.2:20)+1)/2
S = [s1 s2 s3]
Mads.plotseries(S, "sin_original_signals.svg", title="Original signals", name="Signal", combined=true, hsize=8Gadfly.inch, vsize=4Gadfly.inch)
H = [[1,1,1] [0,2,1] [1,0,2] [1,2,0]]
X = S * H
Mads.plotseries(X, "sin_mixed_observations.svg", title="Mixed observations", name="Observation", combined=true, hsize=8Gadfly.inch, vsize=4Gadfly.inch)
info("Reconstruction of sin signals using NMF ...")
Wnmf, Hnmf, pnmf = Mads.NMFm(X, nk, retries=R)
Mads.plotseries(Wnmf, "sin_unmixed_signals_nmf.svg", title="Unmixed signals", name="Signal", combined=true)
Mads.plotseries(Wnmf * Hnmf, "sin_reproduced_observations_nmf.svg", title="Reproduced observations", name="Signal", combined=true)

info("Reconstruction of sin signals using JuMP/ipopt ...")
Wipopt, Hipopt, pipopt = Mads.NMFipopt(X, nk, R)
Mads.plotseries(Wipopt, "sin_unmixed_signals_ipopt.svg", title="Unmixed signals", name="Signal", combined=true, hsize=8Gadfly.inch, vsize=4Gadfly.inch)
Mads.plotseries(Wipopt * Hipopt, "sin_reproduced_observations_ipopt.svg", title="Reproduced observations", name="Observation", combined=true, hsize=8Gadfly.inch, vsize=4Gadfly.inch)

info("Reconstruction of sin signals using LM ...")
Wlm, Hlm, plm = Mads.MFlm(X, nk)
Mads.plotseries(Wlm, "sin_unmixed_signals_nmflm.svg", title="Unmixed signals", name="Signal", combined=true)
Mads.plotseries(Wlm * Hlm, "sin_reproduced_observations_nmflm.svg", title="Reproduced observations", name="Signal", combined=true)

info("Reconstruction of sin/rand signals ...")
Random.seed!(2015)
nk = 3
s1 = (sin.(0.05:0.05:5)+1)/2
s2 = (sin.(0.3:0.3:30)+1)/2
s3 = rand(100)
S = [s1 s2 s3]
Mads.plotseries(S, "sig_original_signals.svg", title="Original signals", name="Signal", combined=true, hsize=8Gadfly.inch, vsize=4Gadfly.inch)
Mads.plotseries(S, "sig_original_signals.png", title="Original signals", name="Signal", combined=true)
H = [[1,1,1] [0,2,1] [1,0,2] [1,2,0]]
X = S * H
Mads.plotseries(X, "sig_mixed_observations.svg", title="Mixed observations", name="Observation", combined=true, hsize=8Gadfly.inch, vsize=4Gadfly.inch)
Mads.plotseries(X, "sig_mixed_observations.png", title="Mixed observations", name="Signal", combined=true)
info("Reconstruction of sin/rand signals using NMF ...")
Wnmf, Hnmf, pnmf = Mads.NMFm(X, nk, retries=1)
Mads.plotseries(Wnmf, "sig_unmixed_signals_nmf.svg", title="Unmixed signals", name="Signal", combined=true)
Mads.plotseries(Wnmf, "sig_unmixed_signals_nmf.png", title="Unmixed signals", name="Signal", combined=true)
Mads.plotseries(Wnmf * Hnmf, "sig_reproduced_observations_nmf.svg", title="Reproduced observations", name="Signal", combined=true)

info("Reconstruction of sin/rand signals using JuMP/ipopt ...")
Wipopt, Hipopt, pipopt = Mads.NMFipopt(X, nk, 1)
Mads.plotseries(Wipopt, "sig_unmixed_signals_ipopt.svg", title="Unmixed signals", name="Signal", combined=true, hsize=8Gadfly.inch, vsize=4Gadfly.inch)
Mads.plotseries(Wipopt, "sig_unmixed_signals_ipopt.png", title="Unmixed signals", name="Signal", combined=true)
Mads.plotseries(Wipopt * Hipopt, "sig_reproduced_observations_ipopt.svg", title="Reproduced observations", name="Observation", combined=true, hsize=8Gadfly.inch, vsize=4Gadfly.inch)

@info("Reconstruction of sin/rand disturbance signal ...")
Random.seed!(2015)
nk = 3
s1 = (sin.(0.3:0.3:30)+1)/2
s2 = rand(100) * 0.5
s3 = rand(100)
s3[1:50] = 0
s3[70:end] = 0
S = [s1 s2 s3]
Mads.plotseries(S, "disturbance_original_signals.svg", xtitle="Time", title="Original signals", name="Signal", combined=true, hsize=8Gadfly.inch, vsize=4Gadfly.inch, colors=["red", "blue", "green"])
H = [[1,1,1] [0,2,1] [0,2,1] [1,0,2] [2,0,1] [1,2,0] [2,1,0]]
Sr = S + rand(size(S)) * 0.1
Hr = H + rand(size(H)) * 0.1
X = S * H
Mads.plotseries(X, "disturbance_mixed_observations.svg", xtitle="Time", title="Mixed signals", name="Observation", keytitle="Observations", combined=true, hsize=8Gadfly.inch, vsize=4Gadfly.inch)
@info("Reconstruction of sin/rand disturbance signal using NMF ...")
Wnmf, Hnmf, pnmf = Mads.NMFm(X, nk; retries=1)
Mads.plotseries(Wnmf, "disturbance_unmixed_signals_nmf.svg", title="Unmixed signals", name="Signal", combined=true)
Mads.plotseries(Wnmf * Hnmf, "sig_reproduced_observations_nmf.svg", title="Reproduced observations", name="Signal", combined=true)

@info("Reconstruction of sin/rand disturbance signal using JuMP/ipopt ...")
Wipopt, Hipopt, pipopt = Mads.NMFipopt(X, nk, 1)
Mads.plotseries(Wipopt[:,[2,1,3]], "disturbance_unmixed_signals_ipopt.svg", xtitle="Time", title="Unmixed signals", name="Signal", combined=true, hsize=8Gadfly.inch, vsize=4Gadfly.inch, colors=["red", "blue", "green"])
Mads.plotseries(Wipopt * Hipopt, "disturbance_reproduced_observations_ipopt.svg", xtitle="Time", title="Reproduced observations", name="Observation", combined=true, hsize=8Gadfly.inch, vsize=4Gadfly.inch)

@info("Reconstruction of sin/rand disturbance signal using Mads LM ...")
Wlm, Hlm, plm = Mads.MFlm(X, nk)
Mads.plotseries(Wlm, "disturbance_unmixed_signals_lm.svg", title="Unmixed signals", name="Signal", combined=true)
Mads.plotseries(Wlm * Hlm, "disturbance_reproduced_observations_lm.svg", title="Reproduced observations", name="Signal", combined=true)
