using Mads

# external execution test using ASCII files
Mads.madsinfo("TEST Levenberg-Marquardt optimization of an external call problem using ASCII files:")
mdexternal = Mads.loadmadsfile("test-external-json.mads")
results = Mads.calibrate(mdexternal)
Mads.madsoutput("$results\n")
