import ODE
import Mads

mu0 = 0.4
a = 0.005
b = 0.007 # PSU
W0 = 3e-5 # PSU
K = 32e6 # PSU
M = 1000
N = 10^6
Dc = 0.00005 # PSU
Q0 = Dc / W0
V0 = 0.001

V00 = W0
Q00 = Q0
X00 = -N * mu0 / K
LP00 = 0.0
state0=[X00, V00, Q00, LP00]

tstart = 0.0
tstop = 5.0
times = collect(tstart:0.1:tstop)

function RSAH23sF(t, state)
	S3 = abs(state[3])
	LV = log(state[2] / W0)
	LQ = log(S3 / Q0)

	D1 = state[2]
	D2 = K / M * (state[4] - state[1]) -  N / M * (mu0 + a * LV + b * LQ)
	D3 = 1. - (state[2] * S3) / W0 / Q0
	D4 = V0

	return [D1, D2, D3, D4]
end

RSAH23sF(0.1, state0)

t, state = ODE.ode23s(RSAH23sF, state0, times; points=:specified)
output = permutedims(hcat(state...))

Mads.plotseries(output; xaxis=times, xmax=5, name="State", combined=false, vsize=16Gadfly.inch, hsize=6Gadfly.inch)

XW = output[:,1]
VW = output[:,2]
QW = output[:,3]
LPW = output[:,4]

Mads.plotseries(XW; xaxis=times, xmax=5, title="XW")
Mads.plotseries(VW; xaxis=times, xmax=5, title="VW")
Mads.plotseries(QW; xaxis=times, xmax=5, title="QW")
Mads.plotseries(LPW; xaxis=times, xmax=5, title="LPW")

muW = K * (LPW .- XW) / N

Mads.plotseries(muW; xaxis=times, xmax=5, title="muW")