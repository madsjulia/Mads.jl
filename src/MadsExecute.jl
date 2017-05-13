function checknodedir(node::String, dir::String, waittime::Float64=10.) # 10 seconds
	proc = spawn(`ssh -t $node ls $dir`)
	timedwait(() -> process_exited(proc), waittime)
	if process_running(proc)
		kill(proc)
		return false
	end
	return true
end
function checknodedir(dir::String, waittime::Float64=20.) # 20 seconds
	if is_windows()
		proc = spawn(`cmd /C dir $dir)`)
	elseif Mads.madsbash
		proc = spawn(`bash -c "ls $dir; julia -p 2 -e '@everywhere @show pwd()' > julia-test.out"`)
	else
		proc = spawn(`sh -c "ls $dir"`)
	end
	timedwait(() -> process_exited(proc), waittime)
	if process_running(proc)
		kill(proc)
		return false
	end
	return true
end

@doc """
Check if a directory is readable

$(DocumentFunction.documentfunction(checknodedir))
""" checknodedir

function runcmd(cmd::Cmd; quiet::Bool=quietdefault, pipe::Bool=false, waittime::Float64=executionwaittime)
	if pipe
		cmdin = Pipe()
		cmdout = Pipe()
		cmderr = Pipe()
		cmdproc = spawn(cmd, (cmdin, cmdout, cmderr))
	else
		cmdproc = spawn(cmd)
	end
	if waittime > 0
		timedwait(() -> process_exited(cmdproc), waittime)
		if process_running(cmdproc)
			kill(cmdproc)
			return false
		end
	else
		wait(cmdproc)
	end
	# @show cmdproc.exitcode
	# @show cmdproc.termsignal
	if pipe
		close(cmdin)
		close(cmdout.in)
		close(cmderr.in)
		if !quiet || cmdproc.exitcode != 0
			erroutput = readlines(cmderr)
			if length(erroutput) > 0
				for i in erroutput
					warn("$(strip(i))")
				end
			end
		end
		if !quiet || cmdproc.exitcode != 0
			output = readlines(cmdout)
			l = length(output)
			if l > 0
				s = (l < 100) ? 1 : l - 100
				for i in output[s:end]
					println("$(strip(i))")
					if ismatch(r"error"i, i)
						madswarn("$(strip(i))")
					end
				end
			end
		end
	end
	if cmdproc.exitcode != 0
		warn("Execution of command `$(string(cmd))` produced an error ($(mdproc.exitcode))!")
	end
	if pipe
		return cmdout, cmderr
	else
		return nothing
	end
end
function runcmd(cmdstring::String; quiet::Bool=quietdefault, pipe::Bool=false, waittime::Float64=executionwaittime)
	if is_windows()
		r = runcmd(`cmd /C $(cmdstring)`; quiet=quiet, pipe=pipe, waittime=waittime)
	elseif Mads.madsbash
		r = runcmd(`bash -c "$(cmdstring)"`; quiet=quiet, pipe=pipe, waittime=waittime)
	else
		r = runcmd(`sh -c "$(cmdstring)"`; quiet=quiet, pipe=pipe, waittime=waittime)
	end
	return r
end

@doc """
Run external command and pipe stdout and stderr

$(DocumentFunction.documentfunction(runcmd))
""" runcmd