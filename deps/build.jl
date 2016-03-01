info("Checking for Python YAML ...")
using PyCall

const PACKAGES = ["pyyaml"]

try
	@pyimport pip
catch
	info("Installing pip ...")
	get_pip = joinpath(dirname(@__FILE__), "get-pip.py")
	download("https://bootstrap.pypa.io/get-pip.py", get_pip)
	run(`$(PyCall.python) $get_pip --user`)
	rm("$get_pip")
end

@pyimport pip
args = UTF8String[]
if haskey(ENV, "http_proxy")
	push!(args, "--proxy")
	push!(args, ENV["http_proxy"])
end
push!(args, "install")
push!(args, "--user")
append!(args, PACKAGES)

pip.main(args)

try
	@pyimport yaml
	info("Python YAML is available ...")
catch
	warn("Installation of pyyaml failed! Using Conda instead ...")
	import Conda
	Conda.add("yaml")
end
