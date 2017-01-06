import DataStructures

i = open(jointpath("testdir", "parameters.dat"), "r")
param = readdlm(i)
close(i)
a = param[1]
b = param[2]
f(t) = a * t - b # a * t - b
times = 1:4
predictions = DataStructures.OrderedDict{AbstractString, Float64}(zip(map(i -> string("o", i), times), map(f, times)))
writedlm(jointpath("testdir", "observations.dat"), predictions)