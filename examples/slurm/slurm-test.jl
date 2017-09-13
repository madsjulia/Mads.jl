info("start")
include(joinpath(Pkg.dir("Mads"), "src-interactive/MadsParallel.jl"))
info("setprocs")
setprocs(ntasks_per_node=16)

info("import")
reload("Mads")
@everywhere Mads.quietoff()
info("set")

info("load")
f = "external-linearmodel+template+instruction.mads"
filename = Mads.getnextmadsfilename(f)
info("$filename")
md = Mads.loadmadsfile(filename)
# Mads.addkeyword!(md, "respect_space")
md["Restart"]= true
# info("forward")
# Mads.forward(md)
#@show ReusableFunctions.restarts
# info("local SA")
# sa_results = Mads.localsa(md, datafiles=true, imagefiles=true)
#@show ReusableFunctions.restarts
#JLD.save("lsa_results.jld", "lsa_results", lsa_results)
parameters_old = Mads.getparamdict(md)
while true
	info("calibrate")
	inverse_parameters, inverse_results = Mads.calibrate(md; np_lambda=36, lambda_mu=1.5, tolX=1e-16)
	if parameters_old == inverse_parameters
		warn("Calibration done!")
		break
	end
	parameters_old = inverse_parameters
	#@show ReusableFunctions.restarts
	Mads.setparamsinit!(md, inverse_parameters)
	Mads.savemadsfile(md)
	filename = Mads.setnewmadsfilename(md)
	info("$filename")
	md["Filename"] = filename
end
