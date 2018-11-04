import Test
import Mads
md = Mads.loadmadsfile("ode.mads")
prob = OrdinaryDiffEq.ODEProblem(funcosc, initialconditions, (0.0,100.0))
sol = OrdinaryDiffEq.solve(prob,Tsit5(), saveat=times)
ys = convert(Array,sol)
Mads.createobservations!(md, t, ys[:,1])
if isdir("odecheckpoints")
	rm("odecheckpoints"; recursive=true)
end
result1 = Mads.efast(md, seed=20151001; N=1000, restartdir="odecheckpoints", checkpointfrequency=100, restart=true)
result2 = Mads.efast(md, seed=20151001; N=1000, restartdir="odecheckpoints", checkpointfrequency=100, restart=true)
rm("odecheckpoints"; recursive=true)
@Test.test isequal(result1, result2)
