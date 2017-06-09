import Mads

if !isdefined(Mads, :infogap_mpblin)
	include(joinpath(Pkg.dir("Mads"), "src-new", "MadsInfoGap.jl"))
end

Mads.infogap_mpb_lin(retries=1, maxiter=1000000, verbosity=0, seed=2015)