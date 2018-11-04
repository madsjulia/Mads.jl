import OrderedCollections
import WEFO

function madsmodelrun(parameters::AbstractDict) # MADS/WEFO run
	ESC = [parameters["ESC1c"] parameters["ESC2c"] parameters["ESC3c"]; parameters["ESC1g"] parameters["ESC2g"] parameters["ESC3g"]] # get the values
	PC = [parameters["PC1c"] parameters["PC2c"] parameters["PC3c"]; parameters["PC1g"] parameters["PC2g"] parameters["PC3g"]] # get the values
	# @show ESC
	CGWf = [parameters["CGWf1"] parameters["CGWf2"] parameters["CGWf3"]] # get the values
	CSWf = [parameters["CSWf1"] parameters["CSWf2"] parameters["CSWf3"]] # get the values
	CGWe = [parameters["CGWe1c"] parameters["CGWe2c"] parameters["CGWe3c"]; parameters["CGWe1g"] parameters["CGWe2g"] parameters["CGWe3g"]] # get the values
	CSWe = [parameters["CSWe1c"] parameters["CSWe2c"] parameters["CSWe3c"]; parameters["CSWe1g"] parameters["CSWe2g"] parameters["CSWe3g"]] # get the values
	CRWe = [parameters["CRWe1c"] parameters["CRWe2c"] parameters["CRWe3c"]; parameters["CRWe1g"] parameters["CRWe2g"] parameters["CRWe3g"]] # get the values
	CFO = [parameters["CFO1"] parameters["CFO2"] parameters["CFO3"]] # get the values
	CEA = [parameters["CEA1"] parameters["CEA2"] parameters["CEA3"]] # get the values
	CFA = [parameters["CFA1"] parameters["CFA2"] parameters["CFA3"]] # get the values
	CC = [parameters["CC1c"] parameters["CC2c"] parameters["CC3c"]; parameters["CC1g"] parameters["CC2g"] parameters["CC3g"]] # get the values
	AVCG = [parameters["AVCG1c"] parameters["AVCG2c"] parameters["AVCG3c"]; parameters["AVCG1g"] parameters["AVCG2g"] parameters["AVCG3g"]] # get the values
	Dt = [parameters["Dt1e"] parameters["Dt2e"] parameters["Dt3e"]; parameters["Dt1f"] parameters["Dt2f"] parameters["Dt3f"]] # get the values
	TMCC = parameters["TMCC"] # get the values
	a = [parameters["a1"]; parameters["a2"]] # get the values
	Water = [parameters["Water1g"] parameters["Water2g"] parameters["Water3g"]; parameters["Water1s"] parameters["Water2s"] parameters["Water3s"]; parameters["Water1r"] parameters["Water2r"] parameters["Water3r"]] # get the values

	WEFO.setvariable("ESC", ESC) # set the value in the WEFO model
	WEFO.setvariable("PC", PC) # set the value in the WEFO model
	# @show WEFO.ESC
	WEFO.setvariable("CGWf", CGWf) # set the value in the WEFO model
	WEFO.setvariable("CSWf", CSWf) # set the value in the WEFO model
	WEFO.setvariable("CGWe", CGWe) # set the value in the WEFO model
	WEFO.setvariable("CSWe", CSWe) # set the value in the WEFO model
	WEFO.setvariable("CRWe", CRWe) # set the value in the WEFO model
	WEFO.setvariable("CFO", CFO) # set the value in the WEFO model
	WEFO.setvariable("CEA", CEA) # set the value in the WEFO model
	WEFO.setvariable("CFA", CFA) # set the value in the WEFO model
	WEFO.setvariable("CC", CC) # set the value in the WEFO model
	WEFO.setvariable("AVCG", AVCG) # set the value in the WEFO model
	WEFO.setvariable("Dt", Dt) # set the value in the WEFO model
	WEFO.setvariable("TMCC", TMCC) # set the value in the WEFO model
	WEFO.setvariable("a", a) # set the value in the WEFO model
	WEFO.setvariable("Water", Water) # set the value in the WEFO model

	WEFO.set() # setup WEFO
	WEFO.solve() # solve WEFO
	of = WEFO.getobjective() # get OF
	predictions = OrderedCollections.OrderedDict(zip(["of"], [of])) # put OF into a dictionary
	return predictions # pass the OF back to MADS
end
