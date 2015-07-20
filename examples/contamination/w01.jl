import Mads

const md = Mads.loadyamlmadsfile("w01-truth.mads")
result = Mads.calibrate(md; show_trace=true)
