import Mads
import Test

Random.seed!(2017)

workdir = joinpath(Mads.madsdir, "examples", "anasol")
md = Mads.loadmadsfile(joinpath(workdir, "w01purebig.mads"))
ns = 100
rsetdict = Mads.getparamrandom(md, ns)
rsetarray = hcat(map(i->rsetdict[i], keys(rsetdict))...)'

@info("Mads")
@time rf = Mads.forward(md, rsetarray);

@info("FastMadsAnasol")
include("/Users/monty/Julia/FastMadsAnasol.jl/base.jl")
@makemadslikeanasol madslike "w01purebig.mads"
ra = Array{Float64}(undef, ns);
for i = 1:ns
    ra[i] = madslike(rsetarray[:, i])[1]
end
@time for i = 1:ns
	ra[i] = madslike(rsetarray[:, i])[1]
end
