"Set number of processors `np` and threads `nt`"
function setnprocs(np, nt)
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

"Set number of processors `np`"
function setnprocs(np)
	setnprocs(np, np)
end