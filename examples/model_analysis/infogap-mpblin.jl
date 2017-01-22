if !isdefined(:infogap_mpblin)
	include(joinpath(Pkg.dir("Mads"), "src-new", "MadsInfoGap.jl"))
end

infogap_mpblin(retries=1, maxiter=1000000, verbosity=0, seed=2015)