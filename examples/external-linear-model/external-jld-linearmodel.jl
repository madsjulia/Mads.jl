import JLD2
import FileIO
import JLD

import DataStructures

parameters = FileIO.load("parameters.jld") # JLD file created to write current model parameters

f(t) = parameters["a"] * t - parameters["b"] # a * t - b; linear model
times = 1:4
predictions = DataStructures.OrderedDict(zip(map(i -> string("o", i), times), map(f, times)))

FileIO.save("predictions.jld", predictions) # JLD file created to write current model predictions