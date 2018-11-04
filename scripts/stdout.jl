originalstdout = stdout;
originalstderr = stderr;
(outRead, outWrite) = redirect_stdout();
(errRead, errWrite) = redirect_stderr();
outreader = @async read(outRead, String);
errreader = @async read(errRead, String);
println("test")
println(stderr, "Goodbye, World!")
redirect_stdout(originalstdout);
redirect_stderr(originalstderr);
close(outWrite);
output = wait(reader);
close(outRead);
close(errWrite);
error = wait(errreader);
close(errRead);
print(output)
print(error)