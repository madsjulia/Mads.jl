import Mads

md = Mads.loadmadsfile("w01.mads") # load Mads input file into Julia Dictionary
rootname = Mads.getmadsrootname(md) # get problem rootname
Mads.madsinfo("Mads root name: $(rootname)")

Mads.allwellsoff!(md) # turn off all wells
Mads.wellon!(md, "w13a") # use well w13a
Mads.wellon!(md, "w20a") # use well w20a

if !isdefined(Mads, :efastresult)
	efastresult = Mads.efast(md, N=1000, seed=2016)
end
Mads.plotobsSAresults(md, efastresult, filter=r"w13a", filename="w13a-efast.svg", xtitle = "Time [a]", ytitle = "Concentration [ppb]", separate_files=true)
Mads.plotobsSAresults(md, efastresult, filter=r"w20a", filename="w20a-efast.svg", xtitle = "Time [a]", ytitle = "Concentration [ppb]", separate_files=true)