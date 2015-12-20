import DataStructures
import WEFO

function madsmodelrun(parameters::Associative) # MADS/WEFO run
	ESC = [parameters["ESC1c"] parameters["ESC2c"] parameters["ESC3c"]; parameters["ESC1g"] parameters["ESC2g"] parameters["ESC3g"]]
	# @show ESC
	WEFO.setvariable("ESC", ESC)
	# @show WEFO.ESC
	WEFO.set()
	WEFO.solve()
	of = WEFO.getobjective()
	predictions = DataStructures.OrderedDict(zip(["of"], [of]))
	return predictions
end
