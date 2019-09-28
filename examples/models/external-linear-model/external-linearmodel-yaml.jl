import Pkg
!haskey(Pkg.installed(), "OrderedCollections") && Pkg.add("OrderedCollections")
import OrderedCollections
!haskey(Pkg.installed(), "PyCall") && Pkg.add("PyCall")
import PyCall
yaml = PyCall.pyimport("yaml") # PyYAML installation is problematic on some machines

# parameters = Mads.loadyamlfile("parameters.yaml") # YAML file created to write current model parameters

o = open("parameters.yaml")
parameters = yaml.load(o)
close(o)

f(t) = parameters["a"] * t - parameters["b"] # a * t - b; linear model
times = 1:4
predictions = OrderedCollections.OrderedDict(zip(map(i -> string("o", i), times), map(f, times)))

# Mads.dumpyamlfile("predictions.yaml", predictions) # YAML file created to write current model predictions

o = open("predictions.yaml", "w")
write(o, yaml.dump(predictions, width=255)) # predictions are saved as a Dict not as a OrderedDict
close(o)
