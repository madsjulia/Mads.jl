"Model section information criteria"
function makearrayfunction(madsdata::Associative, par::Array=[])
	f = Mads.forward(madsdata, par)
	of = Mads.of(madsdata, f)
	np = length(Mads.getoptparamkeys(madsdata))
	no = length(Mads.gettargetkeys(madsdata))
	dof = (no > np) ? no - np : 1
	w = Mads.getobsweight(madsdata)
	det_w = prod(w)
	ln_det_w = log(det_w)
	gf = of / dof
	println("Posterior measurement variance                         : $(gf)")
	ln_det_v = ln_det_w + no * log(sqrt(gf))
	l = Mads.localsa(md, datafiles=false, imagefiles=false, param=pv, obs=collect(values(f)))
	aopt = sum(diag(l["covar"]))
	copt = abs(l["eigenvalues"][end])/abs(l["eigenvalues"][1])
	eopt = abs(l["eigenvalues"][end])
	dopt = prod(l["eigenvalues"])
	println("Optimality criteria based on covariance matrix of observation errors:")
	println("A-optimality (matrix trace)                            : $(aopt)")
	println("C-optimality (matrix conditioning number)              : $(copt)")
	println("E-optimality (matrix maximum eigenvalue)               : $(eopt)")
	println("D-optimality (matrix determinant)                      : $(dopt)")
	println("Determinant of covariance matrix of observation errors : ln(det S) = $(log(dopt))")
	println("Determinant of observation weight matrix               : ln(det W) = $(ln_det_w)")
	println("Determinant of covariance matrix of measurement errors : ln(det V) = $(ln_det_v)")

	sml = dof + ln_det_v + no * 1.837877
	aic = sml + 2 * np
	bic = sml + np * log(no)
	aicc = sml + 2 * np * log(log(no))
	kic = sml + np * log(no * 0.159154943) - log(dopt)
	println("Log likelihood function                            : $(-sml/2)")
	println("Maximum likelihood                                 : $(sml)")
	println("AIC  (Akaike   Information Criterion)              : $(aic)")
	println("AICc (Akaike   Information Criterion + correction) : $(aicc)")
	println("BIC  (Bayesian Information Criterion)              : $(bic)")
	println("KIC  (Kashyap  Information Criterion)              : $(kic)")
end
