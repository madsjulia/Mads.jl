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
	setnprocs(np, np)
end

sprintf(args...) = eval(:@sprintf($(args...)))

"Set the available processors based on environmental variables"
function setprocs()
	if haskey(ENV, "SLURM_NODELIST")
		s = ENV["SLURM_NODELIST"]
		c = parse(Int, ENV["SLURM_NTASKS_PER_NODE"])
		ss = split(s, "[")
		d = split(split(ss[2], "]")[1], "-")
		l = length(d[1])
		f = "%0" * string(l) * "d"
		n = collect(parse(Int, d[1]):1:parse(Int, d[2]))
		h = Array(ASCIIString, 0)
		for i in n
			for j = 1:c
				push!(h, ss[1] * sprintf(f, i))
			end
		end
		addprocs(h)
	end
end