"""
Create function document
"""
function documentfunction(f::Function; argtext::Dict=Dict(), keytext::Dict=Dict())
	stdoutcaptureon()
	println("**$(f)**\n")
	m = methods(f)
	ms = string.(collect(m.ms))
	nm = length(ms)
	if nm == 0
		println("No methods\n")
	else
		println("Methods")
		for i = 1:nm
			s = strip.(split(ms[i], " at "))
			println(" - `Mads.$(s[1])` : $(s[2])")
		end
		a = getfunctionarguments(f, ms)
		l = length(a)
		if l > 0
			println("Arguments")
			for i = 1:l
				arg = strip(string(a[i]))
				print(" - `$(arg)`")
				if haskey(argtext, arg)
					println(" : $(argtext[arg]))")
				else
					println("")
				end
			end
		end
		a = getfunctionkeywords(f, ms)
		l = length(a)
		if l > 0
			println("Keywords")
			for i = 1:l
				key = strip(string(a[i]))
				print(" - `$(key)`")
				if haskey(keytext, key)
					println(" : $(keytext[key]))")
				else
					println("")
				end
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
	getfunctionarguments(f, string.(collect(m.ms)))
end
function getfunctionarguments(f::Function, m::Vector{String}, l::Integer=length(m))
	mp = Array{Symbol}(0)
	for i in 1:l
		r = match(r"(.*)\((.*)\)", m[i])
		if typeof(r) != Void && length(r.captures) > 1
			fargs = strip.(split(r.captures[2], ", "))
			for j in 1:length(fargs)
				if !contains(string(fargs[j]), "...") && fargs[j] != ""
					push!(mp, fargs[j])
				end
			end
		end
	end
	return sort(unique(mp))
end

"""
Get function keywords
"""
function getfunctionkeywords(f::Function)
	m = methods(f)
	getfunctionkeywords(f, string.(collect(m.ms)))
end
function getfunctionkeywords(f::Function, m::Vector{String}, l::Integer=length(m))
	# getfunctionkeywords(f::Function) = methods(methods(f).mt.kwsorter).mt.defs.func.lambda_template.slotnames[4:end-4]
	mp = Array{Symbol}(0)
	for i in 1:l
		r = match(r"(.*)\((.*);(.*)\)", m[i])
		if typeof(r) != Void != Void && length(r.captures) > 2
			kwargs = strip.(split(r.captures[2], ", "))
			for j in 1:length(kwargs)
				if !contains(string(kwargs[j]), "...") && kwargs[j] != ""
					push!(mp, kwargs[j])
				end
			end
		end
	end
	return sort(unique(mp))
end

"""
Get function arguments
"""
function getfunctionargumentsold(f::Function)
	getfunctionarguments(f, methods(f))
end
function getfunctionargumentsold(f::Function, m::Base.MethodList, l::Integer=getmethodscount(m))
	mp = Array{Symbol}(0)
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
function getfunctionkeywordsold(f::Function)
	getfunctionkeywords(f, methods(f))
end
function getfunctionkeywordsold(f::Function, m::Base.MethodList, l::Integer=getmethodscount(m))
	# getfunctionkeywords(f::Function) = methods(methods(f).mt.kwsorter).mt.defs.func.lambda_template.slotnames[4:end-4]
	mp = Array{Symbol}(0)
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

function getmethodscount(m::Base.MethodList)
	nm = 0
	try
		nm = length(m.ms)
	catch
		nm = 0
	end
	return nm
end