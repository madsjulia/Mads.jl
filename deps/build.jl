info("Python YAML ...")
import PyCall
import Conda
try
	@PyCall.pyimport yaml
	info("System Python YAML ...")
catch
	ENV["PYTHON"]=""
	Conda.add("yaml")
	info("Conda Python YAML ...")
end
