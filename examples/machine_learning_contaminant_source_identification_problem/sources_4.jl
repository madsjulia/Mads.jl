import Mads
import NMFk
import JLD2

workdir = @__DIR__
# Load MADS file and generate forward model
md = Mads.loadmadsfile(joinpath(workdir, "sources_4.mads"))
# Generate forward model predictions
m = Mads.forwardgrid(md)
# Normalizing factor
max_value = NMFk.maximumnan(m)
# Normalize forward model predictions
m = m ./ max_value
# Plot normalized forward model predictions
NMFk.plotmatrix(m[:,:,1,:]; permute=true)

# Define sources
sources = 1:4

# Run forward model for each source individually
for i = sources
	mdc = deepcopy(md)
	Mads.removesources!(mdc, setdiff(sources, [i]))
	mc = Mads.forwardgrid(mdc)
	@info "Max value for source $(i): $(maximum(mc))"
	mc = mc ./ max_value
	NMFk.plotmatrix(mc[:,:,1,:]; permute=true)
	JLD2.save(joinpath(workdir, "sources_4", "source_$(i).jld2"), "mc", mc)
end

# Define species and their concentrations for each source
species = ["A", "B", "C", "D", "E"]
source_species_concentrations = Dict(1 => [1, 2, 3, 4, 5], 2 => [5, 1, 3, 1, 2], 3 => [3, 5, 5, 4, 1], 4 => [2, 3, 4, 5, 1])
# source_species_concentrations = Dict(1 => [1, 0, 0, 0, 1], 2 => [0, 1, 0, 0, 1], 3 => [0, 0, 1, 0, 1], 4 => [0, 0, 0, 1, 1])

# Compute forward model predictions for each species from each source
for i = sources
	mc = JLD2.load(joinpath(workdir, "sources_4", "source_$(i).jld2"), "mc")
	species_concentrations = source_species_concentrations[i]
	for (j, s) in enumerate(species)
		@info "Processing source $(i) species $(s) with concentration $(species_concentrations[j])"
		mcc = mc * species_concentrations[j]
		JLD2.save(joinpath(workdir, "sources_4", "source_$(i)_species_$(s).jld2"), "mc", mcc)
		@info "Max value for source $(i) species $(s): $(maximum(mcc))"
	end
end

# Sum contributions from all sources for each species
for s in species
	data = zeros(Float64, size(m))
	for j in sources
		filename = joinpath(workdir, "sources_4", "source_$(j)_species_$(s).jld2")
		mc = JLD2.load(filename, "mc")
		@info "Adding source $(j) species $(s) to data max value $(maximum(mc))"
		data += mc
	end
	@info "Final data for species $(s) max value $(maximum(data))"
	JLD2.save(joinpath(workdir, "sources_4", "species_$(s).jld2"), "data", data)
end

# Load data for all species into a tensor
data_tensor = zeros(Float64, size(m, 1), size(m, 2), size(m, 4) - 1, length(species))
data_tensor .= NaN
for (i, s) in enumerate(species)
	filename = joinpath(workdir, "sources_4", "species_$(s).jld2")
	data = JLD2.load(filename, "data")
	@info "Loading data for species $(s) with max value $(maximum(data))"
	data_tensor[:, :, :, i] .= data[:, :, 1, 2:6] # skip first time frame (no contamination)
end
@assert all(.!isnan.(data_tensor))
@assert all(data_tensor .>= 0.0)

# Plot data for each species
for (i, s) in enumerate(species)
	@info "Data species $(s) max value $(maximum(data_tensor[:,:,:,i]))"
	NMFk.plotmatrix(data_tensor[:,:,:,i]; permute=true)
end

# Create smaller data tensors for testing within the entire domain
nx = 8
ny = 5
grid_x = NMFk.uniform_points(nx, size(data_tensor, 1))
grid_y = NMFk.uniform_points(ny, size(data_tensor, 2))
data_tensor_small = zeros(Float64, nx, ny, size(data_tensor, 3), length(species))
for i in eachindex(species)
	data_tensor_small[:, :, :, i] .= reshape(data_tensor[grid_x, grid_y, :, i], nx, ny, size(data_tensor, 3), 1)
end
@assert all(.!isnan.(data_tensor_small))
@assert all(data_tensor_small .>= 0.0)
for (i, s) in enumerate(species)
	@info "Data species $(s) max value $(maximum(data_tensor_small[:,:,:,i]))"
	NMFk.plotmatrix(data_tensor_small[:,:,:,i]; permute=true)
