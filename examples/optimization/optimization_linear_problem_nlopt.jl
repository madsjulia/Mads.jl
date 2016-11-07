import Mads

problemdir = string((dirname(Base.source_path())))*"/"

Mads.madsinfo("NLopt optimization of an internal call problem:")
mdinternal = Mads.loadmadsfile(problemdir*"internal-linearmodel.mads")
results = Mads.calibratenlopt(mdinternal)
# results = Mads.calibratenlopt(mdinternal; algorithm=:LD_MMA)
# Mads.madsoutput("""$results\n""")
