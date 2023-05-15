import Mads
import YAML
import PyCall

cd(@__DIR__)

PyCall.py"""

import sys,os
sys.path.append(os.path.join('/work','scripts'))
import TEM

dvmdostem=TEM.TEM_model('config-step1-md1.yaml')
dvmdostem.set_params(dvmdostem.cmtnum, dvmdostem.paramnames, dvmdostem.pftnums)

"""

mads_config = YAML.load_file("config-step1-md1.yaml")

function TEM_pycall(parameters::AbstractVector)
		predictions = PyCall.py"dvmdostem.run_TEM"(parameters)
		return predictions
end

initial_guess=mads_config["mads_initial_guess"]

#y_init=PyCall.py"dvmdostem.run_TEM"(initial_guess)
obs=PyCall.py"dvmdostem.get_targets"()
n_o=length(obs)
obstime=1:n_o-6             #excluding soil carbon values
targets=obs[1:n_o-6]        #grabbing only vegetation targets

# check for obsweight
obsweight=mads_config["mads_obsweight"]
if isnothing(obsweight)
	obsweight = ones(Int8, n_o-6)*100
else
	println("Make sure that weight length match with targets length")
end

# check for paramlog
n_p=length(initial_guess)
paramlog=mads_config["mads_paramlog"]

if isnothing(paramlog)
	paramlog = falses(n_p) # for small parameter values (<10-3) this needs to trues
else
	println("Make sure that paramlog length match with IC length")
end

#choose a range for parameter values
paramdist = []
mads_paramrange=mads_config["mads_paramrange"]
if mads_paramrange == "ON"
	var=mads_config["mads_param_percent_variance"]
	for i in eachindex(initial_guess)
		min_r = initial_guess[i] .- initial_guess[i] .* (var / 100)
		max_r = initial_guess[i] + initial_guess[i] .* (var / 100)
		push!(paramdist, "Uniform($(min_r), $(max_r))")
	end
else
	paramdist=mads_config["mads_paramdist"]
end


#choose a range for observation values
obsdist = []
mads_obsrange=mads_config["mads_obsrange"]
if mads_obsrange == "ON"
	var=mads_config["mads_obs_percent_variance"]
	for i in eachindex(obs)
		min_r = max.(obs[i] .- obs[i] .* (var / 100), 0)
		max_r = obs[i] + obs[i] .* (var / 100)
		push!(obsdist, "Uniform($(min_r), $(max_r))")
	end
end


md = Mads.createproblem(initial_guess, targets, TEM_pycall;
	paramkey=mads_config["mads_paramkey"],
	paramdist,
	obstime,
	obsweight,
	paramlog,
	obsdist,
	problemname=mads_config["mads_problemname"])

md["Problem"] = Dict{Any,Any}("ssdr"=>true)

Mads.showparameters(md)
Mads.showobservations(md)

forward_model = Mads.forward(md)

calib_param, calib_information = Mads.calibrate(md, tolOF=0.01, tolOFcount=4)

Mads.plotmatches(md, calib_param, xtitle="# of observations", ytitle = "GPP",filename=mads_config["mads_problemname"]*".png")