end

# Plot data for each species with purple dots indicating sampled locations
dots = hcat(repeat(grid_x, inner=(ny,)), repeat(grid_y, outer=(nx,)))
for (i, s) in enumerate(species)
	@info "Data species $(s) max value $(maximum(data_tensor[:,:,:,i]))"
	NMFk.plotmatrix(data_tensor[:,:,:,i]; permute=true, dots=dots)
end

# Reshape smaller data tensor into 2D matrix, normalize it and execute NMFk analysis
X = reshape(data_tensor_small, size(data_tensor_small, 1) * size(data_tensor_small, 2) * size(data_tensor_small, 3), size(data_tensor_small, 4))
Xn, xmin, xmax, xlog = NMFk.normalizematrix(X, 2)
W, H, fit, robustness, aic = NMFk.execute(Xn, 2:5, 64; load=false, save=false)

# Create diagonal data tensor downgradient from the source location areas
# As expected, this smaller domain makes the problem more challenging and leads to incorrect source identification
nx = 5
ny = 5
data_tensor_small = zeros(Float64, nx, ny, size(data_tensor, 3), length(species))
for i in eachindex(species)
	data_tensor_small[:, :, :, i] .= reshape(data_tensor[NMFk.uniform_points(nx, size(data_tensor, 1), 41), NMFk.uniform_points(ny, size(data_tensor, 2)), :, i], nx, ny, size(data_tensor, 3), 1)
end
@assert all(.!isnan.(data_tensor_small))
@assert all(data_tensor_small .>= 0.0)
# Plot data for each species
for (i, s) in enumerate(species)
	@info "Data species $(s) max value $(maximum(data_tensor_small[:,:,:,i]))"
	NMFk.plotmatrix(data_tensor_small[:,:,:,i]; permute=true)
end
# Plot data for each species with purple dots indicating sampled locations
dots = hcat(
	repeat(NMFk.uniform_points(nx, size(data_tensor, 1), 41), inner=(ny,)),
	repeat(NMFk.uniform_points(ny, size(data_tensor, 2)), outer=(nx,))
)
for (i, s) in enumerate(species)
	@info "Data species $(s) max value $(maximum(data_tensor[:,:,:,i]))"
	NMFk.plotmatrix(data_tensor[:,:,:,i]; permute=true, dots=dots)
end

# Reshape smaller data tensor into 2D matrix, normalize it and execute NMFk analysis
X = reshape(data_tensor_small, size(data_tensor_small, 1) * size(data_tensor_small, 2) * size(data_tensor_small, 3), size(data_tensor_small, 4))
Xn, xmin, xmax, xlog = NMFk.normalizematrix(X, 2)
W, H, fit, robustness, aic = NMFk.execute(Xn, 2:5, 64; load=false, save=false)

# Create a random data sample of locations within the entire domain
np = 40
p = NMFk.latin_hypercube_points(np, [size(data_tensor, 1), size(data_tensor, 2)], [1, 1])
data_tensor_lhs = zeros(Float64, np, size(data_tensor, 3), length(species))
data_tensor_lhs .= NaN
for i in eachindex(species)
	for j in 1:np
		data_tensor_lhs[j, :, i] .= reshape(data_tensor[p[j,1], p[j,2], :, i], size(data_tensor, 3), 1)
	end
end
@assert all(.!isnan.(data_tensor_lhs))
@assert all(data_tensor_lhs .>= 0.0)
# Plot data for each species with purple dots indicating sampled locations
for (i, s) in enumerate(species)
	@info "Data species $(s) max value $(maximum(data_tensor[:,:,:,i]))"
	NMFk.plotmatrix(data_tensor[:,:,:,i]; permute=true, dots=p)
end

# Reshape smaller data tensor into 2D matrix, normalize it and execute NMFk analysis
X = reshape(data_tensor_lhs, size(data_tensor_lhs, 1) * size(data_tensor_lhs, 2), size(data_tensor_lhs, 3))
Xn, xmin, xmax, xlog = NMFk.normalizematrix(X, 2)
W, H, fit, robustness, aic = NMFk.execute(Xn, 2:5, 64; load=false, save=false)

