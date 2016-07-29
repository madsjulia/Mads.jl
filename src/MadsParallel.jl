"Get the number of processors"
function getprocs()
	info("Number of processors: $(nprocs()) $(workers())\n")
end

"""
Set the number of processors to `np` and the number of threads to `nt`

Usage:
```
Mads.setprocs(4, 8)
```

Arguments:

- `np` : number of processors
- `nt` : number of threads
"""
function setprocs(np::Int, nt::Int)
	np = np <= 0 ? 1 : np
	nt = nt <= 0 ? 1 : nt
	n = np - nprocs()
	if n > 0
		addprocs(n)
	elseif n < 0
		rmprocs(workers()[end+n+1:end])
	end
	blas_set_num_threads(nt)
	sleep(10)
	getprocs()
end

"""
Set the number of processors to `np`

Usage:

```
Mads.setprocs(4)
```

Arguments:

- `np` : number of processors
"""
function setprocs(np::Int)
	setprocs(np, np)
end

"Convert `@sprintf` macro into `sprintf` function"
sprintf(args...) = eval(:@sprintf($(args...)))

"""
Set the available processors based on environmental variables. Supports SLURM only at the moment.

Usage:

```
Mads.setprocs()
Mads.setprocs(ntasks_per_node=4)
Mads.setprocs(ntasks_per_node=2, mads_servers=true)
```

Optional arguments:

- `ntasks_per_node` : number of parallel tasks per node
- `mads_servers` : if true use MADS servers (LANL only)
"""
function setprocs(; ntasks_per_node::Int=0, machinenames::Array=[], mads_servers::Bool=false, test::Bool=false, hide_output::Bool=true, dir::ASCIIString="", exename::ASCIIString="")
	h = Array(ASCIIString, 0)
	if length(machinenames) > 0 || mads_servers
		if length(machinenames) == 0
			machinenames = ["madsmax", "madsmen", "madsdam", "madszem", "madskil", "madsart", "madsend"]
		end
		c = ntasks_per_node > 0 ? ntasks_per_node : 1
		for n = 1:length(machinenames)
			for j = 1:c
				push!(h, machinenames[n])
			end
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
		ss = split(s, "[")
		name = ss[1]
		if length(ss) == 1
			for j = 1:c
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
					for j = 1:c
						push!(h, nn)
					end
				end
			end
		end
	else
		warn("Unknown parallel environment!")
	end
	if length(h) > 0
		if nprocs() > 1
			rmprocs(workers())
		end
		sleep(0.1)
		if test
			for i = 1:length(h)
				info("Connecting to $(h[i])")
				try
					#addprocs([h[i]], tunnel=true, exename="/home/vvv/script/julia", dir="/home/vvv/remote")
					addprocs([h[i]])
				catch
					warn("Connection to $(h[i]) failed!")
				end
			end
		else
			if hide_output
				originalSTDOUT = STDOUT;
				originalSTDERR = STDERR;
				(outRead, outWrite) = redirect_stdout();
				(errRead, errWrite) = redirect_stderr();
			end
			addprocs(h)
			if hide_output
				close(outWrite);
				close(outRead);
				close(errWrite);
				close(errRead);
				redirect_stdout(originalSTDOUT);
				redirect_stderr(originalSTDERR);
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
end

"MADS plotting is disabled"
function noplot()
	if myid() == 1
		for i in workers()
			@spawnat i ENV["MADS_NO_PLOT"]=""
			@spawnat i ENV["MADS_NO_PYPLOT"]=""
			@spawnat i ENV["MADS_NO_GADFLY"]=""
		end
	end
end

"Set the working directory"
function setdir(dir::ASCIIString)
	if isdir(dir)
		cd(dir)
	end
end

function setdir()
	dir = remotecall_fetch(1, ()->pwd())
	cd(dir)
end