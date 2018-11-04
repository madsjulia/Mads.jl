import DocumentFunction

function getfunctionargumentsold(f::Function)
	getfunctionarguments(f, methods(f))
end
function getfunctionargumentsold(f::Function, m::Base.MethodList, l::Integer=getmethodscount(m))
	mp = Array{Symbol}(undef, 0)
	for i in 1:l
		fargs = Array{Symbol}(undef, 0)
		try
			fargs = collect(m.ms[i].lambda_template.slotnames[2:end])
		catch
			fargs = Array{Symbol}(undef, 0)
		end
		for j in 1:length(fargs)
			if !occursin("...", string(fargs[j]))
				push!(mp, fargs[j])
			end
		end
	end
	return sort(unique(mp))
end

@doc """
Get function arguments

$(DocumentFunction.documentfunction(getfunctionargumentsold;
argtext=Dict("f"=>"function of interest",
            "m"=>"method list",
            "l"=>"number of method in argument m [default=`getmethodscount(m)`]")))

Returns:

- function arguments
""" getfunctionargumentsold

function getfunctionkeywordsold(f::Function)
	getfunctionkeywords(f, methods(f))
end
function getfunctionkeywordsold(f::Function, m::Base.MethodList, l::Integer=getmethodscount(m))
	# getfunctionkeywords(f::Function) = methods(methods(f).mt.kwsorter).mt.defs.func.lambda_template.slotnames[4:end-4]
	mp = Array{Symbol}(undef, 0)
	for i in 1:l
		kwargs = Array{Symbol}(undef, 0)
		try
			kwargs = Base.kwarg_decl(m.ms[i].sig, typeof(m.mt.kwsorter))
		catch
			kwargs = Array{Symbol}(undef, 0)
		end
		for j in 1:length(kwargs)
			if !occursin("...", string(kwargs[j]))
				push!(mp, kwargs[j])
			end
		end
	end
	return sort(unique(mp))
end

@doc """
Get function keywords

$(DocumentFunction.documentfunction(getfunctionkeywordsold;
argtext=Dict("f"=>"function of interest",
            "m"=>"method list",
            "l"=>"number of method in argument m [default=`getmethodscount(m)`]")))

Returns:

- function keywords
""" getfunctionkeywordsold

"""
Get methods count

$(DocumentFunction.documentfunction(getmethodscount;
argtext=Dict("m"=>"method list")))

Returns:

- number of methods
"""
function getmethodscount(m::Base.MethodList)
	nm = 0
	try
		nm = length(m.ms)
	catch
		nm = 0
	end
	return nm
end

