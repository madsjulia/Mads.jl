import OrderedCollections
import DocumentFunction

"""
Read observations using C MADS dynamic library

$(DocumentFunction.documentfunction(readobservations_cmads;
argtext=Dict("madsdata"=>"Mads problem dictionary")))

Returns:

- observations
"""
function readobservations_cmads(madsdata::AbstractDict)
	obsids=getobskeys(madsdata)
	observations = OrderedCollections.OrderedDict{String,Float64}(zip(obsids, zeros(length(obsids))))
	for instruction in madsdata["Instructions"]
		obs = cmadsins_obs(obsids, instruction["ins"], instruction["read"])
		#this loop assumes that cmadsins_obs gives a zero value if the obs is not found, and that each obs will appear only once
		for obsid in obsids
			observations[obsid] += obs[obsid]
		end
	end
	return observations
end

"""
Call C MADS ins_obs() function from MADS dynamic library

$(DocumentFunction.documentfunction(cmadsins_obs;
argtext=Dict("obsid"=>"observation id",
            "instructionfilename"=>"instruction file name",
            "inputfilename"=>"input file name")))

Return:

- observations
"""
function cmadsins_obs(obsid::Vector, instructionfilename::String, inputfilename::String)
	n = length(obsid)
	obsval = zeros(n) # initialize to 0
	obscheck = -1 * ones(n) # initialize to -1
	debug = 0 # setting debug level 0 or 1 works
	# int ins_obs( int nobs, char **obs_id, double *obs, double *check, char *fn_in_t, char *fn_in_d, int debug );
	result = ccall( (:ins_obs, "libmads"), Int32,
					(Int32, Ptr{Ptr{UInt8}}, Ptr{Float64}, Ptr{Float64}, Ptr{UInt8}, Ptr{UInt8}, Int32),
					n, obsid, obsval, obscheck, instructionfilename, inputfilename, debug)
	observations = Dict{String, Float64}(zip(obsid, obsval))
	return observations
end
