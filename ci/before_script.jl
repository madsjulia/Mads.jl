import Pkg

@info "Pkg.clone(pwd())"
Pkg.clone(pwd())

@info "Pkg.build(Mads)"
Pkg.build("Mads")

import Mads

@info "Mads/deps/build.log:"
print(read(joinpath(dirname(dirname(pathof(Mads))), "deps", "build.log"), String))

@info "show_versions.jl"
include("show_versions.jl")