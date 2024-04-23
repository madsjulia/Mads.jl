import JLD2
import OrderedCollections

parameters = JLD2.load("parameters.jld2") # JLD file created to write current model parameters

f(t) = parameters["a"] * t - parameters["b"] # a * t - b; linear model
times = 1:4
predictions = OrderedCollections.OrderedDict(zip(map(i -> string("o", i), times), map(f, times)))

JLD2.save("predictions.jld2", predictions) # JLD file created to write current model predictions