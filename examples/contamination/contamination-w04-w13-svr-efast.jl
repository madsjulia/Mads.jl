import Mads
import SVR

md = Mads.loadmadsfile("w04.mads") # load Mads input file into Julia Dictionary
rootname = Mads.getmadsrootname(md)

Mads.allwellsoff!(md) # turn off all wells
Mads.wellon!(md, "w13a") # use well w13a

numberofsamples = 100
if !isdefined(Mads, :predictions) || size(predictions) != numberofsamples
	paramdict = Mads.getparamrandom(md, numberofsamples)
	paramarray = hcat(map(i->collect(paramdict[i]), keys(paramdict))...)
	predictions = Mads.forward(md, paramdict)'
end

Mads.madsinfo("Training set spaghetti plot ...")
Mads.spaghettiplot(md, predictions, keyword="w13a-training-set", format="PNG")
Mads.display("$rootname-w13a-training-set-$numberofsamples-spaghetti.png")

svrpredictions = Array{Float64}(undef, 0, numberofsamples)
for i=1:50
	pmodel = SVR.train(predictions[i,:], paramarray'; eps=0.001, C=10000.);
	y_pr = SVR.predict(pmodel, paramarray');
	SVR.freemodel(pmodel)
	svrpredictions = [svrpredictions; y_pr']
end
@show maximum(abs.(svrpredictions .- predictions))

Mads.madsinfo("SVR predictions ...")
Mads.spaghettiplot(md, svrpredictions, keyword="w13a-svr", format="PNG")
Mads.display("$rootname-w13a-svr-$numberofsamples-spaghetti.png")
