import Anasol
import AffineInvariantMCMC
import BIGUQ
import Kriging
import MetaProgTools
import ReusableFunctions
import RobustPmap
import SVR
import DocumentFunction

function pin()
	Pkg.pin("RobustPmap", v"1.0.2")
	Pkg.pin("DocumentFunction", v"1.0.0")
	Pkg.pin("SVR", v"1.2.1")
	Pkg.pin("MetaProgTools", v"1.0.0")
	Pkg.pin("Kriging", v"1.1.0")
	Pkg.pin("Anasol", v"1.0.1")
	Pkg.pin("AffineInvariantMCMC", v"1.0.1")
	Pkg.pin("BIGUQ", v"1.0.1")
	Pkg.pin("ReusableFunctions", v"1.0.2")
end

"""
Mads Modules: $madsmodules
"""
global madsmodules = ["Mads", "Anasol", "AffineInvariantMCMC", "Kriging", "BIGUQ", "ReusableFunctions", "RobustPmap", "MetaProgTools", "SVR", "DocumentFunction"]

"""
Mads Modules: $madsmodulesdoc
"""
global madsmodulesdoc = [Mads, Anasol, AffineInvariantMCMC, Kriging, BIGUQ, ReusableFunctions, RobustPmap, MetaProgTools, SVR, DocumentFunction]
