import Mads
import Gadfly
include(Pkg.dir("Mads") * "/src/MadsInfoGap.jl")

md = Mads.loadmadsfile("models/internal-polynomial.mads")

info("Information Gap analysis")

infogap_jump(md, retries=2, seed=2016)