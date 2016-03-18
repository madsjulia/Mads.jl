import JSON
import DataStructures

parameters = JSON.parsefile("parameters.json"; dicttype=DataStructures.OrderedDict)

f(t) = parameters["a"] * t - parameters["b"] # a * t - b; linear model
times = 1:4
predictions = DataStructures.OrderedDict(zip(map(i -> string("o", i), times), map(f, times)))

jo = open("predictions.json", "w")
JSON.print(jo, predictions)
close(jo)
