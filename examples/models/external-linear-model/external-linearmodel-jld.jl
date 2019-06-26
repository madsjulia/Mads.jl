import Pkg
!haskey(Pkg.installed(), "JLD") && Pkg.add("JLD")
import JLD
!haskey(Pkg.installed(), "FileIO") && Pkg.add("FileIO")
import FileIO
!haskey(Pkg.installed(), "OrderedCollections") && Pkg.add("OrderedCollections")
import OrderedCollections

parameters = FileIO.load("parameters.jld") # JLD file created to write current model parameters

f(t) = parameters["a"] * t - parameters["b"] # a * t - b; linear model
times = 1:4
predictions = OrderedCollections.OrderedDict(zip(map(i -> string("o", i), times), map(f, times)))

FileIO.save("predictions.jld", predictions) # JLD file created to write current model predictions