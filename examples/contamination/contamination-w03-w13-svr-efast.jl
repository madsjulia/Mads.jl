import Mads
import SVR

md = Mads.loadmadsfile("w03.mads") # load Mads input file into Julia Dictionary

Mads.allwellsoff!(md) # turn off all wells
Mads.wellon!(md, "w13a") # use well w13a

numberofsamples = 1000
paramdict = Mads.getparamrandom(md, numberofsamples)
paramarray = hcat(map(i->collect(paramdict[i]), keys(paramdict))...)
predictions = Mads.forward(md, paramdict)'

Mads.madsinfo("Training set spaghetti plot ...")
Mads.spaghettiplot(md, predictions, keyword="w13a-training-set", plotdata=true)
Mads.display("w03-w13a-training-set-1000-spaghetti.svg")

svrpredictions = Array(Float64, 0, numberofsamples)
for i=1:50
    pmodel = SVR.train(predictions[i,:], paramarray');
    y_pr = SVR.predict(pmodel, paramarray');
    svrpredictions = [svrpredictions; y_pr']
    SVR.freemodel(pmodel)
end

Mads.madsinfo("SVR predictions ...")
Mads.spaghettiplot(md, svrpredictions, keyword="w13a-svr", plotdata=false)
Mads.display("w03-w13a-svr-1000-spaghetti.svg")
