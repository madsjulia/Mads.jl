import Mads
import Gadfly
import Printf
import Statistics

md::AbstractDict = Mads.loadmadsfile("models/internal-polynomial.mads")

Mads.mkdir("calibration_results")

number_of_calibrations::Int = 100
@info("Calibration using $number_of_calibrations random initial guesses for model parameters")
calibration_results::Tuple = Mads.calibraterandom(md, number_of_calibrations; all_results=true, seed=2016, save_results=false)
calibration_objectives::Vector{Float64} = calibration_results[3]
parameter_estimates::Matrix{Float64} = calibration_results[4]
parameter_names::Vector{String} = string.(Mads.getoptparamkeys(md))
parameter_count::Int = length(parameter_names)
failed_calibrations::Int = count((objective::Float64) -> !isfinite(objective), calibration_objectives)

println("Worst objective function estimate $(maximum(calibration_objectives))")
println("Best objective function estimate $(minimum(calibration_objectives))")
println("$failed_calibrations calibrations produced a non-finite objective")

@info("Histograms of the estimated model parameters")
for parameter_index in 1:parameter_count
	figure::Gadfly.Plot = Gadfly.plot(x=parameter_estimates[:, parameter_index], Gadfly.Guide.xlabel(parameter_names[parameter_index]), Gadfly.Geom.histogram())
	Gadfly.draw(Gadfly.PNG("calibration_results/estimated_parameter_histogram_$(parameter_names[parameter_index]).png", 6Gadfly.inch, 4Gadfly.inch), figure)
end

parameter_minima::Vector{Float64} = vec(minimum(parameter_estimates; dims=1))
parameter_maxima::Vector{Float64} = vec(maximum(parameter_estimates; dims=1))
parameter_means::Vector{Float64} = vec(Statistics.mean(parameter_estimates; dims=1))
parameter_standard_deviations::Vector{Float64} = vec(Statistics.std(parameter_estimates; dims=1))

@info("Statistics of the model parameter estimates:")
Printf.@printf "Name\tMean\tMin\tMax\tStdDev\n"
for parameter_index in 1:parameter_count
	Printf.@printf "%s\t%f\t%f\t%f\t%f\n" parameter_names[parameter_index] parameter_means[parameter_index] parameter_minima[parameter_index] parameter_maxima[parameter_index] parameter_standard_deviations[parameter_index]
end

@info("Identify calibrated solution families with different model parameter estimates:")
println("$(count(abs.(parameter_estimates[:, 1]) .< 0.1)) calibrations have a ≈ 0")
println("$(count(abs.(parameter_estimates[:, 2] .- 1.0) .< 0.1)) calibrations have b ≈ 1")
println("$(count(abs.(parameter_estimates[:, 3]) .< 0.1)) calibrations have c ≈ 0")
println("$(count(abs.(parameter_estimates[:, 4]) .< 0.1)) calibrations have n ≈ 0")
println("$(count(abs.(parameter_estimates[:, 4] .- 1.0) .< 0.1)) calibrations have n ≈ 1")

@info("Scatter plot of parameter estimates")
figure = Gadfly.plot(x=parameter_estimates[:, 1], y=parameter_estimates[:, 4], Gadfly.Geom.point, Gadfly.Guide.xlabel("a"), Gadfly.Guide.ylabel("n"), Gadfly.Guide.title("Scatter plot of parameter estimates `a` and `n` (f(t)=a*t^n+b*t+c)"))
Gadfly.draw(Gadfly.PNG("calibration_results/estimated_parameter_scatter_plot_a_vs_n.png", 6Gadfly.inch, 4Gadfly.inch), figure)

near_n_zero::Vector{Bool} = abs.(parameter_estimates[:, 4]) .< 0.1
figure = Gadfly.plot(x=parameter_estimates[near_n_zero, 1], y=parameter_estimates[near_n_zero, 3], Gadfly.Geom.point, Gadfly.Guide.xlabel("a"), Gadfly.Guide.ylabel("c"), Gadfly.Guide.title("Scatter plot of parameter estimates `a` and `c` when n ≈ 0 (f(t)=a*t^n+b*t+c)"))
Gadfly.draw(Gadfly.PNG("calibration_results/estimated_parameter_scatter_plot_a_vs_c.png", 6Gadfly.inch, 4Gadfly.inch), figure)

near_n_one::Vector{Bool} = abs.(parameter_estimates[:, 4] .- 1.0) .< 0.1
figure = Gadfly.plot(x=parameter_estimates[near_n_one, 1], y=parameter_estimates[near_n_one, 2], Gadfly.Geom.point, Gadfly.Guide.xlabel("a"), Gadfly.Guide.ylabel("b"), Gadfly.Guide.title("Scatter plot of parameter estimates `a` and `b` when n ≈ 1 (f(t)=a*t^n+b*t+c)"))
Gadfly.draw(Gadfly.PNG("calibration_results/estimated_parameter_scatter_plot_a_vs_b.png", 6Gadfly.inch, 4Gadfly.inch), figure)

other_n_values::Vector{Bool} = .!(near_n_zero .| near_n_one)
figure = Gadfly.plot(x=parameter_estimates[other_n_values, 1], y=parameter_estimates[other_n_values, 4], Gadfly.Geom.point, Gadfly.Guide.xlabel("a"), Gadfly.Guide.ylabel("n"), Gadfly.Guide.title("Scatter plot of parameter estimates `a` and `n` outside the n ≈ 0 and n ≈ 1 families (f(t)=a*t^n+b*t+c)"))
Gadfly.draw(Gadfly.PNG("calibration_results/estimated_parameter_scatter_plot_a_vs_n_n01.png", 6Gadfly.inch, 4Gadfly.inch), figure)
