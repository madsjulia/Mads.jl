import IJulia

function notebook(problem::AbstractString; notebook::Bool=false)
	@info("Mads notebook: $problem")
	if notebook
		IJulia.notebook(; dir=joinpath(Mads.dir, "notebooks", problem), detached=true)
	else
		cd(joinpath(Mads.dir, "notebooks", problem))
		include("$(problem).jl")
	end
end

function notebooks()
	notebook("."; notebook=true)
end
