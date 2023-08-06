import OrderedCollections
import YAML

parameters = YAML.load("parameters.yaml")
if isfile(parameters)
	parameters = YAML.load_file(parameters)
end

f(t) = parameters["a"] * t - parameters["b"] # a * t - b; linear model
times = 1:4
predictions = OrderedCollections.OrderedDict(zip(map(i -> string("o", i), times), map(f, times)))

@show predictions
YAML.write_file("predictions.yaml", predictions)