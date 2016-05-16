import Mads

madsdirname = Mads.getmadsdir() # get the directory where the problem is executed
if madsdirname == ""
	madsdirname = Mads.madsdir * "/../examples/contamination/"
end

md = Mads.loadmadsfile(madsdirname * "w01-w13a_w20a.mads") # load Mads input file into Julia Dictionary
rootname = Mads.getmadsrootname(md) # get problem rootname

if !haskey(ENV, "MADS_NO_PLOT") && Mads.long_tests
	Mads.plotmadsproblem(md) # display the well locations and the initial source location
end

forward_predictions = Mads.forward(md) # execute forward model simulation based on initial parameter guesses

if !haskey(ENV, "MADS_NO_PLOT") && Mads.long_tests
	Mads.plotmatches(md, forward_predictions) # plot initial matches
end

inverse_parameters, inverse_results = Mads.calibrate(md, maxEval=1, np_lambda=1, maxJacobians=1) # perform model calibration

inverse_parameters, inverse_results = Mads.calibraterandom(md, 1, maxEval=1, np_lambda=1, maxJacobians=1) 

inverse_predictions = Mads.forward(md, inverse_parameters) # execute forward model simulation based on calibrated values

if !haskey(ENV, "MADS_NO_PLOT") && Mads.long_tests
	Mads.plotmatches(md, inverse_predictions) # plot calibrated matches
end

# use only two wells
Mads.allwellsoff!(md) # turn off all wells
Mads.wellon!(md, "w13a") # use well w13a
Mads.wellon!(md, "w20a") # use well w20a

# Sensitivity analysis: spaghetti plots based on prior parameter uncertainty ranges
paramvalues=Mads.parametersample(md, 10)

if !haskey(ENV, "MADS_NO_PLOT") && Mads.long_tests
	Mads.spaghettiplots(md, paramvalues, keyword="w13a_w20a")
end
