import Pkg

@info "Pkg.clone(pwd())"
Pkg.clone(pwd())

@info "Pkg.build(Mads)"
Pkg.build("Mads")

import Mads

@info "Mads/deps/build.log:"
print(read(joinpath(dirname(dirname(pathof(Mads))), "deps", "build.log"), String))

@info "Pkg.build(PyCall)"
Pkg.build("PyCall")

import PyCall

@info "PyCall/deps/build.log:"
print(read(joinpath(dirname(dirname(pathof(PyCall))), "deps", "build.log"), String))

@info "Pkg.build(PyPlot)"
Pkg.build("PyPlot")

import PyPlot

@info "PyPlot/deps/build.log:"
print(read(joinpath(dirname(dirname(pathof(PyPlot))), "deps", "build.log"), String))

@info "Package versions"
show(stdout, "text/plain", Pkg.installed())
println()