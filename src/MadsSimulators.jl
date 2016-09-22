"""
Execute amanzi
"""
function amanzi(filename::AbstractString, nproc::Int=nprocs_per_task, quiet::Bool=true, observation_filename::AbstractString="observations.out", setup::AbstractString="source-amanzi-setup"; amanzi_exe::AbstractString="")
	if quiet
		quiet_string = "&> /dev/null"
	else
		quiet_string = ""
	end
	if amanzi_exe == ""
		if nproc > 1
			runcmd(`bash -l -c "source $setup; rm -f $observation_filename; mpirun -n $nproc $$AMANZI_EXE --xml_file=$filename $quiet_string"`)
		else
			runcmd(`bash -l -c "source $setup; rm -f $observation_filename; $$AMANZI_EXE --xml_file=$filename $quiet_string"`)
		end
	else
		if nproc > 1
			runcmd(`bash -l -c "source $setup; rm -f $observation_filename; mpirun -n $nproc $amanzi_exe --xml_file=$filename $quiet_string"`)
		else
			runcmd(`bash -l -c "source $setup; rm -f $observation_filename; $amanzi_exe --xml_file=$filename $quiet_string"`)
		end
	end
end
