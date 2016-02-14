#import MADS
import JSON

#parameters = Mads.loadjsonfile("parameters.json")
parameters = JSON.parsefile("parameters.json"; dicttype=DataStructures.OrderedDict, use_mmap=true)

f(t) = parameters["a"] * t - parameters["b"] # a * t - b; linear model
times = 1:4
predictions = Dict(zip(map(i -> string("o", i), times), map(f, times)))

#Mads.dumpjsonfile("predictions.json", predictions)
f = open("predictions.json", "w")
JSON.print(f, predictions)
close(f)