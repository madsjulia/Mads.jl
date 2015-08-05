#using Mads

#parameters = Mads.loadasciifile("parameters.dat") # ASCII text file created to write currend model parameters
paramfile = open("parameters.dat")
parameters = map(float, readlines(paramfile))
close(paramfile)

f(t) = parameters[1] * t - parameters[2] # a * t - b; linear model
times = 1:4
predictions = map(f, times)

predicfile = open("predictions.dat", "w")
for prediction in predictions
	write(predicfile, string(prediction, "\n"))
end
close(predicfile)
#Mads.dumpasciifile("predictions.dat", predictions) # ASCII text file created to write currend model parameters
