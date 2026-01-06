import Mads
import NMFk
import JLD2

workdir = joinpath(Mads.dir, "examples", "anasol", "machine_learning_test_problem")
md = Mads.loadmadsfile(joinpath(workdir, "sources.mads"))
m = Mads.forwardgrid(md)
max_value = NMFk.maximumnan(m)
m = m ./ max_value
NMFk.plotmatrix(m[:,:,1,:])

sources = 1:3
source_species = ["A", "B", "C", "D"]
source_species_concentrations = Dict(1 => [1, 2, 3, 4], 2 => [5, 1, 3, 1], 3 => [3, 5, 5, 4])

for i = sources
	mdc = deepcopy(md)
	Mads.removesources!(mdc, setdiff(sources, [i]))
	mc = Mads.forwardgrid(mdc)
	mc = mc ./ max_value
	NMFk.plotmatrix(mc[:,:,1,:])
	species_concentrations = source_species_concentrations[i]
	for (j, species) in enumerate(source_species)
		mc *= species_concentrations[j]
		JLD2.save(joinpath(workdir, "forward_run_source_$(i)_species_$(species).jld2"), "mc", mc)
	end
end
