using Mads

Mads.madsinfo("TEST Levenberg-Marquardt optimization of an internal call problem:")
mdinternal = Mads.loadyamlmadsfile("test-internal-linearmodel.mads")
results = Mads.calibrate(mdinternal)
Mads.madsoutput("""$results\n""")
