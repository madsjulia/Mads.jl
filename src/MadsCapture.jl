import DocumentFunction

"""
Capture STDOUT of a block
"""
macro stdoutcapture(block)
	if quiet
		quote
			if ccall(:jl_generating_output, Cint, ()) == 0
				outputoriginal = STDOUT;
				(outR, outW) = redirect_stdout();
				outputreader = @async readstring(outR);
				evalvalue = $(esc(block))
				redirect_stdout(outputoriginal);
				close(outW);
				close(outR);
				return evalvalue
			end
		end
	else
		quote
			evalvalue = $(esc(block))
		end
	end
end

"""
Capture STDERR of a block
"""
macro stderrcapture(block)
	if quiet
		quote
			if ccall(:jl_generating_output, Cint, ()) == 0
				errororiginal = STDERR;
				(errR, errW) = redirect_stderr();
				errorreader = @async readstring(errR);
				evalvalue = $(esc(block))
				redirect_stderr(errororiginal);
				close(errW);
				close(errR);
				return evalvalue
			end
		end
	else
		quote
			evalvalue = $(esc(block))
		end
	end
end

"""
Capture STDERR & STDERR of a block
"""
macro stdouterrcapture(block)
	if quiet
		quote
			if ccall(:jl_generating_output, Cint, ()) == 0
				outputoriginal = STDOUT;
				(outR, outW) = redirect_stdout();
				outputreader = @async readstring(outR);
				errororiginal = STDERR;
				(errR, errW) = redirect_stderr();
				errorreader = @async readstring(errR);
				evalvalue = $(esc(block))
				redirect_stdout(outputoriginal);
				close(outW);
				close(outR);
				redirect_stderr(errororiginal);
				close(errW);
				close(errR);
				return evalvalue
			end
		end
	else
		quote
			evalvalue = $(esc(block))
		end
	end
end

"""
Redirect STDOUT to a reader

$(DocumentFunction.documentfunction(stdoutcaptureon))
"""
function stdoutcaptureon()
	if capture
		global outputoriginal = STDOUT;
		(outR, outW) = redirect_stdout();
		global outputread = outR;
		global outputwrite = outW;
		global outputreader = @async readstring(outputread);
	end
end

"""
Restore STDOUT

$(DocumentFunction.documentfunction(stdoutcaptureoff))

Returns:

- standered output
"""
function stdoutcaptureoff()
	if capture
		redirect_stdout(outputoriginal);
		close(outputwrite);
		output = wait(outputreader);
		close(outputread);
		return output
	end
end

"""
Redirect STDERR to a reader

$(DocumentFunction.documentfunction(stderrcaptureon))
"""
function stderrcaptureon()
	if capture
		global errororiginal = STDERR;
		(errR, errW) = redirect_stderr();
		global errorread = errR;
		global errorwrite = errW;
		global errorreader = @async readstring(errorread);
	end
end

"""
Restore STDERR

$(DocumentFunction.documentfunction(stderrcaptureoff))

Returns:

- standered error
"""
function stderrcaptureoff()
	if capture
		redirect_stderr(errororiginal);
		close(errorwrite);
		erroro = wait(errorreader)
		close(errorread);
		return erroro
	end
end

"""
Redirect STDOUT & STDERR to readers

$(DocumentFunction.documentfunction(stdouterrcaptureon))
"""
function stdouterrcaptureon()
	if capture
		stdoutcaptureon()
		stderrcaptureon()
	end
end

"""
Restore STDOUT & STDERR

$(DocumentFunction.documentfunction(stdouterrcaptureoff))

Returns:

- standered output amd standered error
"""
function stdouterrcaptureoff()
	if capture
		return stdoutcaptureoff(), stderrcaptureoff()
	end
end