# Execute Mads inversion analyses
# First, execute mads using source separation on; concentrations from each source are used as separate targets
# In this case, we have more calibration targets which someone expect to the problem easier
# However, this also caused issues because of zeros in Jacobian matrix from sources not contributing to the observations to other sources
# So at the end, the perform is worst than source separation off case below because of numerical issues in the optimization
md = Mads.loadmadsfile(joinpath(workdir, "sources_4.mads")) # Load MADS file defining the source parameters
Mads.separate_sources_on() # turn on source separation
np = 20 # number of wells
p = NMFk.latin_hypercube_points(np, [50.0, 25.0], [-30.0, -25.0]) # well locations
times = 1.1:0.1:1.5 # sampling times
nt = length(times) # number of sampling times
Mads.createwells!(md, p, rand(np, nt), times) # create wells with random observed concentrations
f = Mads.forward(md) # generate forward model for mads targets
Mads.createproblem!(md, f) # set forward estimates as mads observations to calibrate against
Mads.showparameters(md) # show parameters to calibrate
calibration_param, calibration_obs = Mads.calibraterandom(md, 10; first_init=false) # calibrate using Levenberg-Marquardt
Mads.showparameters(md, calibration_param) # show calibrated parameters

# Execute mads using source separation off; concentrations from each source each are mixed
# Load MADS file and generate forward model
md = Mads.loadmadsfile(joinpath(workdir, "sources_4.mads"))  # Load MADS file defining the source parameters
Mads.separate_sources_off() # turn off source separation
np = 20 # number of wells
p = NMFk.latin_hypercube_points(np, [50.0, 25.0], [-30.0, -25.0]) # well locations
times = 1.1:0.1:1.5 # sampling times
nt = length(times) # number of sampling times
Mads.createwells!(md, p, rand(np, nt), times) # create wells with random observed concentrations
f = Mads.forward(md) # generate forward model for mads targets
Mads.createproblem!(md, f) # set forward estimates as mads observations to calibrate against
Mads.showparameters(md) # show parameters to calibrate
calibration_param, calibration_obs = Mads.calibraterandom(md, 10; first_init=false) # calibrate using Levenberg-Marquardt
Mads.showparameters(md, calibration_param) # show calibrated parameters

# Execute MCMC sampling to estimate parameter uncertainties
chain, llhoods = Mads.emceesampling(md; numwalkers=32, nexecutions=10000)
Mads.scatterplotsamples(md, chain', joinpath(workdir, "sources4_figures", "emcee_scatter_$(np)_$(size(chain, 1))_$(size(chain, 2)).png")) # Generate scatter plots of MCMC samples
o = Mads.forward(md, chain') # Generate forward model predictions for MCMC samples
Mads.spaghettiplot(md, o; format="PNG", separate_files=true, filename=joinpath(workdir, "sources4_figures", "emcee_spaghetti_$(np)_$(size(chain, 1))_$(size(chain, 2))")) # Generate spaghetti plots of MCMC forward model predictions

# Execute mads using source separation off; concentrations from each source each are mixed
# Load MADS file and generate forward model
md = Mads.loadmadsfile(joinpath(workdir, "sources_4.mads"))  # Load MADS file defining the source parameters
Mads.separate_sources_off() # turn off source separation
np = 5 # number of wells
p = NMFk.latin_hypercube_points(np, [50.0, 25.0], [-30.0, -25.0]) # well locations
times = 1.1:0.1:1.5 # sampling times
nt = length(times) # number of sampling times
Mads.createwells!(md, p, rand(np, nt), times) # create wells with random observed concentrations
f = Mads.forward(md) # generate forward model for mads targets
Mads.createproblem!(md, f) # set forward estimates as mads observations to calibrate against
Mads.showparameters(md) # show parameters to calibrate
calibration_param, calibration_obs = Mads.calibraterandom(md, 10; first_init=false) # calibrate using Levenberg-Marquardt
Mads.showparameters(md, calibration_param) # show calibrated parameters

# Execute MCMC sampling to estimate parameter uncertainties
chain, llhoods = Mads.emceesampling(md; numwalkers=32, nexecutions=10000)
Mads.scatterplotsamples(md, chain', joinpath(workdir, "sources_4_figures", "emcee_scatter_$(np)_$(size(chain, 1))_$(size(chain, 2)).png")) # Generate scatter plots of MCMC samples
o = Mads.forward(md, chain') # Generate forward model predictions for MCMC samples
Mads.spaghettiplot(md, o; format="PNG", separate_files=true, filename=joinpath(workdir, "sources_4_figures", "emcee_spaghetti_$(np)_$(size(chain, 1))_$(size(chain, 2))")) # Generate spaghetti plots of MCMC forward model predictions
