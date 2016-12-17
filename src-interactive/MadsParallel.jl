madsservers = ["madsmax", "madsmen", "madsdam", "madszem", "madskil", "madsart", "madsend"]

"Get the number of processors"
function getprocs()
	info("Number of processors: $(nprocs()) $(workers())\n")
end

"""
Set the number of processors to `np` and the number of threads to `nt`

Usage:
```
Mads.setprocs(4)
Mads.setprocs(4, 8)
```

Arguments:

- `np` : number of processors
- `nt` : number of threads
"""
function setprocs(np::Int, nt::Int)
	np = np < 1 ? 1 : np
	nt = nt < 1 ? 1 : nt
	n = np - nprocs()
	if n > 0
		addprocs(n)
	elseif n < 0
		rmprocs(workers()[end+n+1:end])
	end
	if VERSION < v"0.5"
		blas_set_num_threads(nt)
	else
		BLAS.set_num_threads(nt)
	end
	sleep(0.1)
	getprocs()
end

function setprocs(np::Int)
	setprocs(np, np)
end

"Set number of processors needed for each parallel task at each node"
function set_nprocs_per_task(local_nprocs_per_task::Int=1)
	global nprocs_per_task = local_nprocs_per_task
end

if !isdefined(:sprintf)
"Convert `@sprintf` macro into `sprintf` function"
sprintf(args...) = eval(:@sprintf($(args...)))
end

"""
Set the available processors based on environmental variables. Supports SLURM only at the moment.

Usage:

```
Mads.setprocs()
Mads.setprocs(ntasks_per_node=4)
Mads.setprocs(ntasks_per_node=32, mads_servers=true)
Mads.setprocs(ntasks_per_node=64, nodenames=["madsmax", "madszem"])
Mads.setprocs(ntasks_per_node=64, nodenames="wc[096-157,160,175]")
Mads.setprocs(ntasks_per_node=64, mads_servers=true, exename="/home/monty/bin/julia", dir="/home/monty")
```

Optional arguments:

- `ntasks_per_node` : number of parallel tasks per 
- `nprocs_per_task` : number of processors needed for each parallel task at each node
- `nodenames` : array with names of machines/nodes to be invoked
- `dir` : common directory shared by all the jobs
- `exename` : location of the julia executable (the same version of julia is needed on all the workers)
- `mads_servers` : if `true` use MADS servers (LANL only)
- `quiet` : suppress output [default `true`]
- `test` : test the servers and connect to each one ones at a time [default `false`]
"""
function setprocs(; ntasks_per_node::Int=0, nprocs_per_task::Int=1, nodenames::Union{String,Array{ASCIIString,1}}=Array(ASCIIString, 0), mads_servers::Bool=false, test::Bool=false, quiet::Bool=true, dir="", exename="")
	set_nprocs_per_task(nprocs_per_task)
	h = Array(String, 0)
	if length(nodenames) > 0 || mads_servers
		if length(nodenames) == 0
			nodenames = madsservers
		end
		c = ntasks_per_node > 0 ? ntasks_per_node : 1
		if typeof(nodenames) == Array{String,1}
			for n = 1:length(nodenames)
				for j = 1:c
					push!(h, nodenames[n])
				end
			end
		else
			h = parsenodenames(nodenames, c)
		end
	elseif haskey(ENV, "SLURM_JOB_NODELIST") || haskey(ENV, "SLURM_NODELIST")
		# s = "hmem[05-07,09-17]"
		# s = "hh[45]"
		# scontrol show hostname hmem[05-07,09-17] | paste -d, -s
		# scontrol show hostname $SLURM_JOB_NODELIST | paste -d, -s
		if haskey(ENV, "SLURM_JOB_NODELIST")
			s = ENV["SLURM_JOB_NODELIST"]
		else
			s = ENV["SLURM_NODELIST"]
		end
		if ntasks_per_node > 0
			c = ntasks_per_node
		else
			if haskey(ENV, "SLURM_NTASKS_PER_NODE")
				c = parse(Int, ENV["SLURM_NTASKS_PER_NODE"])
			elseif haskey(ENV, "SLURM_TASKS_PER_NODE")
				c = parse(Int, split(ENV["SLURM_TASKS_PER_NODE"], "(")[1])
			else
				c = 1
			end
		end
		h = parsenodenames(s, c)
	else
		warn("Unknown parallel environment!")
	end
	if length(h) > 0
		if nprocs() > 1
			rmprocs(workers())
		end
		sleep(0.1)
		arguments = Dict()
		if exename != ""
			arguments[:exename] = exename
		end
		if dir != ""
			arguments[:dir] = dir
		end
		if test
			for i = 1:length(h)
				info("Connecting to $(h[i])")
				try
					addprocs([h[i]]; arguments...)
				catch
					warn("Connection to $(h[i]) failed!")
				end
			end
		else
			if quiet
				originalSTDOUT = STDOUT;
				originalSTDERR = STDERR;
				(outRead, outWrite) = redirect_stdout();
				(errRead, errWrite) = redirect_stderr();
				outreader = @async readstring(outRead);
				errreader = @async readstring(errRead);
			end
			addprocs(h; arguments...)
			if quiet
				redirect_stdout(originalSTDOUT);
				redirect_stderr(originalSTDERR);
				close(outWrite);
				output = wait(outreader);
				close(outRead);
				close(errWrite);
				error = wait(errreader);
				close(errRead);
			end
		end
		sleep(0.1)
		if nprocs() > 1
			info("Number of processors: $(nprocs())")
			info("Workers: $(join(h, " "))")
		else
			warn("No workers found to add!")
			info("Number of processors: $(nprocs())")
		end
	else
		warn("No processors found to add!")
	end
	return h
