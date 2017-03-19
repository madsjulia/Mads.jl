"""
Redirect STDOUT to a reader
"""
function stdoutcaptureon()
	global outputoriginal = STDOUT;
	(outR, outW) = redirect_stdout();
	global outputread = outR;
	global outputwrite = outW;
	global outputreader = @async readstring(outputread);
end

"""
Restore STDOUT
"""
function stdoutcaptureoff()
	redirect_stdout(outputoriginal);
	close(outputwrite);
	output = wait(outputreader);
	close(outputread);
	return output
end