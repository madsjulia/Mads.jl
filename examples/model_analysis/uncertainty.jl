import Gadfly
import LinearAlgebra
import Mads
import Statistics

# md = Mads.loadmadsfile("models/internal-linear.mads")
# md = Mads.loadmadsfile("models/internal-exp-polynomial.mads")
md::AbstractDict = Mads.loadmadsfile("models/internal-polynomial3.mads")
# md = Mads.loadmadsfile("models/internal-polynomial.mads")

problem::String = String(split(Mads.getmadsrootname(md), "-")[2])

@info("Problem: $(problem)")

Mads.mkdir("uncertainty_results")

@info("Local uncertainty analysis")

@info("Model calibration")
calibration_result::Tuple = Mads.calibrate(md; store_optimization_progress=false)
calibrated_parameters::AbstractDict = calibration_result[1]
calibrated_predictions::AbstractDict = Mads.forward(md, calibrated_parameters)
parameter_values::Vector{Float64} = Float64.(Mads.getoptparams(md, collect(values(calibrated_parameters))))
variance_scale::Float64 = 0.5

@info("Local sensitivity analysis")
local_sensitivity::AbstractDict = Mads.localsa(md; datafiles=false, imagefiles=false, par=parameter_values, obs=Float64.(collect(values(calibrated_predictions))))

@info("Model parameter sampling")
sampling_result::Tuple = Mads.sampling(parameter_values, local_sensitivity["jacobian"], 1000; seed=2016, scale=variance_scale)
parameter_samples::Matrix{Float64} = sampling_result[1]
sample_log_likelihoods::Vector{Float64} = sampling_result[2]

@info("Model forward runs")
prediction_samples::Matrix{Float64} = Mads.forward(md, parameter_samples)

@info("Use importance sampling to keep the solutions containing 95% of the probability mass")
reweighted_log_likelihoods::Vector{Float64} = Mads.reweighsamples(md, prediction_samples, sample_log_likelihoods)
important_predictions::Matrix{Float64} = Mads.getimportantsamples(permutedims(prediction_samples), reweighted_log_likelihoods)
weighted_statistics::Tuple = Mads.weightedstats(permutedims(prediction_samples), reweighted_log_likelihoods)
weighted_prediction_mean::Matrix{Float64} = weighted_statistics[1]
weighted_prediction_variance::Matrix{Float64} = weighted_statistics[2]

@info("Linearized variance of posterior predictions")
display(LinearAlgebra.diag(local_sensitivity["jacobian"] * local_sensitivity["covar"] * local_sensitivity["jacobian"]'))

@info("Variance of posterior predictions using all samples")
display(Statistics.var(prediction_samples; dims=2))

@info("Variance of posterior predictions using importance sampling")
display(Statistics.var(important_predictions; dims=2))

@info("Weighted mean and variance of posterior predictions using importance sampling")
display(weighted_prediction_mean)
display(weighted_prediction_variance)

@info("Spaghetti plot of posterior predictions")
Mads.spaghettiplot(md, prediction_samples; filename="uncertainty_results/spaghetti-$(problem).png")

@info("Spaghetti plot of posterior predictions using importance sampling")
Mads.spaghettiplot(md, important_predictions; filename="uncertainty_results/spaghetti-$(problem)-importance-sampling.png")
Mads.display("uncertainty_results/spaghetti-$(problem)-importance-sampling.png")

@info("Histogram of `o5` predictions")
figure::Gadfly.Plot = Gadfly.plot(x=prediction_samples[5, :], Gadfly.Guide.xlabel("o5"), Gadfly.Geom.histogram())
Gadfly.draw(Gadfly.PNG("uncertainty_results/histogram-$(problem).png", 6Gadfly.inch, 4Gadfly.inch), figure)

@info("Histogram of `o5` predictions using importance sampling")
figure = Gadfly.plot(x=important_predictions[5, :], Gadfly.Guide.xlabel("o5"), Gadfly.Geom.histogram())
Gadfly.draw(Gadfly.PNG("uncertainty_results/histogram-$(problem)-importance-sampling.png", 6Gadfly.inch, 4Gadfly.inch), figure)

@info("Spaghetti plot of posterior predictions using Bayesian analysis")
Mads.setparamsinit!(md, calibrated_parameters)
mcmc_result::Tuple = Mads.emceesampling(md; numwalkers=10, nexecutions=10000, burnin=1000, thinning=1, seed=2016, save=false)
posterior_predictions::Matrix{Float64} = mcmc_result[3]
Mads.spaghettiplot(md, posterior_predictions; filename="uncertainty_results/spaghetti-$(problem)-bayes.png")
Mads.display("uncertainty_results/spaghetti-$(problem)-bayes.png")

@info("Histogram of `o5` predictions using Bayesian analysis")
figure = Gadfly.plot(x=posterior_predictions[5, :], Gadfly.Guide.xlabel("o5"), Gadfly.Geom.histogram())
Gadfly.draw(Gadfly.PNG("uncertainty_results/histogram-$(problem)-bayes.png", 6Gadfly.inch, 4Gadfly.inch), figure)

@info("Variance of posterior predictions using Bayesian analysis")
display(Statistics.var(posterior_predictions; dims=2))
