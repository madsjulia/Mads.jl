import Mads
import Gadfly
import Printf
md = Mads.loadmadsfile("models/internal-polynomial.mads")

Mads.mkdir("calibration_results")

n = 100
@info("Calibration using $n random initial guesses for model parameters")
r = Mads.calibraterandom(md, n, all=true, seed=2016, save_results=false)
println("Worst objective function estimate $(max(r[:,1]...))")
println("Best objective function estimate $(min(r[:,1]...))")
println("$(collect(size(findall(r[:,2] .== false)))) calibrations failed")
pnames = collect(keys(r[1,3]))
p = hcat(map(i->collect(values(r[i,3])), 1:n)...)'
np = length(pnames)

@info("Histograms of the estimated model parameters")
for i = 1:np
	f = Gadfly.plot(x=p[:,i], Gadfly.Guide.xlabel(pnames[i]), Gadfly.Geom.histogram())
	Gadfly.draw(Gadfly.PNG("calibration_results/estimated_parameter_histogram_$(pnames[i]).png", 6Gadfly.inch, 4Gadfly.inch), f)
end
pmin = map(i->min(p[:,i]...), 1:np)
pmax = map(i->max(p[:,i]...), 1:np)
pmean = map(i->mean(p[:,i]), 1:np)
pstd = map(i->std(p[:,i]), 1:np)

@info("Statistics of the model parameter estimates:")
@Printf.printf "Name\tMean\tMin\tMad\tStdDev\n"
for i = 1:np
	@Printf.printf "%s\t%f\t%f\t%f\t%f\n" pnames[i] pmean[i] pmin[i] pmax[i] pstd[i]
end
@info("Identify 3 different global optima with different model parameter estimates:")
println("$(collect(size(findall((abs(p[:,1]) .< 0.1) .== true)))) calibrations have a ~= 0")
println("$(collect(size(findall((abs(p[:,2]-1) .< 0.1) .== true)))) calibrations have b ~= 1")
println("$(collect(size(findall((abs(p[:,3]) .< 0.1) .== true)))) calibrations have c ~= 0")
println("$(collect(size(findall((abs(p[:,4]) .< 0.1) .== true)))) calibrations have n ~= 0")
println("$(collect(size(findall((abs(p[:,4]-1) .< 0.1) .== true)))) calibrations have n ~= 1")

@info("Scatter plot of parameter estimates")
f = Gadfly.plot(x=p[:,1], y=p[:,4], Gadfly.Geom.point, Gadfly.Guide.xlabel("a"), Gadfly.Guide.ylabel("n"), Gadfly.Guide.title("Scatter plot of parameter estimates `a` and `n` (f(t)=a*t^n+b*t+c)"))
Gadfly.draw(Gadfly.PNG("calibration_results/estimated_parameter_scatter_plot_a_vs_n.png", 6Gadfly.inch, 4Gadfly.inch), f)
ind_n0 = abs(p[:,4]) .< 0.1
f = Gadfly.plot(x=p[ind_n0,1], y=p[ind_n0,3], Gadfly.Geom.point, Gadfly.Guide.xlabel("a"), Gadfly.Guide.ylabel("c"), Gadfly.Guide.title("Scatter plot of parameter estimates `a` and `c` when n = 0 (f(t)=a*t^n+b*t+c)"))
Gadfly.draw(Gadfly.PNG("calibration_results/estimated_parameter_scatter_plot_a_vs_c.png", 6Gadfly.inch, 4Gadfly.inch), f)
ind_n1 = abs(p[:,4]-1) .< 0.1
f = Gadfly.plot(x=p[ind_n1,1], y=p[ind_n1,2], Gadfly.Geom.point, Gadfly.Guide.xlabel("a"), Gadfly.Guide.ylabel("b"), Gadfly.Guide.title("Scatter plot of parameter estimates `a` and `b` when n = 1 (f(t)=a*t^n+b*t+c)"))
Gadfly.draw(Gadfly.PNG("calibration_results/estimated_parameter_scatter_plot_a_vs_b.png", 6Gadfly.inch, 4Gadfly.inch), f)
ind_n01 = !(ind_n0 | ind_n1)
f = Gadfly.plot(x=p[ind_n01,1], y=p[ind_n01,4], Gadfly.Geom.point, Gadfly.Guide.xlabel("a"), Gadfly.Guide.ylabel("n"), Gadfly.Guide.title("Scatter plot of parameter estimates `a` and `n` when n != 0 && n != 1 (f(t)=a*t^n+b*t+c)"))
Gadfly.draw(Gadfly.PNG("calibration_results/estimated_parameter_scatter_plot_a_vs_n_n01.png", 6Gadfly.inch, 4Gadfly.inch), f)