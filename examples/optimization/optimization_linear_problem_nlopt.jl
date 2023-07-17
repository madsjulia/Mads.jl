import Mads

problemdir = string((dirname(Base.source_path())))
if problemdir == "."
	problemdir = joinpath(Mads.dir, "examples", "optimization")
end

Mads.madsinfo("NLopt optimization of an internal call problem:")
mdinternal = Mads.loadmadsfile(joinpath(problemdir, "internal-linearmodel.mads"))
results = Mads.calibratenlopt(mdinternal)
# results = Mads.calibratenlopt(mdinternal; algorithm=:LD_MMA)
# Mads.madsoutput("""$results\n""")