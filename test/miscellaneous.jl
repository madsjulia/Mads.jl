if Mads.create_tests
	Mads.create_tests_off()
	Mads.create_tests_on()
else
	Mads.create_tests_on()
	Mads.create_tests_off()
end
if Mads.long_tests
	Mads.long_tests_off()
	Mads.long_tests_on()
else
	Mads.long_tests_on()
	Mads.long_tests_off()
end
Mads.setdebuglevel(1)
Mads.setverbositylevel(1)
Mads.setdefaultplotformat("EPS")
Mads.setdefaultplotformat("SVG")
Mads.display("mads.png")
Mads.resetmodelruns()
originalSTDOUT = STDOUT;
(outRead, outWrite) = redirect_stdout();
quiet_status = Mads.quiet
Mads.quietoff()
Mads.runcmd(`ls`)
Mads.madsoutput("a")
Mads.madsdebug("a")
# Mads.madsinfo("a")
# Mads.madswarn("a")
# Mads.madserror("a")
Mads.help()
Mads.copyright()
Mads.set_nprocs_per_task(1)
Mads.setdir()
Mads.setprocs()
Mads.setprocs(0)
# Mads.functions()
# Mads.functions("test")
# Mads.functions(Mads, "test")
# Mads.create_documentation()
close(outWrite);
close(outRead);
redirect_stdout(originalSTDOUT);
Mads.quieton()
if quiet_status
	Mads.quieton()
else
	Mads.quietoff()
end
graph_status = Mads.graphoutput
Mads.graphoff()
Mads.graphon()
if graph_status
	Mads.graphon()
else
	Mads.graphoff()
end