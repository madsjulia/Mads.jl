import Mads
import NMF

R=1

info("Reconstruction of random signals ...")
srand(2015)
nk = 3
s1 = rand(100)
s2 = rand(100)
s3 = rand(100)
S = [s1 s2 s3]
Mads.plotseries(S, "rand_original_signals.svg", title="Original signals", name="Signal", combined=false)
H = [[1,1,1] [0,2,1] [1,0,2] [1,2,0]]
X = S * H
Mads.plotseries(X, "rand_mixed_observations.svg", title="Mixed observations", name="Observation", combined=false)
# info("Reconstruction of random signals using NMF ...")
# Wnmf, Hnmf, pnmf = Mads.NMFm(X, nk, retries=R)
# Mads.plotseries(Wnmf, "rand_unmixed_signals_nmf.svg", title="Unmixed signals", name="Signal", combined=false)
info("Reconstruction of random signals using JuMP/NLopt ...")
Wipopt, Hipopt, pipopt = Mads.NMFipopt(X, nk, retries=R)
Mads.plotseries(Wipopt, "rand_unmixed_signals_ipopt.svg", title="Unmixed signals", name="Signal", combined=false)
# info("Reconstruction of random signals using LM ...")
# Wlm, Hlm, plm = Mads.MFlm(X, nk)
# Mads.plotseries(Wlm, "rand_unmixed_signals_nmflm.svg", title="Unmixed signals", name="Signal", combined=false)

info("Reconstruction of sin signals ...")
srand(2015)
nk = 3
s1 = (sin(0.05:0.05:5)+1)/2
s2 = (sin(0.3:0.3:30)+1)/2
s3 = (sin(0.2:0.2:20)+1)/2
S = [s1 s2 s3]
Mads.plotseries(S, "sin_original_signals.svg", title="Original signals", name="Signal", combined=true)
H = [[1,1,1] [0,2,1] [1,0,2] [1,2,0]]
X = S * H
Mads.plotseries(X, "sin_mixed_observations.svg", title="Mixed observations", name="Observation", combined=true)
# info("Reconstruction of sin signals using NMF ...")
# Wnmf, Hnmf, pnmf = Mads.NMFm(X, nk, retries=R)
# Mads.plotseries(Wnmf, "sin_unmixed_signals_nmf.svg", title="Unmixed signals", name="Signal", combined=true)
# Mads.plotseries(Wnmf * Hnmf, "sin_reproduced_observations_nmf.svg", title="Reproduced observations", name="Signal", combined=true)
info("Reconstruction of sin signals using JuMP/NLopt ...")
Wipopt, Hipopt, pipopt = Mads.NMFipopt(X, nk, retries=R)
Mads.plotseries(Wipopt, "sin_unmixed_signals_ipopt.svg", title="Unmixed signals", name="Signal", combined=true)
Mads.plotseries(Wipopt * Hipopt, "sin_reproduced_observations_ipopt.svg", title="Reproduced observations", name="Observation", combined=true)
# info("Reconstruction of sin signals using LM ...")
# Wlm, Hlm, plm = Mads.MFlm(X, nk)
# Mads.plotseries(Wlm, "sin_unmixed_signals_nmflm.svg", title="Unmixed signals", name="Signal", combined=true)
# Mads.plotseries(Wlm * Hlm, "sin_reproduced_observations_nmflm.svg", title="Reproduced observations", name="Signal", combined=true)

