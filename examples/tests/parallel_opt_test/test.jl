import Mads
md = Mads.loadmadsfile("test-external-yaml.mads")
results = Mads.calibrate(md; usenaive=true)
results = Mads.calibrate(md)
@show results