end

"Parse string with node names defined in SLURM"
function parsenodenames(nodenames::String, ntasks_per_node::Int=1)
	h = Array(String, 0)
	ss = split(nodenames, "[")
	name = ss[1]
	if length(ss) == 1
		for j = 1:ntasks_per_node
			push!(h, name)
		end
	else
		cm = split( split(ss[2], "]")[1], ",")
		for n = 1:length(cm)
			d = split(cm[n], "-")
			e = length(d) == 1 ? d[1] : d[2]
			l = length(d[1])
			f = "%0" * string(l) * "d"
			for i in collect(parse(Int, d[1]):1:parse(Int, e))
				nn = name * sprintf(f, i)
				for j = 1:ntasks_per_node
					push!(h, nn)
				end
			end
		end
	end
	return h
end

"Disable MADS plotting"
function noplot()
	if myid() == 1
		for i in workers()
			@spawnat i ENV["MADS_NO_PLOT"]=""
			@spawnat i ENV["MADS_NO_PYPLOT"]=""
			@spawnat i ENV["MADS_NO_GADFLY"]=""
		end
	end
end

"""
Set the working directory (for parallel environments)

```
@everywhere Mads.setdir()
@everywhere Mads.setdir("/home/monty")
```
"""
function setdir(dir)
	if isdir(dir)
		cd(dir)
	end
end
function setdir()
	dir = remotecall_fetch(()->pwd(), 1)
	setdir(dir)
end

"""
Run remote command on a series of servers
"""
function runremote(cmd::String, nodenames::Array{ASCIIString,1}=madsservers)
	output = Array(String, 0)
	for i in nodenames
		try
			o = readstring(`ssh -t $i $cmd`)
			push!(output, strip(o))
			println("$i: $o")
		catch
			push!(output, "")
			warn("$i is not accessible")
		end
	end
	return output;
end

"""
Check the number of processors on a series of servers
"""
function madscores(nodenames::Array{ASCIIString,1}=madsservers)
	runremote("grep -c ^processor /proc/cpuinfo", nodenames)
end

"""
Check the uptime of a series of servers
"""
function madsup(nodenames::Array{ASCIIString,1}=madsservers)
	runremote("uptime 2>/dev/null", nodenames)
end

"""
Check the load of a series of servers
"""
function madsload(nodenames::Array{ASCIIString,1}=madsservers)
	runremote("top -n 1 2>/dev/null", nodenames)
end

"""
Run external command and pipe stdout and stderr
"""
function runcmd(cmd::Cmd, quiet::Bool=false)
	cmdin = Pipe()
	cmdout = Pipe()
	cmderr = Pipe()
	cmdproc = spawn(cmd, (cmdin, cmdout, cmderr))
	wait(cmdproc)
	# @show cmdproc.exitcode
	# @show cmdproc.termsignal
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
	if cmdproc.exitcode != 0
		error("Execution of command `$(string(cmd))` produced an error!")
	end
	return cmdout, cmderr
end