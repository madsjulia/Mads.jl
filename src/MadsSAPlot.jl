import Gadfly

"""
Local sensitivity analysis based on eigen analysis of covariance matrix

Arguments:

- `madsdata` : MADS problem dictionary
- `madsdata` : MADS problem dictionary
- `filename` : output file name
- `format` : output plot format (`png`, `pdf`, etc.)
- `par` : parameter set
- `obs` : observations for the parameter set
"""
function localsa(madsdata::Associative; format::AbstractString="", filename::AbstractString="", datafiles=true, imagefiles=true, par=Array(Float64,0), obs=Array(Float64,0))
	if filename == ""
		rootname = Mads.getmadsrootname(madsdata)
		ext = ""
	else
		rootname = Mads.getrootname(filename)
		ext = "." * Mads.getextension(filename)
	end
	g = makelocalsafunction(madsdata)
	paramkeys = getoptparamkeys(madsdata)
	plotlabels = getparamsplotname(madsdata, paramkeys)
	if plotlabels[1] == ""
		plotlabels = paramkeys
	end
	nP = length(paramkeys)
	nPi = sizeof(par)
	if nPi == 0
		param = getparamsinit(madsdata, paramkeys)
	elseif nPi != nP
		param = getoptparams(madsdata, par, paramkeys)
	end
	J = g(param, center=obs)
	if any(isnan, J)
		Mads.madswarn("Local sensitivity analysis cannot be performed; provided Jacobian matrix contains NaN's")
		Base.display(J)
		Mads.madscritical("Mads quits!")
	end
	datafiles && writedlm("$(rootname)-jacobian.dat", J)
	mscale = max(abs(minimum(J)), abs(maximum(J)))
	if imagefiles && isdefined(:Gadfly)
		jacmat = Gadfly.spy(J, Gadfly.Scale.x_discrete(labels = i->plotlabels[i]), Gadfly.Scale.y_discrete,
					Gadfly.Guide.YLabel("Observations"), Gadfly.Guide.XLabel("Parameters"),
					Gadfly.Theme(default_point_size=20Gadfly.pt, major_label_font_size=14Gadfly.pt, minor_label_font_size=12Gadfly.pt, key_title_font_size=16Gadfly.pt, key_label_font_size=12Gadfly.pt),
					Gadfly.Scale.ContinuousColorScale(Gadfly.Scale.lab_gradient(parse(Colors.Colorant, "green"), parse(Colors.Colorant, "yellow"), parse(Colors.Colorant, "red")), minvalue = -mscale, maxvalue = mscale))
		filename = "$(rootname)-jacobian" * ext
		filename, format = setplotfileformat(filename, format)
		Gadfly.draw(Gadfly.eval(Symbol(format))(filename, 6Gadfly.inch, 12Gadfly.inch), jacmat)
		Mads.madsinfo("Jacobian matrix plot saved in $filename")
	end
	JpJ = J' * J
	covar = Array(Float64, 0)
	try
		u, s, v = svd(JpJ)
		covar = v * inv(diagm(s)) * u'
	catch "LAPACKException(12)"
		try
			covar = inv(JpJ)
		catch "SingularException(4)"
			Mads.madserror("Singular covariance matrix! Local sensitivity analysis fails.")
			return
		end
	end
	stddev = sqrt(abs(diag(covar)))
	if datafiles
		writedlm("$(rootname)-covariance.dat", covar)
		f = open("$(rootname)-stddev.dat", "w")
		for i in 1:nP
			write(f, "$(paramkeys[i]) $(param[i]) $(stddev[i])\n")
		end
		close(f)
	end
	correl = covar ./ diag(covar)
	datafiles && writedlm("$(rootname)-correlation.dat", correl)
	eigenv, eigenm = eig(covar)
	eigenv = abs(eigenv)
	index = sortperm(eigenv)
	sortedeigenv = eigenv[index]
	sortedeigenm = real(eigenm[:,index])
	datafiles && writedlm("$(rootname)-eigenmatrix.dat", sortedeigenm)
	datafiles && writedlm("$(rootname)-eigenvalues.dat", sortedeigenv)
	if imagefiles && isdefined(:Gadfly)
		eigenmat = Gadfly.spy(sortedeigenm, Gadfly.Scale.y_discrete(labels = i->plotlabels[i]), Gadfly.Scale.x_discrete,
					Gadfly.Guide.YLabel("Parameters"), Gadfly.Guide.XLabel("Eigenvectors"),
					Gadfly.Theme(default_point_size=20Gadfly.pt, major_label_font_size=14Gadfly.pt, minor_label_font_size=12Gadfly.pt, key_title_font_size=16Gadfly.pt, key_label_font_size=12Gadfly.pt),
					Gadfly.Scale.ContinuousColorScale(Gadfly.Scale.lab_gradient(parse(Colors.Colorant, "green"), parse(Colors.Colorant, "yellow"), parse(Colors.Colorant, "red"))))
		# eigenval = plot(x=1:length(sortedeigenv), y=sortedeigenv, Scale.x_discrete, Scale.y_log10, Geom.bar, Guide.YLabel("Eigenvalues"), Guide.XLabel("Eigenvectors"))
		filename = "$(rootname)-eigenmatrix" * ext
		filename, format = setplotfileformat(filename, format)
		Gadfly.draw(Gadfly.eval(Symbol(format))(filename,6Gadfly.inch,6Gadfly.inch), eigenmat)
		Mads.madsinfo("Eigen matrix plot saved in $filename")
		eigenval = Gadfly.plot(x=1:length(sortedeigenv), y=sortedeigenv, Gadfly.Scale.x_discrete, Gadfly.Scale.y_log10,
					Gadfly.Geom.bar,
					Gadfly.Theme(default_point_size=20Gadfly.pt, major_label_font_size=14Gadfly.pt, minor_label_font_size=12Gadfly.pt, key_title_font_size=16Gadfly.pt, key_label_font_size=12Gadfly.pt),
					Gadfly.Guide.YLabel("Eigenvalues"), Gadfly.Guide.XLabel("Eigenvectors"))
		filename = "$(rootname)-eigenvalues" * ext
		filename, format = setplotfileformat(filename, format)
		Gadfly.draw(Gadfly.eval(Symbol(format))(filename, 6Gadfly.inch, 4Gadfly.inch), eigenval)
		Mads.madsinfo("Eigen values plot saved in $filename")
	end
	Dict("jacobian"=>J, "covar"=>covar, "stddev"=>stddev, "eigenmatrix"=>sortedeigenm, "eigenvalues"=>sortedeigenv)
end
