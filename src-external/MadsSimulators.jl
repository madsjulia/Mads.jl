import DocumentFunction

"""
Execute Amanzi external groundwater flow and transport simulator

$(DocumentFunction.documentfunction(amanzi;
argtext=Dict("filename"=>"amanzi input file name",
            "nproc"=>"number of processor to be used by amanzi [default=`nprocs_per_task`]",
            "quiet"=>"suppress output [default=`true`]",
            "observation_filename"=>"amanzi observation file name [default=`\"observations.out\"`]",
            "setup"=>"bash script to setup amanzi environmental variables [default=`\"source-amanzi-setup\"`]"),
keytext=Dict("amanzi_exe"=>"full path to the amanzi executable")))
"""
function amanzi(filename::String, nproc::Int=nprocs_per_task, quiet::Bool=true, observation_filename::String="observations.out", setup::String="source-amanzi-setup"; amanzi_exe::String="")
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
