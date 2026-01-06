import Mads
import NMFk
import JLD2
import LinearAlgebra

workdir = @__DIR__
# Load MADS file and generate forward model
md = Mads.loadmadsfile(joinpath(workdir, "sources_3.mads"))
# Generate forward model predictions
m = Mads.forwardgrid(md)
# Normalizing factor
max_value = NMFk.maximumnan(m)
# Normalize forward model predictions
m = m ./ max_value
# Plot normalized forward model predictions
NMFk.plotmatrix(m[:,:,1,:]; yflip=false)

# Define sources and species concentrations
sources = 1:3
# Define species and their concentrations for each source
species = ["A", "B", "C", "D"]
source_species_concentrations = Dict(1 => [1, 2, 3, 4], 2 => [5, 1, 3, 1], 3 => [3, 5, 5, 4])
# source_species_concentrations = Dict(1 => [1, 0, 0, 1], 2 => [0, 1, 0, 1], 3 => [0, 0, 1, 1])

# Run forward model for each source individually
for i = sources
	mdc = deepcopy(md)
	Mads.removesources!(mdc, setdiff(sources, [i]))
	mc = Mads.forwardgrid(mdc)
	mc = mc ./ max_value
	# NMFk.plotmatrix(mc[:,:,1,:])
	JLD2.save(joinpath(workdir, "sources_3", "forward_run_source_$(i).jld2"), "mc", mc)
end

# Compute forward model predictions for each species from each source
for i = sources
	mc = JLD2.load(joinpath(workdir, "sources_3", "forward_run_source_$(i).jld2"), "mc")
	species_concentrations = source_species_concentrations[i]
	for (j, s) in enumerate(species)
		@info "Processing source $(i) species $(s) with concentration $(species_concentrations[j])"
		mcc = mc * species_concentrations[j]
		JLD2.save(joinpath(workdir, "sources_3", "forward_run_source_$(i)_species_$(s).jld2"), "mc", mcc)
		@info "Max value for source $(i) species $(s): $(maximum(mcc))"
	end
end

# Sum contributions from all sources for each species
for s in species
	data = zeros(Float64, size(m))
	for j in sources
		filename = joinpath(workdir, "sources_3", "forward_run_source_$(j)_species_$(s).jld2")
		mc = JLD2.load(filename, "mc")
		@info "Adding source $(j) species $(s) to data max value $(maximum(mc))"
		data += mc
	end
	@info "Final data for species $(s) max value $(maximum(data))"
	JLD2.save(joinpath(workdir, "sources_3", "forward_run_species_$(s).jld2"), "data", data)
end

# Load data for all species into a tensor
data_tensor = zeros(Float64, 256, 256, 10, 4)
for (i, s) in enumerate(species)
	filename = joinpath(workdir, "sources_3", "forward_run_species_$(s).jld2")
	data = JLD2.load(filename, "data")
	@info "Loading data for species $(s) with max value $(maximum(data))"
	data_tensor[:, :, :, i] .= data[:, :, 1, 2:11]
end

# Plot data for each species
for (i, s) in enumerate(species)
	@info "Data species $(s) max value $(maximum(data_tensor[:,:,:,i]))"
	NMFk.plotmatrix(data_tensor[:,:,:,i]; yflip=false)
end

# Analyses focused on the source location areas
# As expected they perform very well since the signals are much stronger
# Create smaller data tensors for testing focused on the source location areas
data_tensor_small = zeros(Float64, 8, 8, 10, 4)
for i in eachindex(species)
	data_tensor_small[:, :, :, i] .= reshape(data_tensor[collect(1:16:128) .+ 7, collect(1:16:128) .+ 7, :, i], 8, 8, 10, 1)
end
# Reshape smaller data tensor into 2D matrix for NMFk analysis; execute NMFk
X = reshape(data_tensor_small, 8 * 8 * 10, 4)
Xn, xmin, xmax, xlog = NMFk.normalizematrix(X, 2)
W, H, fit, robustness, aic = NMFk.execute(Xn, 2:4, 64; save=false)

# Create diagonal data tensor for testing focused on the source location areas
data_tensor_diag = zeros(Float64, 128, 10, 4)
for i in eachindex(species)
	data_tensor_diag[:, :, i] .= reshape(hcat([LinearAlgebra.diag(data_tensor[1:128, 1:128, t, i]) for t in 1:10]...), 128, 10, 1)
end
# Reshape diagonal data tensor into 2D matrix for NMFk analysis; execute NMFk
X = reshape(data_tensor_diag, 128 * 10, 4)
Xn, xmin, xmax, xlog = NMFk.normalizematrix(X, 2)
W, H, fit, robustness, aic = NMFk.execute(Xn, 2:4, 64; save=false)
# Reshape diagonal data tensor into 2D matrix for NMFk analysis; use only last time frame; execute NMFk
X = reshape(data_tensor_diag[:,10,:], 128, 4)
Xn, xmin, xmax, xlog = NMFk.normalizematrix(X, 2)
W, H, fit, robustness, aic = NMFk.execute(Xn, 2:4, 64; save=false)

# Analyses focused on the area downgradient from sources
# As expected they do not perform as well since the signals are much weaker
# Create smaller data tensors for testing focused on the area downgradient from sources
data_tensor_small = zeros(Float64, 8, 8, 10, 4)
for i in eachindex(species)
	data_tensor_small[:, :, :, i] .= reshape(data_tensor[collect(1:16:128) .+ 127, collect(1:16:128) .+ 127, :, i], 8, 8, 10, 1)
end
# Reshape smaller data tensor into 2D matrix for NMFk analysis; execute NMFk
X = reshape(data_tensor_small, 8 * 8 * 10, 4)
Xn, xmin, xmax, xlog = NMFk.normalizematrix(X, 2)
W, H, fit, robustness, aic = NMFk.execute(Xn, 2:4, 64; save=false)

# Create diagonal data tensor for testing focused on the area downgradient from sources
data_tensor_diag = zeros(Float64, 128, 10, 4)
for i in eachindex(species)
	data_tensor_diag[:, :, i] .= reshape(hcat([LinearAlgebra.diag(data_tensor[end-127:end, end-127:end, t, i]) for t in 1:10]...), 128, 10, 1)
end
# Reshape diagonal data tensor into 2D matrix for NMFk analysis; execute NMFk
X = reshape(data_tensor_diag, 128 * 10, 4)
Xn, xmin, xmax, xlog = NMFk.normalizematrix(X, 2)
W, H, fit, robustness, aic = NMFk.execute(Xn, 2:4, 64; save=false)
# Reshape diagonal data tensor into 2D matrix for NMFk analysis; use only last time frame; execute NMFk
X = reshape(data_tensor_diag[:,10,:], 128, 4)
Xn, xmin, xmax, xlog = NMFk.normalizematrix(X, 2)
W, H, fit, robustness, aic = NMFk.execute(Xn, 2:4, 64; save=false)