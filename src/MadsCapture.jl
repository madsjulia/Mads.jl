import DocumentFunction

"""
Capture stdout of a block
"""
macro stdoutcapture(block)
	if quiet
		quote
			if ccall(:jl_generating_output, Cint, ()) == 0
				outputoriginal = stdout;
				(outR, outW) = redirect_stdout();
				outputreader = @async read(outR, String);
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
Capture stderr of a block
"""
macro stderrcapture(block)
	if quiet
		quote
			if ccall(:jl_generating_output, Cint, ()) == 0
				errororiginal = stderr;
				(errR, errW) = redirect_stderr();
				errorreader = @async read(errR, String);
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
Capture stderr & stderr of a block
"""
macro stdouterrcapture(block)
	if quiet
		quote
			if ccall(:jl_generating_output, Cint, ()) == 0
				outputoriginal = stdout;
				(outR, outW) = redirect_stdout();
				outputreader = @async read(outR, String);
				errororiginal = stderr;
				(errR, errW) = redirect_stderr();
				errorreader = @async read(errR, String);
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
Redirect stdout to a reader

$(DocumentFunction.documentfunction(stdoutcaptureon))
"""
function stdoutcaptureon()
	if capture
		global outputoriginal = stdout;
		(outR, outW) = redirect_stdout();
		global outputread = outR;
		global outputwrite = outW;
		global outputreader = @async read(outputread, String);
	end
end

"""
Restore stdout

$(DocumentFunction.documentfunction(stdoutcaptureoff))

Returns:

- standered output
"""
function stdoutcaptureoff()
	if capture
		redirect_stdout(outputoriginal);
		close(outputwrite);
		output = fetch(outputreader);
		close(outputread);
		return output
	end
end

"""
Redirect stderr to a reader

$(DocumentFunction.documentfunction(stderrcaptureon))
"""
function stderrcaptureon()
	if capture
		global errororiginal = stderr;
		(errR, errW) = redirect_stderr();
		global errorread = errR;
		global errorwrite = errW;
		global errorreader = @async read(errorread, String);
	end
end

"""
Restore stderr

$(DocumentFunction.documentfunction(stderrcaptureoff))

Returns:

- standered error
"""
function stderrcaptureoff()
	if capture
		redirect_stderr(errororiginal);
		close(errorwrite);
		erroro = fetch(errorreader)
		close(errorread);
		return erroro
	end
end

"""
Redirect stdout & stderr to readers

$(DocumentFunction.documentfunction(stdouterrcaptureon))
"""
function stdouterrcaptureon()
	if capture
		stdoutcaptureon()
		stderrcaptureon()
	end
end

"""
Restore stdout & stderr

$(DocumentFunction.documentfunction(stdouterrcaptureoff))

Returns:

- standered output amd standered error
"""
function stdouterrcaptureoff()
	if capture
		return stdoutcaptureoff(), stderrcaptureoff()
	end
end
