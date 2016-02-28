info("Adding Python YAML ...")
import PyCall
import Conda
try
	@PyCall.pyimport yaml
catch
	ENV["PYTHON"]=""
	Conda.add("yaml")
end
