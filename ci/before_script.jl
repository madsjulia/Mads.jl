@static if VERSION >= v"0.7.0-"
	using Pkg
else
	macro info(x)
		:(info($(esc(x))))
	end
end

@info "Pkg.clone(pwd())"
Pkg.clone(pwd())

@info "Pkg.build(Mads)"
Pkg.build("Mads")

import Mads

if VERSION >= v"0.7.0-"
	@info "Mads/deps/build.log:"
	print(read(joinpath(dirname(dirname(pathof(Mads))), "deps", "build.log"), String))
end

@info "show_versions.jl"
include("show_versions.jl")