originalSTDOUT = STDOUT;
(outRead, outWrite) = redirect_stdout();
reader = @async readstring(outRead);
println("test")
redirect_stdout(originalSTDOUT);
close(outWrite);
output = wait(reader);
close(outRead);
print(output)