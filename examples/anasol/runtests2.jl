import Mads
import Test

Random.seed!(2017)

workdir = joinpath(Mads.dir, "examples", "anasol")
md = Mads.loadmadsfile(joinpath(workdir, "w01pure.mads"))
ns = 10000
rsetdict = Mads.getparamrandom(md, ns)
rsetarray = permutedims(hcat(collect(values(rsetdict))...))
# add fixed parameters to rsetarray
rsetarrayplus = [fill(823.0, ns)'; fill(1499.0, ns)'; fill(3.0, ns)'; rsetarray; fill(15.0, ns)']
Mads.vectoron()
computeconcentrations = Mads.makedoublearrayfunction(md)
@time rv = computeconcentrations(rsetarrayplus);
# this is slow because concentration function is created each time
# rfs = Array{Float64}(undef, ns);
# @time for i = 1:ns
# 	rfs[i] = Mads.forward(md, rsetarrayplus[:, i])
# end

Mads.vectoroff()
@time rf = Mads.forward(md, rsetarray);

# rv == rf

include("/Users/monty/Julia/FastMadsAnasol.jl/base.jl")
@makemadslikeanasol madslike "w01pure.mads"
ra = Array{Float64}(undef, ns);
for i = 1:ns
	ra[i] = madslike(rsetarray[:, i])[1]
end
@time for i = 1:ns
	ra[i] = madslike(rsetarray[:, i])[1]
end

rvd = Array{Float64}(undef, ns);
@time for i = 1:ns
	rvd[i] = Mads.contamination(823.0, 1499.0, 3.0, rsetarray[:, i]..., 15.0, Anasol.long_fff_bbb_iir_c)
end
