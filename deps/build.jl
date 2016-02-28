info("Python YAML ...")
import PyCall
import Conda
try
	@PyCall.pyimport yaml
	info("System Python YAML ...")
catch
	Conda.add("yaml")
	info("Conda Python YAML ...")
end
