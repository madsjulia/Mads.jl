using Mads

md = Mads.loadyamlmadsfile("w01.mads") # load Mads input file into Julia Dictionary
rootname = Mads.getmadsrootname(md) # get problem rootname
Mads.madsinfo("""Mads root name: $(rootname)""")
display(md) # show the content of the Mads input file
Mads.showallparameters(md) # show all the model parameters
Mads.showparameters(md) # show all the adjustable model parameters
Mads.showobservations(md) # show all the observations

# use all wells
Mads.plotmadsproblem(md) # display the well locations and the initial source location

forward_predictions = Mads.forward(md) # execute forward model simulation based on initial parameter guesses

Mads.plotmatches(md, forward_predictions) # plot initial matches
run(`open w01-match.svg`)

inverse_parameters, inverse_results = Mads.calibrate(md) # perform model calibration

inverse_predictions = Mads.forward(md, inverse_parameters) # execute forward model simulation based on calibrated values

Mads.plotmatches(md, inverse_predictions) # plot calibrated matches
run(`open w01-match.svg`)

# use only two wells
Mads.allwellsoff!(md) # turn off all wells
Mads.wellon!(md, "w13a") # use well w13a
Mads.wellon!(md, "w20a") # use well w20a

Mads.plotmadsproblem(md) # display the well locations and the initial source location

forward_predictions = Mads.forward(md) # execute forward model simulation based on initial parameter guesses

Mads.plotmatches(md, forward_predictions, filename=rootname * "-w13a_w20a-init-match.svg") # plot initial matches
run(`open w01-w13a_w20a-init-match.svg`)

inverse_parameters, inverse_results = Mads.calibrate(md) # perform model calibration

inverse_predictions = Mads.forward(md, inverse_parameters) # execute forward model simulation based on calibrated values

Mads.plotmatches(md, inverse_predictions, filename=rootname * "-w13a_w20a-calib-match.svg") # plot calibrated matches
run(`open w01-w13a_w20a-calib-match.svg`)

# Sensitivity analysis: spaghetti plots based on prior parameter uncertainty ranges
paramvalues=Mads.parametersample(md, 10)
Mads.spaghettiplots(md, paramvalues, keyword="w13a_w20a")
run(`open w01-w13a_w20a-vx-10-spaghetti.svg`)
run(`open w01-w13a_w20a-source1_t0-10-spaghetti.svg`)
run(`open w01-w13a_w20a-source1_t1-10-spaghetti.svg`)
