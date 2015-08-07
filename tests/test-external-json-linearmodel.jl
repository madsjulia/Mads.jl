reload("MadsJSON.jl")

parameters = loadjsonfile("parameters.json")

f(t) = parameters["a"] * t - parameters["b"] # a * t - b; linear model
times = 1:4
predictions = Dict(map(i -> string("o", i), times), map(f, times))

dumpjsonfile("predictions.json", predictions)
