using Mads

Mads.madsinfo("TEST NLopt optimization of an internal call problem:")
mdinternal = Mads.loadyamlmadsfile("test-internal-linearmodel.mads")
results = Mads.calibratenlopt(mdinternal)
# results = Mads.calibratenlopt(mdinternal; algorithm=:LD_MMA)
Mads.madsoutput("""$results\n""")
