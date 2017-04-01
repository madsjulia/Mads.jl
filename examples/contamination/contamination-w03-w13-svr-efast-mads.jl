import Mads
import SVR

md = Mads.loadmadsfile("w03.mads") # load Mads input file into Julia Dictionary
rootname = Mads.getmadsrootname(md)

Mads.allwellsoff!(md) # turn off all wells
Mads.wellon!(md, "w13a") # use well w13a

svrexec, svrclean = Mads.makesvrmodel(md; check=true)

numberofsamples = 100
paramdict = Mads.getparamrandom(md, numberofsamples)
paramarray = hcat(map(i->collect(paramdict[i]), keys(paramdict))...)
@time predictions = Mads.forward(md, paramdict)'

Mads.madsinfo("Training set spaghetti plot ...")
Mads.spaghettiplot(md, predictions, keyword="w13a-training-set", format="PNG")
Mads.display("$rootname-w13a-training-set-$numberofsamples-spaghetti.png")

@time svrpredictions = svrexec(paramarray)
info("SVR discrepancy $(maximum(abs.(svrpredictions .- predictions)))")

Mads.madsinfo("SVR predictions ...")
Mads.spaghettiplot(md, svrpredictions, keyword="w13a-svr", format="PNG")
Mads.display("$rootname-w13a-svr-$numberofsamples-spaghetti.png")

svrclean()
