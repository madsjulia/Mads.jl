using MadsASCII

parameters = MadsASCII.loadasciifile("parameters.dat") # ASCII text file created to write currend model parameters

f(t) = parameters[1] * t - parameters[2] # a * t - b; linear model
times = 1:4
predictions = map(f, times)

MadsASCII.dumpasciifile("predictions.dat", predictions) # ASCII text file created to write currend model parameters
