"Set the number of processors to `np` and the number of threads to `nt`"
function setprocs(np, nt)
	n = np - nprocs()
	if n > 0
		addprocs(n)
	elseif n < 0
		rmprocs(workers()[end+n+1:end])
	end
	blas_set_num_threads(nt)
	sleep(1)
	madsoutput("Number of processors is $(nprocs()) $(workers())\n")
end

"Set the number of processors to `np`"
function setprocs(np)
	setprocs(np, np)
end

sprintf(args...) = eval(:@sprintf($(args...)))

"Set the available processors based on environmental variables"
function setprocs(;ntasks_per_node=0)
	# s = "hmem[05-07,09-17]"
	# s = "hh[45]"
	# scontrol show hostname hmem[05-07,09-17] | paste -d, -s
	if haskey(ENV, "SLURM_NODELIST")
		s = ENV["SLURM_NODELIST"]
		if ntasks_per_node > 0
			c = ntasks_per_node
		else
			if haskey(ENV, "SLURM_NTASKS_PER_NODE")
				c = parse(Int, ENV["SLURM_NTASKS_PER_NODE"])
			else
				c = 1
			end
		end
		ss = split(s, "[")
		name = ss[1]
		h = Array(ASCIIString, 0)
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
		# return(h)
		addprocs(h)
		madsoutput("Number of processors is $(nprocs()) $(workers())\n")
	end
end