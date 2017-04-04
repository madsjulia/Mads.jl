function documentfunction(f::Function; maintext::String="", argtext::Dict=Dict(), keytext::Dict=Dict())
	stdoutcaptureon()
	if maintext! != ""
		println("**$(f)**\n")
		println("$(maintext)\n")
	end
	m = methods(f)
	ms = convert(Array{String, 1}, strip.(split(string(m.mt), "\n"))[2:end])
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

function getfunctionarguments(f::Function)
	m = methods(f)
	getfunctionarguments(f, string.(collect(m.ms)))
end
function getfunctionarguments(f::Function, m::Vector{String}, l::Integer=length(m))
	mp = Array{Symbol}(0)
	for i in 1:l
		r = match(r"(.*)\(([^;]*);(.*)\)", m[i])
		if typeof(r) == Void
			r = match(r"(.*)\((.*)\)", m[i])
		end
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

function getfunctionkeywords(f::Function)
	m = methods(f)
	getfunctionkeywords(f, string.(collect(m.ms)))
end
function getfunctionkeywords(f::Function, m::Vector{String}, l::Integer=length(m))
	# getfunctionkeywords(f::Function) = methods(methods(f).mt.kwsorter).mt.defs.func.lambda_template.slotnames[4:end-4]
	mp = Array{Symbol}(0)
	for i in 1:l
		r = match(r"(.*)\(([^;]*);(.*)\)", m[i])
		if typeof(r) != Void && length(r.captures) > 2
			kwargs = strip.(split(r.captures[3], ", "))
			for j in 1:length(kwargs)
				if !contains(string(kwargs[j]), "...") && kwargs[j] != ""
					push!(mp, kwargs[j])
				end
			end
		end
	end
	return sort(unique(mp))
end

@doc """
Create function documentation

$(documentfunction(documentfunction))
""" documentfunction

@doc """
Get function arguments

$(documentfunction(getfunctionarguments))
""" getfunctionarguments

@doc """
Get function keywords

$(documentfunction(getfunctionkeywords))
""" getfunctionkeywords