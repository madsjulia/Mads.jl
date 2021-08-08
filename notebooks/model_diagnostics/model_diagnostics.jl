import Revise
import Mads

cd(joinpath(Mads.dir, "notebooks", "model_diagnostics"))

md = Dict()

md["Parameters"] = Mads.createparameters([1,1,1,1]; key=["a", "b", "c", "n"], dist=["Uniform(-10, 10)", "Uniform(-10, 10)", "Uniform(-5, 5)", "Uniform(0, 3)"])

md["Observations"] = Mads.createobservations([0,1.1,1.9,3.1,3.9,5]; weight=[100,100,100,100,10,0], time=[0,1,2,3,4,5], dist=["Uniform(0, 1)", "Uniform(0, 2)", "Uniform(1, 3)", "Uniform(2, 4)", "Uniform(3, 5)", "Uniform(4, 6)"])

function polynomial(parameters::AbstractVector)
	f(t) = parameters[1] * (t ^ parameters[4]) + parameters[2] * t + parameters[3] # a * t^n + b * t + c
	predictions = map(f, 0:5)
	return predictions
end

Mads.setmodel!(md, polynomial)

md["Filename"] = "model_diagnostics.mads"

display(md)

Mads.forward(md)

polynomial(Mads.getparamsinit(md))

Mads.plotmatches(md)

calib_param, calib_information = Mads.calibrate(md)

Mads.plotmatches(md, calib_param)

Mads.showparameterestimates(md)

Mads.showparameterestimates(md, calib_param)

calib_random_results = Mads.calibraterandom(md, 100; seed=2021, all=true)

calib_random_estimates = hcat(map(i->collect(values(calib_random_results[i,3])), 1:100)...)

forward_predictions = Mads.forward(md, calib_random_estimates)
Mads.spaghettiplot(md, forward_predictions)

ind_n0 = abs.(calib_random_estimates[4,:]) .< 0.1
in0 = findall(ind_n0 .== true)[1]
ind_n1 = abs.(calib_random_estimates[4,:] .- 1) .< 0.1
in1 = findall(ind_n1 .== true)[1]
ind_n3 = .!(ind_n0 .| ind_n1)
in3 = findall(ind_n3 .== true)[1]
pinit = Dict(zip(Mads.getparamkeys(md), Mads.getparamsinit(md)))
optnames = ["n=0", "n=1", "n=3"]
v = [in0, in1, in3]

for i = 1:3
	println("Solution for $(optnames[i])")
	Mads.showparameters(md, calib_random_results[v[i],3])
	Mads.plotmatches(md, calib_random_results[v[i],3]; title=optnames[i])
end

localsa = Mads.localsa(md; filename="model_diagnostics.png", par=collect(values(calib_param)))

[Mads.getparamlabels(md) localsa["stddev"]]

Mads.display("model_diagnostics-jacobian.png")

Mads.display("model_diagnostics-eigenmatrix.png")

Mads.display("model_diagnostics-eigenvalues.png")

chain, llhoods = Mads.emceesampling(md; numwalkers=10, nsteps=100000, burnin=10000, thinning=10, seed=2016, sigma=0.01)

f = Mads.forward(md, chain)

Mads.spaghettiplot(md, f)

Mads.scatterplotsamples(md, permutedims(chain), "model_diagnostics-emcee_scatter.png")

Mads.display("model_diagnostics-emcee_scatter.png")

saltelli_results = Mads.saltelli(md, N=10000, seed=2016)

Mads.plotobsSAresults(md, saltelli_results)

efastresult = Mads.efast(md, N=1000, seed=2016)
Mads.plotobsSAresults(md, efastresult, filename="sensitivity_efast.png", xtitle = "Time [-]", ytitle = "Observation [-]")

h = [0.001, 0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1]



models = ["y = a * t + c", "y = a * t^(1.1) + b * t + c", "y = a * t^n + b * t + c", "y = a * exp(t * n) + b * t + c"]

import Gadfly
import Colors
lmin = Vector{Any}(undef, 4)
lmax = Vector{Any}(undef, 4)
colors = ["blue", "red", "green", "orange"]
for i = 1:4
	min, max = Mads.infogap_jump_polynomial(model=i, plot=true, horizons=h, retries=10, maxiter=1000, verbosity=0, seed=2015)
	lmin[i] = Gadfly.layer(x=min, y=h, Gadfly.Geom.line, Gadfly.Theme(line_width=2Gadfly.pt, line_style=[:dash], default_color=Base.parse(Colors.Colorant, colors[i])))
	lmax[i] = Gadfly.layer(x=max, y=h, Gadfly.Geom.line, Gadfly.Theme(line_width=2Gadfly.pt, line_style=[:solid], default_color=Base.parse(Colors.Colorant, colors[i])))
end
f = Gadfly.plot(lmin..., lmax..., Gadfly.Guide.xlabel("o5"), Gadfly.Guide.ylabel("Horizon of uncertainty"), Gadfly.Guide.title("Opportuneness vs. Robustness"), Gadfly.Theme(highlight_width=0Gadfly.pt), Gadfly.Guide.manual_color_key("Models", models, colors))
Gadfly.draw(Gadfly.PNG("infogap_opportuneness_vs_robustness.png", 6Gadfly.inch, 4Gadfly.inch), f)

Mads.display("infogap_opportuneness_vs_robustness.png")
