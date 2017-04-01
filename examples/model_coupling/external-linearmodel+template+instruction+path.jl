import DataStructures

i = open(joinpath("external-linearmodel+template+instruction+path", "parameters.dat"), "r")
param = readdlm(i)
close(i)
a = param[1]
b = param[2]
f(t) = a * t - b # a * t - b
times = 1:4
predictions = DataStructures.OrderedDict{String, Float64}(zip(map(i -> string("o", i), times), map(f, times)))
writedlm(joinpath("external-linearmodel+template+instruction+path", "observations.dat"), predictions)