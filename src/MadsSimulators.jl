"""
Execute amanzi
"""
function amanzi(filename::AbstractString, nproc::Int=nprocs_per_task, quiet::Bool=true, observation_filename::AbstractString="observations.out", setup::AbstractString="source-amanzi-setup")
	if quiet
		quiet_string = "&> /dev/null"
	else
		quiet_string = ""
	end
	if nproc > 1
		runcmd(`bash -l -c "source $setup; rm -f $observation_filename; mpirun -n $nproc $$AMANZI_EXE --xml_file=$filename $quiet_string"`)
	else
		runcmd(`bash -l -c "source $setup; rm -f $observation_filename; $$AMANZI_EXE --xml_file=$filename $quiet_string"`)
	end
end