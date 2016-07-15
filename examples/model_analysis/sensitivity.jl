import Mads
md = Mads.loadmadsfile("internal-polynomial.mads")
n = 100
info("Calibration using $n random initial guesses for model parameters")
r = Mads.calibraterandom(md, n, all=true, seed=2016)
rm("internal-polynomial.iterationresults")
pnames = collect(keys(r[1,3]))
p = hcat(map(i->collect(values(r[i,3])), 1:n)...)'
np = length(pnames)
info("Identify the 3 different global optima with different model parameter estimates")
in0 = find((abs(p[:,4]) .< 0.1) .== true)[1]
in1 = find((abs(p[:,4]-1) .< 0.1) .== true)[1]
in01 = find((!(ind_n0 | ind_n1)) .== true)[1]
pinit = Dict(zip(Mads.getparamkeys(md), Mads.getparamsinit(md)))
p = ["n0", "n1", "n01"]
v = [in0, in1, in01]
info("Local sensitivity analysis for the 3 different global optima")
for i = 1:3
	Mads.setparamsinit!(md, r[v[i],3])
	Mads.localsa(md, filename="sensitivity_local_$(p[i]).png", datafiles=false)
end
Mads.setparamsinit!(md, pinit)
info("Global sensitivity analysis")
efastresult = Mads.efast(md, N=1000, seed=2016)
Mads.plotobsSAresults(md, efastresult, filename="sensitivity_global.png", xtitle = "x", ytitle = "y")
