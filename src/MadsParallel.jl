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
function setprocs(; ntasks_per_node=0, mads_servers=false)
	# s = "hmem[05-07,09-17]"
	# s = "hh[45]"
	# scontrol show hostname hmem[05-07,09-17] | paste -d, -s
	h = Array(ASCIIString, 0)
	if mads_servers
		machinenames = ["madsmax", "madsmen", "madsdam", "madszem", "madskil", "madsart", "madsend"]
		c = ntasks_per_node > 0 ? ntasks_per_node : 1
		h = Array(ASCIIString, 0)
		for n = 1:length(machinenames)
			for j = 1:c
				push!(h, machinenames[n])
			end
		end
	elseif haskey(ENV, "SLURM_NODELIST")
		s = ENV["SLURM_NODELIST"]
		if ntasks_per_node > 0
			c = ntasks_per_node
		else
			c = haskey(ENV, "SLURM_NTASKS_PER_NODE") ? parse(Int, ENV["SLURM_NTASKS_PER_NODE"]) : 1
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
	end
	# return(h)
	if length(h) > 0
		if nprocs() > 1
			rmprocs(workers())
		end
		sleep(0.1)
		addprocs(h)
		sleep(0.1)
		info("Number of processors: $(nprocs())")
		info("Workers: $(join(h, " "))")
	else
		warn("No processors found to add!")
	end
end
