using Base.Test
import Mads
md = Mads.loadmadsfile("ode.mads")
t, y = ode23s(funcosc, initialconditions, times, points=:specified)
ys = hcat(y...)' # vectorizing the output and transposing it with '
Mads.createobservations!(md, t, ys[:,1])
if isdir("odecheckpoints")
	rm("odecheckpoints"; recursive=true)
end
result1 = Mads.efast(md, seed=20151001; N=1000, restartdir="odecheckpoints", checkpointfrequency=100, restart=true)
result2 = Mads.efast(md, seed=20151001; N=1000, restartdir="odecheckpoints", checkpointfrequency=100, restart=true)
rm("odecheckpoints"; recursive=true)
@test isequal(result1, result2)
