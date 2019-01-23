import Mads

@info("Support Vector Regression (SVR) analysis")

Random.seed!(2017)

md = Mads.loadmadsfile(joinpath("..", "models", "internal-polynomial-model", "internal-polynomial.mads"))
rootname = Mads.getmadsrootname(md)
svrexec, svrread, svrsave, svrclean  = Mads.makesvrmodel(md, 100)

numberofsamples = 100
paramdict = Mads.getparamrandom(md, numberofsamples)
paramarray = hcat(map(i->collect(paramdict[i]), keys(paramdict))...)
predictions = Mads.forward(md, paramdict)'

Mads.madsinfo("Model predictions ...")
Mads.spaghettiplot(md, predictions, keyword="w13a-model", format="PNG")
Mads.display("$rootname-w13a-model-$numberofsamples-spaghetti.png")

@time svrpredictions = svrexec(paramarray)
@info("SVR discrepancy $(maximum(abs.(svrpredictions .- predictions)))")

Mads.madsinfo("SVR predictions ...")
Mads.spaghettiplot(md, svrpredictions, keyword="w13a-svr", format="PNG")
Mads.display("$rootname-w13a-svr-$numberofsamples-spaghetti.png")

sa = Mads.efast(md)
Mads.plotobsSAresults(md, sa, format="PNG")
Mads.display("$rootname-efast-385.png")

mdsvr = deepcopy(md)
mdsvr["Julia model"] = svrexec
mdsvr["Filename"] = "$rootname-svr.mads"

sasvr = Mads.efast(mdsvr)
Mads.plotobsSAresults(mdsvr, sasvr, format="PNG")
Mads.display("$rootname-svr-efast-385.png")

svrsave()
svrclean()
svrread()
svrclean()

Mads.rmdir("svrmodels")