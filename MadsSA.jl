if VERSION < v"0.4.0-dev"
	using Docile # default for v > 0.4
end
# @document
@docstrings

@doc "Saltelli (brute force)" ->
function saltellibrute(madsdata; numsamples=int(1e6), numoneparamsamples=int(1e2), nummanyparamsamples=int(1e4))
	# convert the distribution strings into actual distributions
	paramkeys = getparamkeys(madsdata)
	# find the mean and variance
	f = makemadscommandfunction(madsdata)
	distributions = getdistributions(madsdata)
	results = Array(Dict, numsamples)
	paramdict = Dict()
	for i = 1:numsamples
		for j in 1:length(paramkeys)
			paramdict[paramkeys[j]] = Distributions.rand(distributions[paramkeys[j]])
		end
		results[i] = f(paramdict)
	end
	obskeys = getobskeys(madsdata)
	sum = Dict()
	for i = 1:length(obskeys)
		sum[obskeys[i]] = 0.
	end
	for j = 1:numsamples
		for i = 1:length(obskeys)
			sum[obskeys[i]] += results[j][obskeys[i]]
		end
	end
	mean = Dict()
	for i = 1:length(obskeys)
		mean[obskeys[i]] = sum[obskeys[i]] / numsamples
	end
	for i = 1:length(paramkeys)
		sum[paramkeys[i]] = 0.
	end
	for j = 1:numsamples
		for i = 1:length(obskeys)
			sum[obskeys[i]] += (results[j][obskeys[i]] - mean[obskeys[i]]) ^ 2
		end
	end
	variance = Dict()
	for i = 1:length(obskeys)
		variance[obskeys[i]] = sum[obskeys[i]] / (numsamples - 1)
	end
	# compute the first order sensitivities
	fos = Dict()
	for k = 1:length(obskeys)
		fos[obskeys[k]] = Dict()
	end
	for i = 1:length(paramkeys)
		cond_means = Array(Dict, numoneparamsamples)
		for j = 1:numoneparamsamples
			cond_means[j] = Dict()
			for k = 1:length(obskeys)
				cond_means[j][obskeys[k]] = 0.
			end
			paramdict[paramkeys[i]] = Distributions.rand(distributions[paramkeys[i]])
			for k = 1:nummanyparamsamples
				for m = 1:length(paramkeys)
					if m != i
						paramdict[paramkeys[m]] = Distributions.rand(distributions[paramkeys[m]])
					end
				end
				results = f(paramdict)
				for k = 1:length(obskeys)
					cond_means[j][obskeys[k]] += results[obskeys[k]]
				end
			end
			for k = 1:length(obskeys)
				cond_means[j][obskeys[k]] /= nummanyparamsamples
			end
		end
		v = Array(Float64, numoneparamsamples)
		for k = 1:length(obskeys)
			for m = 1:numoneparamsamples
				v[m] = cond_means[m][obskeys[k]]
			end
			fos[obskeys[k]][paramkeys[i]] = std(v) ^ 2 / variance[obskeys[k]]
		end
	end
	# compute the total effect
	te = Dict()
	for k = 1:length(obskeys)
		te[obskeys[k]] = Dict()
	end
	for i = 1:length(paramkeys)
		cond_vars = Array(Dict, nummanyparamsamples)
		cond_means = Array(Dict, nummanyparamsamples)
		for j = 1:nummanyparamsamples
			cond_vars[j] = Dict()
			cond_means[j] = Dict()
			for m = 1:length(obskeys)
				cond_means[j][obskeys[m]] = 0.
				cond_vars[j][obskeys[m]] = 0.
			end
			for m = 1:length(paramkeys)
				if m != i
					paramdict[paramkeys[m]] = Distributions.rand(distributions[paramkeys[m]])
				end
			end
			results = Array(Dict, numoneparamsamples)
			for k = 1:numoneparamsamples
				paramdict[paramkeys[i]] = Distributions.rand(distributions[paramkeys[i]])
				results[k] = f(paramdict)
				for m = 1:length(obskeys)
					cond_means[j][obskeys[m]] += results[k][obskeys[m]]
				end
			end
			for m = 1:length(obskeys)
				cond_means[j][obskeys[m]] /= numoneparamsamples
			end
			for k = 1:numoneparamsamples
				for m = 1:length(obskeys)
					cond_vars[j][obskeys[m]] += (results[k][obskeys[m]] - cond_means[j][obskeys[m]]) ^ 2
				end
			end
			for m = 1:length(obskeys)
				cond_vars[j][obskeys[m]] /= numoneparamsamples - 1
			end
		end
		for j = 1:length(obskeys)
			runningsum = 0.
			for m = 1:nummanyparamsamples
				runningsum += cond_vars[m][obskeys[j]]
			end
			te[obskeys[j]][paramkeys[i]] = runningsum / nummanyparamsamples / variance[obskeys[j]]
		end
	end
	return mean, variance, fos, te
end

