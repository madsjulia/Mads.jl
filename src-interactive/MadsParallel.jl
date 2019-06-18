using Distributed
using LinearAlgebra
import Printf
import DocumentFunction

if isdefined(Core, :Mads) && !isdefined(Mads, :sprintf)
	"Convert `@Printf.sprintf` macro into `sprintf` function"
	sprintf(args...) = Base.eval(:@Printf.sprintf($(args...)))
end

quietdefault = true
nprocs_per_task_default = 1
madsservers = ["madsmax", "madsmen", "madszem", "madskil", "madsart", "madsend"] # madsdam is out
madsservers2 = vec(["madsmin"; map(i->(@Printf.sprintf "mads%02d" i), 1:18)])
madsserversall = vec(["madsmax"; "madsmen"; "madszem"; "madskil"; "madsart"; "madsend"; "madsmin"; map(i->(@Printf.sprintf "mads%02d" i), 1:18)]) # madsdam is out
if isdefined(Main, :Mads)
	quietdefault = Mads.quiet
	nprocs_per_task_default = Mads.nprocs_per_task_default
	madsservers = Mads.madsservers
	madsservers2 = Mads.madsservers2
end

"""
Get the number of processors

$(DocumentFunction.documentfunction(getprocs))
"""
function getprocs()
	@info("Number of processors: $(nworkers()) $(workers())\n")
end

function setprocs(np::Integer, nt::Integer)
	np = np < 1 ? 1 : np
	nt = nt < 1 ? 1 : nt
	n = np - nworkers()
	if n > 0
		Distributed.addprocs(n)
	elseif n < 0
		Distributed.rmprocs(workers()[end+n+1:end])
	end
	BLAS.set_num_threads(nt)
	sleep(0.1)
	getprocs()
end
function setprocs(np::Integer)
	setprocs(np, np)
end
function setprocs(; ntasks_per_node::Integer=0, nprocs_per_task::Integer=nprocs_per_task_default, nodenames::Union{String,Array{String,1}}=Array{String}(undef, 0), mads_servers::Bool=false, test::Bool=false, quiet::Bool=quietdefault, veryquiet::Bool=false, dir::String=pwd(), exename::String=Base.julia_cmd().exec[1])
	if isdefined(Core, :Mads) && isdefined(Mads, :set_nprocs_per_task)
		set_nprocs_per_task(nprocs_per_task)
	end
	h = Array{String}(undef, 0)
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
				c = Base.parse(Int, ENV["SLURM_NTASKS_PER_NODE"])
			elseif haskey(ENV, "SLURM_TASKS_PER_NODE")
				c = Base.parse(Int, split(ENV["SLURM_TASKS_PER_NODE"], "(")[1])
			else
				c = 1
			end
		end
		h = parsenodenames(s, c)
	else
		!veryquiet && @warn("Unknown parallel environment!")
	end
	if length(h) > 0
		if nworkers() > 1
			Distributed.rmprocs(workers())
		end
		sleep(0.1)
		arguments = Dict()
		arguments[:exename] = exename
		arguments[:dir] = dir
		if test
			for i = 1:length(h)
				@info("Connecting to $(h[i]) ...")
				try
					Distributed.addprocs([h[i]]; arguments...)
				catch errmsg
					println(strip(errmsg.msg))
					@warn("Connection to $(h[i]) failed!")
				end
			end
		else
			if quiet
				originalstdout = stdout;
				originalstderr = stderr;
				(outRead, outWrite) = redirect_stdout();
				(errRead, errWrite) = redirect_stderr();
				outreader = @async read(outRead, String);
				errreader = @async read(errRead, String);
			end
			errmsg = ""
			addprocsfailed = false
			try
				Distributed.addprocs(h; arguments...)
			catch errmsg
				try
					if in(:errmsg, fieldnames(errmsg))
						@warn(strip(errmsg.errmsg))
					else
						@warn(errmsg)
					end
				catch
					@warn(errmsg)
				end
				addprocsfailed = true
				@warn("Connection to $(h) failed!")
			end
			if quiet
				redirect_stdout(originalstdout);
				redirect_stderr(originalstderr);
				close(outWrite);
				# output = wait(outreader); # output is not needed
				close(outRead);
				close(errWrite);
				# error = wait(errreader); # error is not needed
				close(errRead);
			end
			if addprocsfailed
				@warn("Connection to $(h) failed!")
				error(errmsg)
			end
		end
		sleep(0.1)
		if Distributed.nprocs() > 1
			@info("Number of processors: $(nworkers())")
			@info("Workers: $(join(h, " "))")
		else
			@warn("No workers found to add!")
			@info("Number of processors: $(nworkers())")
		end
	else
		!veryquiet && @warn("No processors found to add!")
	end
	return h
