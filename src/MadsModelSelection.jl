import DocumentFunction

"""
Model section information criteria

$(DocumentFunction.documentfunction(modelinformationcriteria;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "par"=>"parameter array")))
"""
function modelinformationcriteria(madsdata::AbstractDict, par::Array{Float64}=Array{Float64}(undef, 0))
	f = Mads.forward(madsdata, par)
	l = Mads.localsa(madsdata, datafiles=false, imagefiles=false, par=par, obs=collect(values(f)))
	if l == nothing
		Mads.madswarn("Local sensitivity analysis fails!")
		return
	end
	ofval = Mads.of(madsdata, f)
	np = length(Mads.getoptparamkeys(madsdata))
	w = Mads.getobsweight(madsdata)
	w = w[w.>0]
	no = length(w)
	dof = (no > np) ? no - np : 1
	det_w = prod(w[w.>0])
	ln_det_w = log(det_w)
	gf = ofval / dof
	println("Objective function value                               : $(ofval)")
	println("Posterior measurement variance                         : $(gf)")
	ln_det_v = ln_det_w + no * log(gf) / 2
	aopt = sum(diag(l["covar"]))
	copt = abs(l["eigenvalues"][end])/abs(l["eigenvalues"][1])
	eopt = abs(l["eigenvalues"][end])
	dopt = prod(l["eigenvalues"])
	println("Optimality criteria based on the covariance matrix of observation errors:")
	println("A-optimality (matrix trace)                            : $(aopt)")
	println("C-optimality (matrix conditioning number)              : $(copt)")
	println("E-optimality (matrix maximum eigenvalue)               : $(eopt)")
	println("D-optimality (matrix determinant)                      : $(dopt)")
	println("Determinant of covariance matrix of observation errors : ln(det S) = $(log(dopt))")
	println("Determinant of observation weight matrix               : ln(det W) = $(ln_det_w)")
	println("Determinant of covariance matrix of measurement errors : ln(det V) = $(ln_det_v)")

	sml = dof + ln_det_v + no * 1.837877 # ln(2*pi)
	aic = sml + 2 * np
	bic = sml + np * log(no)
	aicc = sml + 2 * np * log(log(no))
	kic = sml + np * log(no * 0.159154943) - log(dopt)
	println("Log likelihood function                                : $(-sml/2)")
	println("Maximum likelihood                                     : $(sml)")
	println("AIC  (Akaike   Information Criterion)                  : $(aic)")
	println("AICc (Akaike   Information Criterion + correction)     : $(aicc)")
	println("BIC  (Bayesian Information Criterion)                  : $(bic)")
	println("KIC  (Kashyap  Information Criterion)                  : $(kic)")
end
