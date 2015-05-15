using Mads

Mads.madsinfo("TEST Levenberg-Marquardt optimization of an external problem using YAML files:")
mdexternal = Mads.loadyamlmadsfile("test-external-yaml.mads")
results = Mads.calibrate(mdexternal)
Mads.madsoutput("""$results\n"""")