end
@doc """
Set the available processors based on environmental variables (supports SLURM only at the moment)

$(DocumentFunction.documentfunction(setprocs;
argtext=Dict("np"=>"number of processors [default=`1`]",
            "nt"=>"number of threads[default=`1`]"),
keytext=Dict("ntasks_per_node"=>"number of parallel tasks per node [default=`0`]",
            "nprocs_per_task"=>"number of processors needed for each parallel task at each node [default=`Mads.nprocs_per_task`]",
            "nodenames"=>"array with names of machines/nodes to be invoked",
            "mads_servers"=>"if `true` use MADS servers (LANL only) [default=`false`]",
            "test"=>"test the servers and connect to each one ones at a time [default=`false`]",
            "quiet"=>"suppress output [default=`Mads.quiet`]",
            "dir"=>"common directory shared by all the jobs",
            "exename"=>"location of the julia executable (the same version of julia is needed on all the workers)")))

Returns:

- vector with names of compute nodes (hosts)

Example:

```julia
Mads.setprocs()
Mads.setprocs(4)
Mads.setprocs(4, 8)
Mads.setprocs(ntasks_per_node=4)
Mads.setprocs(ntasks_per_node=32, mads_servers=true)
Mads.setprocs(ntasks_per_node=64, nodenames=madsservers)
Mads.setprocs(ntasks_per_node=64, nodenames=["madsmax", "madszem"])
Mads.setprocs(ntasks_per_node=64, nodenames="wc[096-157,160,175]")
Mads.setprocs(ntasks_per_node=64, mads_servers=true, exename="/home/monty/bin/julia", dir="/home/monty")
```
""" setprocs

"""
Parse string with node names defined in SLURM

$(DocumentFunction.documentfunction(parsenodenames;
argtext=Dict("nodenames"=>"string with node names defined in SLURM",
            "ntasks_per_node"=>"number of parallel tasks per node [default=`1`]")))

Returns:

- vector with names of compute nodes (hosts)
"""
function parsenodenames(nodenames::String, ntasks_per_node::Integer=1)
	h = Array{String}(undef, 0)
	ss = split(nodenames, "[")
	name = ss[1]
	if length(ss) == 1
		for j = 1:ntasks_per_node
			push!(h, name)
		end
	else
		cm = split(split(ss[2], "]")[1], ",")
		for n = 1:length(cm)
			d = split(cm[n], "-")
			e = length(d) == 1 ? d[1] : d[2]
			l = length(d[1])
			f = "%0" * string(l) * "d"
			for i in collect(Base.parse(Int, d[1]):1:Base.parse(Int, e))
				nn = name * sprintf(f, i)
				for j = 1:ntasks_per_node
					push!(h, nn)
				end
			end
		end
	end
	return h
end

"""
Disable MADS plotting

$(DocumentFunction.documentfunction(noplot))
"""
function noplot()
	if myid() == 1
		for i in workers()
			@spawnat i ENV["MADS_NO_PLOT"]=""
			@spawnat i ENV["MADS_NO_PYPLOT"]=""
			@spawnat i ENV["MADS_NO_GADFLY"]=""
		end
	end
end

function setdir(dir)
	if isdir(dir)
		cd(dir)
	end
end
function setdir()
	dir = remotecall_fetch(()->pwd(), 1)
	setdir(dir)
end

@doc """
Set the working directory (for parallel environments)

$(DocumentFunction.documentfunction(setdir;
argtext=Dict("dir"=>"directory")))

Example:

```julia
@everywhere Mads.setdir()
@everywhere Mads.setdir("/home/monty")
```
""" setdir

"""
Run remote command on a series of servers

$(DocumentFunction.documentfunction(runremote;
argtext=Dict("cmd"=>"remote command",
            "nodenames"=>"names of machines/nodes [default=`madsservers`]")))

Returns:

- output of running remote command
"""
function runremote(cmd::String, nodenames::Array{String,1}=madsservers)
	output = Array{String}(undef, 0)
	for i in nodenames
		try
			o = readstring(`ssh -t $i $cmd`)
			push!(output, strip(o))
			println("$i: $o")
		catch errmsg
			println(strip(errmsg.msg))
			push!(output, "")
			@warn("$i is not accessible or command failed")
		end
	end
	return output;
end

"""
Check the number of processors on a series of servers

$(DocumentFunction.documentfunction(madscores;
argtext=Dict("nodenames"=>"array with names of machines/nodes [default=`madsservers`]")))
"""
function madscores(nodenames::Array{String,1}=madsservers)
	runremote("grep -c ^processor /proc/cpuinfo", nodenames)
end

"""
Check the uptime of a series of servers

$(DocumentFunction.documentfunction(madsup;
argtext=Dict("nodenames"=>"array with names of machines/nodes [default=`madsservers`]")))
"""
function madsup(nodenames::Array{String,1}=madsservers)
	runremote("uptime 2>/dev/null", nodenames)
end

"""
Check the load of a series of servers

$(DocumentFunction.documentfunction(madsload;
argtext=Dict("nodenames"=>"array with names of machines/nodes [default=`madsservers`]")))
"""
function madsload(nodenames::Array{String,1}=madsservers)
	runremote("top -n 1 2>/dev/null", nodenames)
end

"""
Generate a list of Mads servers

$(DocumentFunction.documentfunction(setmadsservers;
argtext=Dict("first"=>"first [default=`0`]", "last"=>"last [default=`18`]")))

Returns
- array string of mads servers
"""
function setmadsservers(first::Int=0, last::Int=18)
	map(i->(@Printf.sprintf "mads%02d" i), first:last)
end

:loaded
