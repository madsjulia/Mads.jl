using Mads

Mads.madsinfo("TEST Levenberg-Marquardt optimization of an external problem using YAML files:")
mdexternal = Mads.loadmadsfile("test-external-yaml.mads")
results = Mads.calibrate(mdexternal)
Mads.madsoutput("""$results\n"""")
