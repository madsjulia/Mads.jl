import Gadfly
md = Mads.loadmadsfile("internal-polynomial.mads")
info("Information Gap analysis")
Mads.infogap(md, retries=10)