@doc "Saltelli " ->
function saltelli(madsdata; N=int(100))
	paramkeys = getparamkeys(madsdata)
	obskeys = getobskeys(madsdata)
	distributions = getdistributions(madsdata)
	f = makemadscommandfunction(madsdata)
	A = Array(Float64, (N, length(paramkeys)))
	B = Array(Float64, (N, length(paramkeys)))
	C = Array(Float64, (N, length(paramkeys)))
	meandata = Dict{String, Dict{String, Float64}}() # mean
	variance = Dict{String, Dict{String, Float64}}() # variance
	fos = Dict{String, Dict{String, Float64}}() # first order sensitivities
	te = Dict{String, Dict{String, Float64}}()	# total effect
	for i = 1:length(obskeys)
		meandata[obskeys[i]] = Dict{String, Float64}()
		variance[obskeys[i]] = Dict{String, Float64}()
		fos[obskeys[i]] = Dict{String, Float64}()
		te[obskeys[i]] = Dict{String, Float64}()
	end
	for i = 1:N
		for j = 1:length(paramkeys)
			A[i, j] = Distributions.rand(distributions[paramkeys[j]])
			B[i, j] = Distributions.rand(distributions[paramkeys[j]])
		end
	end
	madsinfo( """Computing model outputs to calculate total output mean and variance ... Sample A ...""" );
	yA = hcat(pmap(i->collect(values(f(Dict{String, Float64}(paramkeys, A[i, :])))), 1:size(A, 1))...)'
	madsinfo( """Computing model outputs to calculate total output mean and variance ... Sample A ...""" );
	yB = hcat(pmap(i->collect(values(f(Dict{String, Float64}(paramkeys, B[i, :])))), 1:size(B, 1))...)'
	for i = 1:length(paramkeys)
		for j = 1:N
			for k = 1:length(paramkeys)
				if k != i
					C[j, k] = B[j, k]
				else
					C[j, k] = A[j, k]
				end
			end
		end
		madsinfo( """Computing model outputs to calculate total output mean and variance ... Sample C ... Parameter $(paramkeys[i])""" );
		yC = hcat(pmap(i->collect(values(f(Dict{String, Float64}(paramkeys, C[i, :])))), 1:size(C, 1))...)'
		for j = 1:length(obskeys)
			f0 = .5 * (mean(yA[:, j]) + mean(yB[:, j]))
			meandata[obskeys[j]][paramkeys[i]] = f0;
			var = .5 * ((dot(yA[:, j], yA[:, j]) - f0 ^ 2) + (dot(yB[:, j], yB[:, j]) - f0 ^ 2))
			variance[obskeys[j]][paramkeys[i]] = var
			fos[obskeys[j]][paramkeys[i]] = (dot(yA[:, j], yC[:, j]) - f0 ^ 2) / var
			te[obskeys[j]][paramkeys[i]] = 1 - (dot(yB[:, j], yC[:, j]) - f0 ^ 2) / var
		end
	end
	return meandata, variance, fos, te
end

names = ["saltelli", "saltellibrute"]

for mi = 1:length(names)
	q = quote
		function $(symbol(string(names[mi], "parallel")))(madsdata, numsaltellis; N=int(100))
			if numsaltellis < 1
				madserr("""Number of parallel sesistivity runs must be > 0 ($numsaltellis < 1)""")
				return
			end
			results = pmap(i->$(symbol(names[mi]))(madsdata; N=N), 1:numsaltellis)
			meanall, varianceall, fosall, teall = results[1]
			for i = 2:numsaltellis
				mean, variance, fos, te = results[i]
				for obskey in keys(fos)
					for paramkey in keys(fos[obskey])
						meanall[obskey][paramkey] += mean[obskey][paramkey]
						varianceall[obskey][paramkey] += variance[obskey][paramkey]
						fosall[obskey][paramkey] += fos[obskey][paramkey]
						teall[obskey][paramkey] += te[obskey][paramkey]
					end
				end
			end
			for obskey in keys(fosall)
				for paramkey in keys(fosall[obskey])
					meanall[obskey][paramkey] /= numsaltellis
					varianceall[obskey][paramkey] /= numsaltellis
					fosall[obskey][paramkey] /= numsaltellis
					teall[obskey][paramkey] /= numsaltellis
				end
			end
			return meanall, varianceall, fosall, teall
		end # end fuction
	end # end quote
	eval(q)
end

function saltelliprintresults(madsdata, results)
	mean, variance, fos, te = results
	println("Mean")
	print("\t")
	obskeys = getobskeys(madsdata)
	paramkeys = getparamkeys(madsdata)
	for paramkey in paramkeys
		print("\t$(paramkey)")
	end
	println()
	for obskey in obskeys
		print(obskey)
		for paramkey in paramkeys
			print("\t$(mean[obskey][paramkey])")
		end
		println()
	end
	println("\nVariance")
	print("\t")
	obskeys = getobskeys(madsdata)
	paramkeys = getparamkeys(madsdata)
	for paramkey in paramkeys
		print("\t$(paramkey)")
	end
	println()
	for obskey in obskeys
		print(obskey)
		for paramkey in paramkeys
			print("\t$(variance[obskey][paramkey])")
		end
		println()
	end
	println("\nFirst order sensitivity")
	print("\t")
	obskeys = getobskeys(madsdata)
	paramkeys = getparamkeys(madsdata)
	for paramkey in paramkeys
		print("\t$(paramkey)")
	end
	println()
	for obskey in obskeys
		print(obskey)
		for paramkey in paramkeys
			print("\t$(fos[obskey][paramkey])")
		end
		println()
	end
	println("\nTotal effect")
	print("\t")
	for paramkey in paramkeys
		print("\t$(paramkey)")
	end
	println()
	for obskey in obskeys
		print(obskey)
		for paramkey in paramkeys
			print("\t$(te[obskey][paramkey])")
		end
		println()
	end
end