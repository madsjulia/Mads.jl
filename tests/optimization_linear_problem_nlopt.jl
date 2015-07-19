using Mads

Mads.madsinfo("TEST NLopt optimization of an internal call problem:")
mdinternal = Mads.loadyamlmadsfile("tests/test-internal.mads")
results = Mads.calibratenlopt(mdinternal)#; algorithm=:LD_MMA)
Mads.madsoutput("""$results\n""")
