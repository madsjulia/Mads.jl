import JLD
import OrderedCollections

parameters = JLD.load("parameters.jld") # JLD file created to write current model parameters

f(t) = parameters["a"] * t - parameters["b"] # a * t - b; linear model
times = 1:4
predictions = OrderedCollections.OrderedDict(zip(map(i -> string("o", i), times), map(f, times)))

JLD.save("predictions.jld", predictions) # JLD file created to write current model predictions