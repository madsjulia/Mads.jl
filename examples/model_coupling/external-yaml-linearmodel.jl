using MadsYAML

parameters = MadsYAML.loadyamlfile("parameters.yaml") # YAML file created to write currend model parameters

f(t) = parameters["a"] * t - parameters["b"] # a * t - b; linear model
times = 1:4
predictions = Dict(map(i -> string("o", i), times), map(f, times))

MadsYAML.dumpyamlfile("predictions.yaml", predictions) # YAML file created to write currend model parameters