info("Reconstruction of sin/rand signals ...")
srand(2015)
nk = 3
s1 = (sin(0.05:0.05:5)+1)/2
s2 = (sin(0.3:0.3:30)+1)/2
s3 = rand(100)
S = [s1 s2 s3]
Mads.plotseries(S, "sig_original_signals.svg", title="Original signals", name="Signal", combined=true)
# Mads.plotseries(S, "sig_original_signals.png", title="Original signals", name="Signal", combined=true)
H = [[1,1,1] [0,2,1] [1,0,2] [1,2,0]]
X = S * H
Mads.plotseries(X, "sig_mixed_observations.svg", title="Mixed observations", name="Observation", combined=true)
# Mads.plotseries(X, "sig_mixed_observations.png", title="Mixed observations", name="Signal", combined=true)
# info("Reconstruction of sin/rand signals using NMF ...")
# Wnmf, Hnmf, pnmf = Mads.NMFm(X, nk, retries=1)
# Mads.plotseries(Wnmf, "sig_unmixed_signals_nmf.svg", title="Unmixed signals", name="Signal", combined=true)
# Mads.plotseries(Wnmf, "sig_unmixed_signals_nmf.png", title="Unmixed signals", name="Signal", combined=true)
Mads.plotseries(Wnmf * Hnmf, "sig_reproduced_observations_nmf.svg", title="Reproduced observations", name="Signal", combined=true)
info("Reconstruction of sin/rand signals using JuMP/NLopt ...")
Wipopt, Hipopt, pipopt = Mads.NMFipopt(X, nk, retries=1)
Mads.plotseries(Wipopt, "sig_unmixed_signals_ipopt.svg", title="Unmixed signals", name="Signal", combined=true)
# Mads.plotseries(Wipopt, "sig_unmixed_signals_ipopt.png", title="Unmixed signals", name="Signal", combined=true)
Mads.plotseries(Wipopt * Hipopt, "sig_reproduced_observations_ipopt.svg", title="Reproduced observations", name="Observation", combined=true)

info("Reconstruction of sin/rand disturbance signal ...")
srand(2015)
nk = 3
s1 = (sin(0.3:0.3:30)+1)/2
s2 = rand(100) * 0.5
s3 = rand(100)
s3[1:50] = 0
s3[70:end] = 0
S = [s1 s2 s3]
Mads.plotseries(S, "disturbance_original_signals.svg", title="Original signals", name="Signal", combined=true)
# Mads.plotseries(S, "disturbance_original_signals.png", title="Original signals", name="Signal", combined=true)
H = [[1,1,1] [0,2,1] [0,2,1] [1,0,2] [2,0,1] [1,2,0] [2,1,0]]
X = S * H
Mads.plotseries(X, "disturbance_mixed_observations.svg", title="Mixed observations", name="Observation", combined=true)
# Mads.plotseries(X, "disturbance_mixed_observations.png", title="Mixed observations", name="Signal", combined=true)
# info("Reconstruction of sin/rand signals using NMF ...")
# Wnmf, Hnmf, pnmf = Mads.NMFm(X, nk, retries=1)
# Mads.plotseries(Wnmf, "disturbance_unmixed_signals_nmf.svg", title="Unmixed signals", name="Signal", combined=true)
# Mads.plotseries(Wnmf, "disturbance_unmixed_signals_nmf.png", title="Unmixed signals", name="Signal", combined=true)
# Mads.plotseries(Wnmf * Hnmf, "sig_reproduced_observations_nmf.svg", title="Reproduced observations", name="Signal", combined=true)
info("Reconstruction of sin/rand signals using JuMP/NLopt ...")
Wipopt, Hipopt, pipopt = Mads.NMFipopt(X, nk, retries=1)
Mads.plotseries(Wipopt, "disturbance_unmixed_signals_ipopt.svg", title="Unmixed signals", name="Signal", combined=true)
# Mads.plotseries(Wipopt, "disturbance_unmixed_signals_ipopt.png", title="Unmixed signals", name="Signal", combined=true)
Mads.plotseries(Wipopt * Hipopt, "disturbance_reproduced_observations_ipopt.svg", title="Reproduced observations", name="Observation", combined=true)

# info("Reconstruction of sin/rand signals using LM ...")
# Wlm, Hlm, plm = Mads.MFlm(X, nk)
# Mads.plotseries(Wlm, "sig_unmixed_signals_nmflm.svg", title="Unmixed signals", name="Signal", combined=true)
# Mads.plotseries(Wlm * Hlm, "sig_reproduced_observations_nmflm.svg", title="Reproduced observations", name="Signal", combined=true)
