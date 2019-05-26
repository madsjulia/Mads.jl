import DocumentFunction

function checknodedir(node::String, dir::String, waittime::Float64=10.) # 10 seconds
	proc = run(`ssh -t $node ls $dir`; wait=false)
	timedwait(() -> process_exited(proc), waittime)
	if process_running(proc)
		kill(proc)
		return false
	end
	return true
end
function checknodedir(dir::String, waittime::Float64=10.) # 10 seconds
	if Sys.iswindows()
		proc = run(`cmd /C dir $dir`; wait=false)
	elseif Mads.madsbash
		proc = run(`bash -c "ls $dir; julia --startup-file=no -e '@show pwd()' > julia-test.out"`; wait=false)
	else
		proc = run(`sh -c "ls $dir"`; wait=false)
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

$(DocumentFunction.documentfunction(checknodedir;
argtext=Dict("node"=>"computational node name (e.g. `madsmax.lanl.gov`, `wf03`, or `127.0.0.1`)",
            "dir"=>"directory",
            "waittime"=>"wait time in seconds [default=`10`]")))

Returns:

- `true` if the directory is readable, `false` otherwise
""" checknodedir

function runcmd(cmd::Cmd; quiet::Bool=Mads.quiet, pipe::Bool=false, waittime::Float64=executionwaittime)
	if pipe
		cmdin = Pipe()
		cmdout = Pipe()
		cmderr = Pipe()
		cmdproc = run(cmd, (cmdin, cmdout, cmderr); wait=false)
	else
		if quiet
			cmdproc = run(pipeline(cmd, stdout=devnull, stderr=devnull); wait=false)
		else
			cmdproc = run(cmd; wait=false)
		end
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
		if !quiet && cmdproc.exitcode != 0
			erroutput = readlines(cmderr)
			if length(erroutput) > 0
				for i in erroutput
					Mads.madswarn("$(strip(i))")
				end
			end
		end
		if !quiet && cmdproc.exitcode != 0
			output = readlines(cmdout)
			l = length(output)
			if l > 0
				s = (l < 100) ? 1 : l - 100
				for i in output[s:end]
					println("$(strip(i))")
					if occursin(r"error"i, i)
						madswarn("$(strip(i))")
					end
				end
			end
		end
	end
	if !quiet && cmdproc.exitcode != 0
		Mads.madswarn("Execution of command `$(string(cmd))` produced an error ($(cmdproc.exitcode))!")
	end
	if pipe
		return cmdproc, cmdout, cmderr
	else
		return nothing
	end
end
function runcmd(cmdstring::String; quiet::Bool=Mads.quiet, pipe::Bool=false, waittime::Float64=executionwaittime)
	if Sys.iswindows()
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

$(DocumentFunction.documentfunction(runcmd;
argtext=Dict("cmd"=>"command (as a julia command; e.g. \\`ls\\`)",
            "cmdstring"=>"command (as a string; e.g. \"ls\")"),
keytext=Dict("quiet"=>"[default=`Mads.quiet`]",
            "pipe"=>"[default=`false`]",
            "waittime"=>"wait time is second [default=`Mads.executionwaittime`]")))

Returns:

- command output
- command error message
""" runcmd
