if Mads.quiet
	Mads.quietoff()
	Mads.quieton()
else
	Mads.quieton()
	Mads.quietoff()
end
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
Mads.resetmodelruns()
originalSTDOUT = STDOUT;
(outRead, outWrite) = redirect_stdout();
Mads.quietoff()
Mads.madsoutput("a")
Mads.madsdebug("a")
# Mads.madsinfo("a")
# Mads.madswarn("a")
# Mads.madserror("a")
Mads.help()
Mads.copyright()
# Mads.functions()
# Mads.functions("test")
# Mads.functions(Mads, "test")
# Mads.create_documentation()
close(outWrite);
close(outRead);
redirect_stdout(originalSTDOUT);
Mads.quieton()