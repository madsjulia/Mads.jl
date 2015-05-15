using Mads

Mads.madsinfo("TEST Levenberg-Marquardt optimization of an internal call problem:")
mdinternal = Mads.loadyamlmadsfile("tests/test-internal.mads")
results = Mads.calibrate(mdinternal)
Mads.madsoutput("""$results\n""")
