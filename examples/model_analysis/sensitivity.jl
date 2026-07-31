import Mads

md::AbstractDict = Mads.loadmadsfile("models/internal-polynomial.mads")

Mads.mkdir("sensitivity_results")

number_of_calibrations::Int = 100
@info("Calibration using $number_of_calibrations random initial guesses for model parameters")
calibration_results::Tuple = Mads.calibraterandom(md, number_of_calibrations; all_results=true, seed=2016, save_results=false)
calibration_objectives::Vector{Float64} = calibration_results[3]
calibration_parameters::Matrix{Float64} = calibration_results[4]
parameter_names::Vector{String} = string.(Mads.getoptparamkeys(md))
parameter_count::Int = length(parameter_names)
@info("Calibration objective range"; best=minimum(calibration_objectives), worst=maximum(calibration_objectives))

@info("Identify representative calibrated solutions near n = 0, n = 1, and n = 3")
n_values::Vector{Float64} = calibration_parameters[:, 4]
representative_indices::Vector{Int} = [
	argmin(abs.(n_values)),
	argmin(abs.(n_values .- 1.0)),
	argmin(abs.(n_values .- 3.0)),
]
initial_parameters::Dict{String,Float64} = Dict{String,Float64}(zip(string.(Mads.getparamkeys(md)), Float64.(Mads.getparamsinit(md))))
solution_names::Vector{String} = ["closest to n=0", "closest to n=1", "closest to n=3"]
representative_parameters::Vector{Dict{String,Float64}} = [
	Dict{String,Float64}(zip(parameter_names, calibration_parameters[index, :])) for index in representative_indices
]

for solution_index in eachindex(solution_names)
	println("Solution $(solution_names[solution_index])")
	Mads.showparameters(md, representative_parameters[solution_index])
	Mads.plotmatches(md, calibration_parameters[representative_indices[solution_index], :]; title=solution_names[solution_index])
end

@info("Local sensitivity analysis for the representative calibrated solutions")
for solution_index in eachindex(solution_names)
	Mads.setparamsinit!(md, representative_parameters[solution_index])
	Mads.localsa(md; filename="sensitivity_results/sensitivity_local_$(solution_names[solution_index]).png", datafiles=false)
end
Mads.setparamsinit!(md, initial_parameters)

@info("Global sensitivity analysis")
efast_results::AbstractDict = Mads.efast(md; N=1000, seed=2016, save=false)
Mads.plotobsSAresults(md, efast_results; filename="sensitivity_results/sensitivity_global.png", xtitle="x", ytitle="y")
