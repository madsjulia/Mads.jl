#TODO this does NOT work; `parameters` are not required to be Ordered Dictionary
paramfile = open("parameters.dat")
parameters = Meta.parse.(readlines(paramfile))
close(paramfile)

f(t) = parameters[1] * t - parameters[2] # a * t - b; linear model
times = 1:4
predictions = map(f, times)

predicfile = open("predictions.dat", "w")
for prediction in predictions
	write(predicfile, string(prediction, "\n"))
end
close(predicfile)