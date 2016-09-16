"""
Execute amanzi
"""
function amanzi(filename::AbstractString, nproc::Int=1, quiet::Bool=true, observation_filename::AbstractString="observations.out", setup::AbstractString="source-amanzi-setup")
    if quiet
        quiet_string = "&> /dev/null"
    else
        quiet_string = ""
    end
    if nproc > 1
        run(`bash -l -c "source $setup; rm -f $observation_filename; mpirun -n $nproc $$AMANZI_EXE --xml_file=$filename $quiet_string"`)
    else
        run(`bash -l -c "source $setup; rm -f $observation_filename; $$AMANZI_EXE --xml_file=$filename $quiet_string"`)
    end
end