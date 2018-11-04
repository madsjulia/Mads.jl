import OrderedCollections
import DocumentFunction

# NLopt is too much of a pain to install at this point
"""
Calibrate using NLopt

$(DocumentFunction.documentfunction(calibratenlopt;
argtext=Dict("madsdata"=>"Mads problem dictionary"),
keytext=Dict("algorithm"=>"[default=`:LD_LBFGS`]")))

Returns:

- optimization results
"""
function calibratenlopt(madsdata::AbstractDict; algorithm=:LD_LBFGS) # TODO switch to a mathprogbase approach
	const paramkeys = getparamkeys(madsdata)
	const obskeys = getobskeys(madsdata)
	paraminits = getparamsinit(madsdata, paramkeys)
	parammins = getparamsmin(madsdata, paramkeys)
	parammaxs = getparamsmin(madsdata, paramkeys)
	weights = Mads.getobsweight(madsdata, obskeys)
	targets = Mads.getobstarget(madsdata, obskeys)
	fg = makemadscommandfunctionandgradient(madsdata)
	function fg_nlopt(arrayparameters::Vector, grad::Vector)
		parameters = OrderedCollections.OrderedDict{String,Float64}(zip(paramkeys, arrayparameters))
		resultdict, gradientdict = fg(parameters)
		residuals = Array{Float64}(undef, length(madsdata["Observations"]))
		ssr = 0
		i = 1
		for obskey in obskeys
			residuals[i] = resultdict[obskey] - targets[i]
			ssr += residuals[i] * residuals[i] * weights[i] * weights[i]
			i += 1
		end
		if length(grad) > 0
			i = 1
			for paramkey in paramkeys
				grad[i] = 0.
				j = 1
				for obskey in obskeys
					grad[i] += 2 * residuals[j] * gradientdict[obskey][paramkey]
					j += 1
				end
				i += 1
			end
		end
		return ssr
	end
	opt = NLopt.Opt(algorithm, length(paramkeys))
	NLopt.lower_bounds!(opt, parammins)
	NLopt.upper_bounds!(opt, parammaxs)
	NLopt.min_objective!(opt, fg_nlopt)
	NLopt.maxeval!(opt, round(Int, 1e3))
	minf, minx, ret = NLopt.optimize(opt, paraminits)
	return minf, minx, ret
end
