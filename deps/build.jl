if haskey(ENV, "MADS_NO_PYTHON")
	info("No Python will be used ...")
else
	import PyCall

	info("Checking for Python YAML ...")
	const PACKAGES = ["pyyaml"]

	try
		eval(:(@PyCall.pyimport pip))
	catch
		info("Installing pip ...")
		get_pip = joinpath(dirname(@__FILE__), "get-pip.py")
		download("https://bootstrap.pypa.io/get-pip.py", get_pip)
		run(`$(PyCall.python) $get_pip --user`)
		rm("$get_pip")
	end

	eval(:(@PyCall.pyimport pip))
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
		sleep(2)
		eval(:(@PyCall.pyimport yaml))
		info("Python YAML (pyyaml) is installed!")
	catch
		warn("Python YAML (pyyaml) installation has failed! Using Conda instead ...")
		import Conda
		Conda.add("yaml")
	end
end