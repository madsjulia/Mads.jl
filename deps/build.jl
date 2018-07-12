if haskey(ENV, "MADS_NO_PYTHON")
	info("No Python will be used ...")
else
	import Compat
	import PyCall

	info("Checking for Python YAML & MatPlotLib ...")
	const PACKAGES = ["pyyaml", "matplotlib"]

	try
		info("Checking for python pip using PyCall ...")
		eval(:(@PyCall.pyimport pip))
	catch e
		println(e)
		warn("Python pip is not installed!")
		info("Downloading & installing python pip ...")
		get_pip = joinpath(dirname(@__FILE__), "get-pip.py")
		download("https://bootstrap.pypa.io/get-pip.py", get_pip)
		run(`$(PyCall.python) $get_pip --user`)
		rm("$get_pip")
	end

	try
		info("Installing Python YAML & MatPlotLib using pip ...")
		eval(:(@PyCall.pyimport pip))
		args = String[]
		if haskey(ENV, "http_proxy")
			push!(args, "--proxy")
			push!(args, ENV["http_proxy"])
		end
		push!(args, "install")
		push!(args, "--user")
		append!(args, PACKAGES)
		pip.main(args)
	catch e
		println(e)
		warn("Installing Python YAML & MatPlotLib using pip fails!")
	end

	try
		eval(:(@PyCall.pyimport yaml))
		info("Python pip YAML (pyyaml) is installed!")
	catch e
		println(e)
		warn("Python pip YAML (pyyaml) installation has failed!")
		info("Using Conda instead ...")
		import Conda
		Conda.add("yaml")
	end

	try
		eval(:(@PyCall.pyimport matplotlib))
		info("Python pip MatPlotLib is installed!")
	catch e
		println(e)
		warn("Python pip MatPlotLib installation has failed!")
		info("Using Conda instead ...")
		import Conda
		Conda.add("matplotlib")
	end
end