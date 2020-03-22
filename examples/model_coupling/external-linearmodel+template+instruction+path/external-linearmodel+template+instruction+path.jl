import OrderedCollections
import DelimitedFiles

i = open(joinpath("external-linearmodel+template+instruction+path", "parameters.dat"), "r")
param = DelimitedFiles.readdlm(i)
close(i)
a = param[1]
b = param[2]
f(t) = a * t - b
times = 1:4
predictions = OrderedCollections.OrderedDict{String, Float64}(zip(map(i -> string("o", i), times), map(f, times)))
DelimitedFiles.writedlm(joinpath("external-linearmodel+template+instruction+path", "observations.dat"), predictions)