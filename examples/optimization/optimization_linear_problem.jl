using Mads

Mads.madsinfo("TEST Levenberg-Marquardt optimization of an internal call problem:")
problemdir = string((dirname(Base.source_path())))*"/"
Mads.madsinfo("""Problem directory: $(problemdir)""")
mdinternal = Mads.loadmadsfile(problemdir*"test-internal-linearmodel.mads")
results = Mads.calibrate(mdinternal)
Mads.madsoutput("""$results\n""")
