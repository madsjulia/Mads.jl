if haskey(ENV, "MADS_NO_PYTHON")
	@info("No Python will be used ...")
else
	import PyCall

	@info("Checking for Python YAML & MatPlotLib ...")
	const PACKAGES = ["pyyaml", "matplotlib"]

	try
		Core.eval(Main, :(PyCall.pyimport("yaml")))
		Core.eval(Main, :(PyCall.pyimport("matplotlib")))
		@info("Python YAML (pyyaml) and MatPlotLib are already installed!")
	catch errmsg
		println(errmsg)
		@warn("Python YAML (pyyaml) and MatPlotLib are not installed!")

		try
			@info("Checking for python pip using PyCall ...")
			Core.eval(Main, :(PyCall.pyimport("pip")))
		catch errmsg
			println(errmsg)
			@warn("Python pip is not installed!")
			@info("Downloading & installing python pip ...")
			global get_pip = joinpath(dirname(@__FILE__), "get-pip.py")
			download("https://bootstrap.pypa.io/get-pip.py", get_pip)
			run(`$(PyCall.python) $get_pip --user`)
			rm("$get_pip")
		end

		try
			@info("Installing Python YAML & MatPlotLib using pip ...")
			Core.eval(Main, :(PyCall.pyimport("pip")))
			global proxy_args = String[]
			if haskey(ENV, "http_proxy")
				push!(proxy_args, "--proxy")
				push!(proxy_args, ENV["http_proxy"])
			end
			println("Installing required python packages using pip")
			run(`$(PyCall.python) $(proxy_args) -m pip install --user --upgrade pip setuptools`)
			run(`$(PyCall.python) $(proxy_args) -m pip install --user $(PACKAGES)`)
		catch errmsg
			println(errmsg)
			@warn("Installing Python YAML & MatPlotLib using pip fails!")
		end

		try
			Core.eval(Main, :(PyCall.pyimport("yaml")))
			@info("Python YAML (pyyaml) is installed using pip!")
		catch errmsg
			println(errmsg)
			@warn("Python YAML (pyyaml) installation using pip has failed!")
			@info("Using Conda instead ...")
			import Conda
			Conda.add("pyyaml")
		end

		try
			Core.eval(Main, :(PyCall.pyimport("matplotlib")))
			@info("Python MatPlotLib is installed using pip!")
		catch errmsg
			println(errmsg)
			@warn("Python MatPlotLib installation using pip has failed!")
			@info("Using Conda instead ...")
			import Conda
			Conda.add("matplotlib")
		end
	end
end