import Mads

md = Mads.loadmadsfile("w03.mads") # load Mads input file into Julia Dictionary
rootname = Mads.getmadsrootname(md) # get problem rootname

Mads.plotmadsproblem(md, keyword="all_wells") # display the well locations and the initial source location
Mads.plotmatches(md) # plot initial matches

Mads.allwellsoff!(md) # turn off all wells
Mads.wellon!(md, "w13a") # use well w13a
Mads.wellon!(md, "w20a") # use well w20a

numberofsamples = 10
paramdict = Mads.getparamrandom(md, numberofsamples)
paramarray = hcat(map(i->collect(paramdict[i]), keys(paramdict))...)
predictions = Mads.forward(md, paramdict)'
wd = Mads.getwelldata(md, time=true)'

# data = Array{Float64}(undef, 0, size(paramarray, 2) + size(wd, 2) + 1)
# for i = 1:numberofsamples
#	data = [data; repmat(paramarray[i,:], 100) wd predictions[:,i]]
# end
# display(data)

# Sensitivity analysis: spaghetti plots based on prior parameter uncertainty ranges
Mads.madsinfo("Prior spaghetti plot ...")
Mads.spaghettiplot(md, predictions, keyword="w13a_w20a-prior")

Mads.madsinfo("Bayesian sampling ...")
mcmcchain = Mads.bayessampling(md, seed=20151001)

Mads.madsinfo("Bayesian scatter plots ...")
Mads.scatterplotsamples(md, mcmcchain.value', rootname * "-bayes.png")

posterior_predictions = Mads.forward(md, mcmcchain.value')
Mads.madsinfo("Posterior (Bayesian) spaghetti plot ...")
Mads.spaghettiplot(md, posterior_predictions, keyword="w13a_w20a-posterior", format="PNG")