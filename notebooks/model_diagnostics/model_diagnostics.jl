import Mads

md = Dict()

md["Parameters"] = Mads.createparameters([1,1,1,1]; key=["a", "b", "c", "n"], dist=["Uniform(-10, 10)", "Uniform(-10, 10)", "Uniform(-5, 5)", "Uniform(-3, 3)"])

md["Observations"] = Mads.createobservations([0,1.1,1.9,3.1,3.9,5]; weight=[100,100,100,100,10,0], time=[0,1,2,3,4,5], dist=["Uniform(0, 1)", "Uniform(0, 2)", "Uniform(1, 3)", "Uniform(2, 4)", "Uniform(3, 5)", "Uniform(4, 6)"])

function polynominal(parameters::AbstractVector)
	f(t) = parameters[1] * (t ^ parameters[4]) + parameters[2] * t + parameters[3] # a * t^n + b * t + c
	predictions = map(f, 0:5)
	return predictions
end

Mads.setmodel!(md, polynominal)

display(md)

Mads.forward(md)

polynominal(Mads.getparamsinit(md))

Mads.plotmatches(md)

calib_param, calib_result = Mads.calibrate(md)

Mads.plotmatches(md, calib_param)

Mads.showparameterestimates(md)

Mads.showparameterestimates(md, calib_param)

chain, llhoods = Mads.emceesampling(md; numwalkers=10, nsteps=100000, burnin=10000, thinning=10, seed=2016, sigma=0.01)

f = Mads.forward(md, chain)

Mads.spaghettiplot(md, f)

Mads.scatterplotsamples(md, permutedims(chain), "emcee_scatter.png")

Mads.display("emcee_scatter.png")


