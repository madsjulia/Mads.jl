import Mads
import NMFk
import JLD2
import ProgressMeter

workdir = @__DIR__
# Load MADS file and generate forward model
md = Mads.loadmadsfile(joinpath(workdir, "sources_1.mads"))
# Generate forward model predictions
m = Mads.forwardgrid(md)
# Normalizing factor
max_value = NMFk.maximumnan(m)
# Normalize forward model predictions
m = m ./ max_value
# Plot normalized forward model predictions
NMFk.plotmatrix(m[:,:,1,:]; permute=true)

# Define sources
md = Mads.loadmadsfile(joinpath(workdir, "sources_1.mads"))
sources = 3:7
nsamples = 10
Mads.addsource!(md) # Now there are 2 sources
# Run forward model for each source individually
for i = sources
	Mads.addsource!(md)
	@info("Source $i")
	p = Mads.getparamdict(md)
	for j = 1:nsamples
		rp = Mads.getparamrandom(md, nsamples)
		@info("Case $j:")
		for k in keys(rp)
			p[k] = rp[k][j]
			println("  $k = $(p[k])")
		end
		mc = Mads.forwardgrid(md, p)
		JLD2.save(joinpath(workdir, "sources_diffusion", "source_$(i)", "case_$(j).jld2"), "case", mc)
	end
end