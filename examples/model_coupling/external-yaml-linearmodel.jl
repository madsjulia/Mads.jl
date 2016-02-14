import Mads

parameters = Mads.loadyamlfile("parameters.yaml") # YAML file created to write current model parameters

f(t) = parameters["a"] * t - parameters["b"] # a * t - b; linear model
times = 1:4
predictions = Dict(zip(map(i -> string("o", i), times), map(f, times)))

Mads.dumpyamlfile("predictions.yaml", predictions) # YAML file created to write current model predictions
