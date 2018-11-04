import OrderedCollections
import WEFO

function madsmodelrun(parameters::AbstractDict) # MADS/WEFO run

	# get mads parameter values
	ESC = [parameters["ESC1c"] parameters["ESC2c"] parameters["ESC3c"];
			parameters["ESC1g"] parameters["ESC2g"] parameters["ESC3g"]]
	PC = [parameters["PC1c"] parameters["PC2c"] parameters["PC3c"];
			parameters["PC1g"] parameters["PC2g"] parameters["PC3g"]]
	CGWf = [parameters["CGWf1"] parameters["CGWf2"] parameters["CGWf3"]]
	CSWf = [parameters["CSWf1"] parameters["CSWf2"] parameters["CSWf3"]]
	CGWe = [parameters["CGWe1c"] parameters["CGWe2c"] parameters["CGWe3c"];
			parameters["CGWe1g"] parameters["CGWe2g"] parameters["CGWe3g"]]
	CSWe = [parameters["CSWe1c"] parameters["CSWe2c"] parameters["CSWe3c"];
			parameters["CSWe1g"] parameters["CSWe2g"] parameters["CSWe3g"]]
	CRWe = [parameters["CRWe1c"] parameters["CRWe2c"] parameters["CRWe3c"];
			parameters["CRWe1g"] parameters["CRWe2g"] parameters["CRWe3g"]]
	CFO = [parameters["CFO1"] parameters["CFO2"] parameters["CFO3"]]
	CEA = [parameters["CEA1"] parameters["CEA2"] parameters["CEA3"]]
	CFA = [parameters["CFA1"] parameters["CFA2"] parameters["CFA3"]]
	CC = [parameters["CC1c"] parameters["CC2c"] parameters["CC3c"];
		parameters["CC1g"] parameters["CC2g"] parameters["CC3g"]]
	AVCG = [parameters["AVCG1c"] parameters["AVCG2c"] parameters["AVCG3c"];
			parameters["AVCG1g"] parameters["AVCG2g"] parameters["AVCG3g"]]
	Dt = [parameters["Dt1e"] parameters["Dt2e"] parameters["Dt3e"];
		parameters["Dt1f"] parameters["Dt2f"] parameters["Dt3f"]]
	TMCC = parameters["TMCC"]
	Water = [parameters["Water1g"] parameters["Water2g"] parameters["Water3g"];
			parameters["Water1s"] parameters["Water2s"] parameters["Water3s"];
			parameters["Water1r"] parameters["Water2r"] parameters["Water3r"]]
	a = [parameters["a1"] parameters["a2"]]

	# set the value in the WEFO model
	WEFO.setvariable("ESC", ESC)
	WEFO.setvariable("PC", PC)
	WEFO.setvariable("CGWf", CGWf)
	WEFO.setvariable("CSWf", CSWf)
	WEFO.setvariable("CGWe", CGWe)
	WEFO.setvariable("CSWe", CSWe)
	WEFO.setvariable("CRWe", CRWe)
	WEFO.setvariable("CFO", CFO)
	WEFO.setvariable("CEA", CEA)
	WEFO.setvariable("CFA", CFA)
	WEFO.setvariable("CC", CC)
	WEFO.setvariable("AVCG", AVCG)
	WEFO.setvariable("Dt", Dt)
	WEFO.setvariable("TMCC", TMCC)
	WEFO.setvariable("Water", Water)
	WEFO.setvariable("a", a)

	WEFO.set() # setup WEFO
	WEFO.solve() # solve WEFO
	of = WEFO.getobjective() # get OF
	# WEFO.print()
	# WEFO.results()
	predictions = OrderedCollections.OrderedDict(zip(["of"], [of])) # put OF into a dictionary
	return predictions # pass the OF back to MADS
end
