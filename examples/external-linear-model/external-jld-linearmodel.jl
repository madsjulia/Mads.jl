import JLD2
import FileIO

using OrderedCollections

parameters = FileIO.load("parameters.jld2") # JLD file created to write current model parameters

f(t) = parameters["a"] * t - parameters["b"] # a * t - b; linear model
times = 1:4
predictions = OrderedCollections.OrderedDict(zip(map(i -> string("o", i), times), map(f, times)))

FileIO.save("predictions.jld2", predictions) # JLD file created to write current model predictions