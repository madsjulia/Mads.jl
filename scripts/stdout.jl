originalSTDOUT = STDOUT;
originalSTDERR = STDERR;
(outRead, outWrite) = redirect_stdout();
(errRead, errWrite) = redirect_stderr();
outreader = @async readstring(outRead);
errreader = @async readstring(errRead);
println("test")
println(STDERR, "Goodbye, World!")
redirect_stdout(originalSTDOUT);
redirect_stderr(originalSTDERR);
close(outWrite);
output = wait(reader);
close(outRead);
close(errWrite);
error = wait(errreader);
close(errRead);
print(output)
print(error)