"""
Create function document
"""
function documentfunction(f::Function)
	stdoutcaptureon()
	println("## $(f)")
	m = methods(f)
	nm = 0
	try
		nm = length(m.ms)
	catch
		nm = 0
	end
	if nm == 0
		println("### No methods\n")
	else
		ma = collect(m)
		println("### Methods")
		for i = 1:nm
			println(" * Mads." * strip(string((ma[i]))))
		end
		a = getfunctionarguments(f)
		l = length(a)
		if l == 0
			println("Function `$(f)` takes no arguments")
		else
			println("### Arguments")
			for i = 1:l
				println(" * " * strip(string(a[i])))
			end
		end
		a = getfunctionkeywords(f)
		l = length(a)
		if l > 0
			println("### Keywords")
			for i = 1:l
				println(" * " * strip(string(a[i])))
			end
		end
	end
	stdoutcaptureoff()
end

"""
Get function arguments
"""
function getfunctionarguments(f::Function)
	m = methods(f)
	mp = Array{Symbol}(0)
	l = 0
	try
		l = length(m.ms)
	catch
		l = 0
	end
	for i in 1:l
		fargs = Array{Symbol}(0)
		try
			fargs = collect(m.ms[i].lambda_template.slotnames[2:end])
		catch
			fargs = Array{Symbol}(0)
		end
		for j in 1:length(fargs)
			if !contains(string(fargs[j]), "...")
				push!(mp, fargs[j])
			end
		end
	end
	return sort(unique(mp))
end

"""
Get function keywords
"""
function getfunctionkeywords(f::Function)
	# getfunctionarguments(f::Function) = methods(methods(f).mt.kwsorter).mt.defs.func.lambda_template.slotnames[4:end-4]
	m = methods(f)
	mp = Array{Symbol}(0)
	l = 0
	try
		l = length(m.ms)
	catch
		l = 0
	end
	for i in 1:l
		kwargs = Array{Symbol}(0)
		try
			kwargs = Base.kwarg_decl(m.ms[i].sig, typeof(m.mt.kwsorter))
		catch
			kwargs = Array{Symbol}(0)
		end
		for j in 1:length(kwargs)
			if !contains(string(kwargs[j]), "...")
				push!(mp, kwargs[j])
			end
		end
	end
	return sort(unique(mp))
end