import Mads
md = Mads.loadyamlmadsfile("test-external-yaml.mads")
results = Mads.calibrate(md; usenaive=true)
results = Mads.calibrate(md)
@show results
