import Mads

currentdir = pwd()

madsdirname = Mads.getmadsdir() # get the directory where the problem is executed
if madsdirname == ""
	madsdirname = Mads.madsdir * "/../examples/contamination/"
end

cd(madsdirname)

md = Mads.loadmadsfile("w01.mads") # load Mads input file into Julia Dictionary
rootname = Mads.getmadsrootname(md) # get problem rootname
Mads.madsinfo("Mads root name: $(rootname)")
display(md) # show the content of the Mads input file
Mads.showallparameters(md) # show all the model parameters
Mads.showparameters(md) # show all the adjustable model parameters

# use all wells
Mads.plotmadsproblem(md, keyword="all_wells") # display the well locations and the initial source location

forward_predictions = Mads.forward(md) # execute forward model simulation based on initial parameter guesses

Mads.plotmatches(md, forward_predictions) # plot initial matches
run(`open w01-match.svg`) # works only on mac os x

inverse_parameters, inverse_results = Mads.calibrate(md) # perform model calibration

inverse_predictions = Mads.forward(md, inverse_parameters) # execute forward model simulation based on calibrated values

Mads.plotmatches(md, inverse_predictions) # plot calibrated matches
run(`open w01-match.svg`) # works only on mac os x

# use only two wells
Mads.allwellsoff!(md) # turn off all wells
Mads.wellon!(md, "w13a") # use well w13a
Mads.wellon!(md, "w20a") # use well w20a
Mads.showobservations(md) # show all the observations

Mads.plotmadsproblem(md, keyword="w13a_w20a") # display the well locations and the initial source location

forward_predictions = Mads.forward(md) # execute a forward model simulation based on the initial parameter guesses

Mads.plotmatches(md, forward_predictions, filename=rootname * "-w13a_w20a-init-match.svg") # plot initial matches
run(`open w01-w13a_w20a-init-match.svg`) # works only on mac os x

inverse_parameters, inverse_results = Mads.calibrate(md) # perform model calibration

inverse_predictions = Mads.forward(md, inverse_parameters) # execute a forward model simulation based on the calibrated values

Mads.plotmatches(md, inverse_predictions, filename=rootname * "-w13a_w20a-calib-match.svg") # plot calibrated matches
run(`open w01-w13a_w20a-calib-match.svg`) # works only on mac os x

# Sensitivity analysis: spaghetti plots based on prior parameter uncertainty ranges
Mads.madsinfo("Prior spaghetti plot ...")
paramvalues=Mads.parametersample(md, 100)
Mads.spaghettiplot(md, paramvalues, keyword="w13a_w20a-prior")
run(`open w01-w13a_w20a-prior-100-spaghetti.svg`) # works only on mac os x

Mads.madsinfo("Bayesian sampling ...")
mcmcchain = Mads.bayessampling(md, seed=20151001)

Mads.madsinfo("Bayesian scatter plots ...")
Mads.scatterplotsamples(md, mcmcchain.value', rootname * "-bayes.png")

# convert the parameters in the chain to a parameter dictionary of arrays
mcmcvalues = Mads.paramarray2dict(md, mcmcchain.value') 

Mads.madsinfo("Posterior (Bayesian) spaghetti plot ...")
Mads.spaghettiplot(md, mcmcvalues, keyword="w13a_w20a-posterior", format="PNG")
run(`open w01-w13a_w20a-posterior-1000-spaghetti.png`) # works only on mac os x

# Create a new problem (example)
md_new = deepcopy(md)
Mads.allwellson!(md_new) # turn on all wells
Mads.setparamsinit!(md_new, inverse_parameters) # set the initial guesses to the inverse estimates
md_new["Sources"][1]["gauss"] = md_new["Sources"][1]["box"] # create a Gaussian source based on the existing box source
delete!(md_new["Sources"][1], "box") # delete the unneeded box source
md_new["Parameters"]["vx"]["init"] = 25 # change the velocity
md_new["Parameters"]["source1_t0"]["init"] = 4 # change the release time
md_new["Parameters"]["source1_t1"]["init"] = 5 # change the termination time
md_new["Parameters"]["source1_dx"]["init"] = 0 # set a point source
md_new["Parameters"]["source1_dy"]["init"] = 0 # set a point source
md_new["Parameters"]["source1_dz"]["init"] = 0 # set a point source
md_new["Sources"][1]["gauss"]["t0"]["init"] = 4 # change the release time
md_new["Sources"][1]["gauss"]["t1"]["init"] = 5 # change the termination time
md_new["Sources"][1]["gauss"]["dx"]["init"] = 0 # set a point source
md_new["Sources"][1]["gauss"]["dy"]["init"] = 0 # set a point source
md_new["Sources"][1]["gauss"]["dz"]["init"] = 0 # set a point source
new_forward_predictions = Mads.forward(md_new) # execute a forward model simulation
Mads.setobservationtargets!(md_new, new_forward_predictions) # set calibration targets to match the forward model predictions
Mads.plotmatches(md_new, new_forward_predictions, filename=rootname * "-new-problem.svg")
run(`open w01-new-problem.svg`) # works only on mac os x
Mads.dumpyamlmadsfile(md_new, "w01-new-problem.mads") # write out a new mads input file

# Calibrate with random initial guesses
Mads.allwellsoff!(md_new) # turn off all wells
Mads.wellon!(md_new, "w13a") # use well w13a
Mads.calibraterandom(md_new, 10, seed=20151001) # calibrate 10 times with random initial guesses

cd(currentdir)
