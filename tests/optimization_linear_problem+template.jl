using Mads

Mads.madsinfo("TEST Levenberg-Marquardt optimization of an internal call problem using templates and Julia script to parse the model outputs:")
problemdir = string((dirname(Base.source_path())))*"/"
Mads.madsinfo("""Problem directory: $(problemdir)""")
mdinternal = Mads.loadyamlmadsfile(problemdir*"test-internal-linearmodel+template.mads")
results = Mads.calibrate(mdinternal)
Mads.madsoutput("""$results\n""")
