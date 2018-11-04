import OrderedCollections
import WEFO

function madsmodelrun(parameters::AbstractDict) # MADS/WEFO run
	ESC = [parameters["ESC1c"] parameters["ESC2c"] parameters["ESC3c"]; parameters["ESC1g"] parameters["ESC2g"] parameters["ESC3g"]] # get the values
	PC = [parameters["PC1c"] parameters["PC2c"] parameters["PC3c"]; parameters["PC1g"] parameters["PC2g"] parameters["PC3g"]] # get the values
	# @show ESC
	WEFO.setvariable("ESC", ESC) # set the value in the WEFO model
	WEFO.setvariable("PC", PC) # set the value in the WEFO model
	# @show WEFO.ESC
	WEFO.set() # setup WEFO
	WEFO.solve() # solve WEFO
	of = WEFO.getobjective() # get OF
	predictions = OrderedCollections.OrderedDict(zip(["of"], [of])) # put OF into a dictionary
	return predictions # pass the OF back to MADS
end
