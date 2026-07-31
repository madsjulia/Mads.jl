import Mads

cd(joinpath(Mads.dir, "notebooks", "model_diagnostics"))

function polynomial(parameters::AbstractVector{<:Real})::Vector{Float64}
	predictions::Vector{Float64} = [
		Float64(parameters[1] * t^parameters[4] + parameters[2] * t + parameters[3]) for t in 0:5
	]
	return predictions
end

polynomial([3, 2, 3, 4])

md::Dict{String,Any} = Mads.createproblem([1,1,1,1], [0,1.1,1.9,3.1,3.9,5], polynomial; paramkey=["a", "b", "c", "n"], paramdist=["Uniform(-10, 10)", "Uniform(-10, 10)", "Uniform(-5, 5)", "Uniform(0, 3)"], obsweight=[100,100,100,100,10,0], obstime=[0,1,2,3,4,5], obsdist=["Uniform(0, 1)", "Uniform(0, 2)", "Uniform(1, 3)", "Uniform(2, 4)", "Uniform(3, 5)", "Uniform(4, 6)"], problemname="model_diagnostics")

md = Dict{String,Any}()

md["Parameters"], _, _ = Mads.createparameters([1,1,1,1]; key=["a", "b", "c", "n"], dist=["Uniform(-10, 10)", "Uniform(-10, 10)", "Uniform(-5, 5)", "Uniform(0, 3)"])

md["Observations"] = Mads.createobservations([0,1.1,1.9,3.1,3.9,5]; weight=[100,100,100,100,10,0], time=[0,1,2,3,4,5], dist=["Uniform(0, 1)", "Uniform(0, 2)", "Uniform(1, 3)", "Uniform(2, 4)", "Uniform(3, 5)", "Uniform(4, 6)"])

Mads.setmodel!(md, polynomial)

md["Filename"] = "model_diagnostics.mads"

display(md)

Mads.showparameters(md)

Mads.showobservations(md)

Mads.forward(md)

polynomial(Mads.getparamsinit(md))

Mads.plotmatches(md)

calibration_result::Tuple = Mads.calibrate(md; store_optimization_progress=false)
calibrated_parameters::AbstractDict = calibration_result[1]

Mads.plotmatches(md, calibrated_parameters)

Mads.showparameterestimates(md)

Mads.showparameterestimates(md, calibrated_parameters)

random_calibration_result::Tuple = Mads.calibraterandom(md, 100; seed=2021, all_results=true, save_results=false, store_optimization_progress=false)
calibration_objectives::Vector{Float64} = random_calibration_result[3]
calibration_parameters::Matrix{Float64} = random_calibration_result[4]

forward_predictions::Matrix{Float64} = Mads.forward(md, calibration_parameters)
Mads.spaghettiplot(md, forward_predictions)

parameter_names::Vector{String} = string.(Mads.getoptparamkeys(md))
n_values::Vector{Float64} = calibration_parameters[:, 4]
representative_indices::Vector{Int} = [
	argmin(abs.(n_values)),
	argmin(abs.(n_values .- 1.0)),
	argmin(abs.(n_values .- 3.0)),
]
solution_names::Vector{String} = ["closest to n=0", "closest to n=1", "closest to n=3"]
representative_parameters::Vector{Dict{String,Float64}} = [
	Dict{String,Float64}(zip(parameter_names, calibration_parameters[index, :])) for index in representative_indices
]

for solution_index in eachindex(solution_names)
	println("Solution $(solution_names[solution_index])")
	Mads.showparameters(md, representative_parameters[solution_index])
	Mads.plotmatches(md, calibration_parameters[representative_indices[solution_index], :]; title=solution_names[solution_index])
end

local_sensitivity::AbstractDict = Mads.localsa(md; filename="model_diagnostics.png", par=Float64.(collect(values(calibrated_parameters))), datafiles=false)

[Mads.getparamlabels(md) local_sensitivity["stddev"]]

Mads.display("model_diagnostics-jacobian.png")

Mads.display("model_diagnostics-eigenmatrix.png")

Mads.display("model_diagnostics-eigenvalues.png")

mcmc_result::Tuple = Mads.emceesampling(md; numwalkers=10, nexecutions=100000, burnin=10000, thinning=10, seed=2016, sigma=0.01, save=false)
mcmc_chain::Matrix{Float64} = mcmc_result[1]

mcmc_predictions::Matrix{Float64} = mcmc_result[3]

Mads.spaghettiplot(md, mcmc_predictions)

Mads.scatterplotsamples(md, permutedims(mcmc_chain), "model_diagnostics-emcee_scatter.png")

Mads.display("model_diagnostics-emcee_scatter.png")

saltelli_results::AbstractDict = Mads.saltelli(md; N=10000, seed=2016, save=false)

Mads.plotobsSAresults(md, saltelli_results)

efast_results::AbstractDict = Mads.efast(md; N=1000, seed=2016, save=false)
Mads.plotobsSAresults(md, efast_results; filename="sensitivity_efast.png", xtitle="Time [-]", ytitle="Observation [-]")

horizons::Vector{Float64} = [0.001, 0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1]

model_names::Vector{String} = ["y = a * t + c", "y = a * t^(1.1) + b * t + c", "y = a * t^n + b * t + c", "y = a * exp(t * n) + b * t + c"]

import Gadfly
import Colors
minimum_layers::Vector{Any} = Vector{Any}(undef, 4)
maximum_layers::Vector{Any} = Vector{Any}(undef, 4)
colors::Vector{String} = ["blue", "red", "green", "orange"]
for model_index in 1:4
	minimum_predictions::Vector{Float64}, maximum_predictions::Vector{Float64} = Mads.infogap_jump_polynomial(model=model_index, plot=true, horizons=horizons, retries=10, maxiter=1000, verbosity=0, seed=2015)
	minimum_layers[model_index] = Gadfly.layer(x=minimum_predictions, y=horizons, Gadfly.Geom.line, Gadfly.Theme(line_width=2Gadfly.pt, line_style=[:dash], default_color=Base.parse(Colors.Colorant, colors[model_index])))
	maximum_layers[model_index] = Gadfly.layer(x=maximum_predictions, y=horizons, Gadfly.Geom.line, Gadfly.Theme(line_width=2Gadfly.pt, line_style=[:solid], default_color=Base.parse(Colors.Colorant, colors[model_index])))
end
figure::Gadfly.Plot = Gadfly.plot(minimum_layers..., maximum_layers..., Gadfly.Guide.xlabel("o5"), Gadfly.Guide.ylabel("Horizon of uncertainty"), Gadfly.Guide.title("Opportuneness vs. Robustness"), Gadfly.Theme(highlight_width=0Gadfly.pt), Gadfly.Guide.manual_color_key("Models", model_names, colors))
Gadfly.draw(Gadfly.PNG("infogap_opportuneness_vs_robustness.png", 6Gadfly.inch, 4Gadfly.inch), figure)

Mads.display("infogap_opportuneness_vs_robustness.png")
