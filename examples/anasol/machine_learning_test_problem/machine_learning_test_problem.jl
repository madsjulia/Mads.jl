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

source_species_concentrations = Dict(1 => [1, 0, 0, 1], 2 => [0, 1, 0, 1], 3 => [0, 0, 1, 1])

for i = sources
	mdc = deepcopy(md)
	Mads.removesources!(mdc, setdiff(sources, [i]))
	mc = Mads.forwardgrid(mdc)
	mc = mc ./ max_value
	# NMFk.plotmatrix(mc[:,:,1,:])
	JLD2.save(joinpath(workdir, "forward_run_source_$(i).jld2"), "mc", mc)
end

for i = sources
	mc = JLD2.load(joinpath(workdir, "forward_run_source_$(i).jld2"), "mc")
	species_concentrations = source_species_concentrations[i]
	for (j, species) in enumerate(source_species)
		@info "Processing source $(i) species $(species) with concentration $(species_concentrations[j])"
		mcc = mc * species_concentrations[j]
		JLD2.save(joinpath(workdir, "forward_run_source_$(i)_species_$(species).jld2"), "mc", mcc)
	end
end

for i in source_species
	data = zeros(Float64, size(m))
	for j in sources
		filename = joinpath(workdir, "forward_run_source_$(j)_species_$(i).jld2")
		mc = JLD2.load(filename, "mc")
		@info "Adding source $(j) species $(i) to data max value $(maximum(mc))"
		data += mc
	end
	JLD2.save(joinpath(workdir, "forward_run_species_$(i).jld2"), "data", data)
end

data_tensor = zeros(Float64, 256, 256, 10, 4)
for (i, species) in enumerate(source_species)
	filename = joinpath(workdir, "forward_run_species_$(species).jld2")
	data = JLD2.load(filename, "data")
	data_tensor[:, :, :, i] .= data[:, :, 1, 2:11]
end

for (i, species) in enumerate(source_species)
	@info "Data species $(species) max value $(maximum(data_tensor[:,:,:,i]))"
	NMFk.plotmatrix(data_tensor[:,:,:,i])
end

data_tensor_small = zeros(Float64, 8, 8, 10, 4)
for (i, species) in enumerate(source_species)
	data_tensor_small[:, :, :, i] .= reshape(data_tensor[collect(1:16:128) .+ 7, collect(1:16:128) .+ 7, :, i], 8, 8, 10, 1)
end

data_tensor_diag = zeros(Float64, 128, 10, 4)
for (i, species) in enumerate(source_species)
	data_tensor_diag[:, :, i] .= reshape(hcat([LinearAlgebra.diag(data_tensor[1:128, 1:128, t, i]) for t in 1:10]...), 128, 10, 1)
end

X = reshape(data_tensor_small, 8 * 8 * 10, 4)
Xn, xmin, xmax, xlog = NMFk.normalizematrix(X, 2)
W, H, fit, robustness, aic = NMFk.execute(Xn, 2:4, 64; load=false, resultdir=joinpath("NMFk_Results_$(size(X,1))_$(size(X,2))"))

X = reshape(data_tensor_diag, 128 * 10, 4)
Xn, xmin, xmax, xlog = NMFk.normalizematrix(X, 2)
W, H, fit, robustness, aic = NMFk.execute(Xn, 2:4, 64; load=false, resultdir=joinpath("NMFk_Results_$(size(X,1))_$(size(X,2))"))

X = reshape(data_tensor_diag[:,10,:], 128, 4)
Xn, xmin, xmax, xlog = NMFk.normalizematrix(X, 2)
W, H, fit, robustness, aic = NMFk.execute(Xn, 2:4, 64; load=false, resultdir=joinpath("NMFk_Results_$(size(X,1))_$(size(X,2))"))