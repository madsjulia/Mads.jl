import JSON
import OrderedCollections

parameters = JSON.parsefile("parameters.json"; dicttype=OrderedCollections.OrderedDict)

f(t) = parameters["a"] * t - parameters["b"] # a * t - b; linear model
times = 1:4
@show map(i -> string("o", i), times), map(f, times)
predictions = OrderedCollections.OrderedDict(zip(map(i -> string("o", i), times), map(f, times)))

@show predictions
jo = open("predictions.json", "w")
JSON.print(jo, predictions)
close(jo)
