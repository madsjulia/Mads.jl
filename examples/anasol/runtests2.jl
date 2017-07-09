import Mads
import JLD
import Base.Test

srand(2017)

workdir = joinpath(Mads.madsdir, "..", "examples", "anasol")
md = Mads.loadmadsfile(joinpath(workdir, "w01pure.mads"))
ns = 10000
rsetdict = Mads.getparamrandom(md, ns)
rsetarray = hcat(map(i->rsetdict[i], keys(rsetdict))...)'
rsetarrayplus = [repmat([823], ns)'; repmat([1499], ns)'; repmat([3], ns)'; rsetarray; repmat([15], ns)']
Mads.vectoron()
computeconcentrations = Mads.makedoublearrayfunction(md)
@time rv = computeconcentrations(rsetarrayplus);
Mads.vectoroff()
@time rf = Mads.forward(md, rsetarray');
# rv == rf

include("/Users/monty/Julia/FastMadsAnasol.jl/base.jl")
ra = Array{Float64}(ns);
@time for i = 1:size(rsetarray, 2)
	ra[i] = madslike(rsetarray[:, i])[1]
end

rvd = Array{Float64}(ns);
@time for i = 1:ns
	n, lambda, theta, vx, vy, vz, ax, ay, az, H, sx, sy, sz, dx, dy, dz, f, t0, t1 = rsetarray[:, i]
	rvd[i] = Mads.contamination(823., 1499., 3., n, lambda, theta, vx, vy, vz, ax, ay, az, H, sx, sy, sz, dx, dy, dz, f, t0, t1, 15., Anasol.long_fff_bbb_iir_c)
end
