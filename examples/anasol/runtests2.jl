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
rv == rf
