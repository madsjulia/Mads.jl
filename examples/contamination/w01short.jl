import Mads
import JSON
import OrderedCollections
import ProgressMeter
using Distributed

# load MADS problem
madsdirname = Mads.getmadsdir()
Mads.madsinfo("""Mads working directory: $(madsdirname)""")
madsfilename = Mads.getmadsinputfile()
if madsfilename == ""
	madsfilename = "w01short.mads"
	Mads.madswarn("""Mads input file is empty; default value $(madsfilename) will be used""")
end
if madsdirname != ""
	madsfilenamelong = madsdirname * madsfilename
end
md = Dict()
try
	md = Mads.loadmadsfile(madsfilenamelong)
catch
	Mads.madswarn("""Mads input file: $(madsfilenamelong) is missing! Try in the local directory ...""")
	try
		madsfilenamelong = madsfilename
		md = Mads.loadmadsfile(madsfilenamelong)
	catch
		Mads.madserr("""Mads input file: $(madsfilename) is missing; quit!""")
		error("$(madsfilename) is missing")
	end
end

Mads.madsinfo("""Mads input file: $(madsfilenamelong)""")

# get MADS rootname
rootname = Mads.getmadsrootname(md)
Mads.madsinfo("""Mads root name: $(rootname)""")

# get all the parameters
paramkeys = Mads.getparamkeys(md)

# get the parameters that will be analyzed
optparamkeys = Mads.getoptparamkeys(md)

# get all the parameter initial values
paramdict_init = OrderedCollections.OrderedDict(zip(paramkeys, map(key->md["Parameters"][key]["init"], paramkeys)))

# create a function to compute concentrations
computeconcentrations = Mads.makecomputeconcentrations(md)

# compute concentrataions based on the initial values
forward_preds = computeconcentrations(paramdict_init)

# the same result can be achieved using Mads.forward(md); the above is only for demonstration purposes

forward_preds2 = Mads.forward(md)
@assert forward_preds == forward_preds2

Mads.madsinfo("Manual sensitivity analysis ...")
numberofsamples = 10
paramvalues=Mads.getparamrandom(md, numberofsamples)
Mads.allwellsoff!(md)
Mads.wellon!(md, "w1a")
Mads.spaghettiplots(md, paramvalues, keyword="w1a")

# solve the inverse problem
result = Mads.calibrate(md; show_trace=true)

# perform global SA analysis (saltelli)
saltelliresultm = Mads.saltelli(md,N=500)
Mads.plotwellSAresults(md,saltelliresultm,"w1a")
saltelliresultb = Mads.saltellibrute(md,N=500)
Mads.plotwellSAresults(md,saltelliresultb,"w1a")

# save saltelli results
f = open("$rootname-SA-results.json", "w")
JSON.print(f, saltelliresult)
close(f)

# load saltielli results
saltelliresult = JSON.parsefile("$rootname-SA-results.json"; ordered=true, use_mmap=true)

# print saltieli results
Mads.printSAresults(md, result)

# plot global SA results for a given observation point
Mads.plotwellSAresults(md,result,"w1a")

# parameter space exploration
Mads.madsinfo("Parameter space exploration ...")
numberofsamples = 100
paramvalues=Mads.getparamrandom(md, numberofsamples)
Y = Array{Float64}(undef, length(md["Observations"]),numberofsamples * length(paramvalues))
k = 0
for paramkey in keys(paramvalues)
	for i in 1:numberofsamples
		original = paramdict[paramkey]
		paramdict[paramkey] = paramvalues[paramkey][i] # set the value for each parameter
		forward_preds = computeconcentrations(paramdict)
		paramdict[paramkey] = original
		j = 1
		for obskey in keys(forward_preds)
			Y[j,i + k] = forward_preds[obskey]
			j += 1
		end
	end
	k += numberofsamples
end
# save model inputs (not recommended)
writedlm("$rootname-input.dat", paramvalues)

# save model inputs
f = open("$rootname-input.json", "w")
JSON.print(f, paramvalues)
close(f)

# load saltielli results
paramvalues = JSON.parsefile("$rootname-input.json"; ordered=true, use_mmap=true)

# save model outputs
writedlm("$rootname-output.dat", Y)
