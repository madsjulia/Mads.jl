import Pkg
import DocumentFunction
import Random

function subsample_matrix(m::AbstractMatrix, best_worst::Integer=1, overall::Integer=0)
	if overall == 0 && best_worst == 0
		return trues(size(m, 2))
	end
	if overall >= size(m, 2) || best_worst >= size(m, 2)
		return trues(size(m, 2))
	end
	ix = falses(size(m, 2))
	for i in axes(m, 1)
		rs = sortperm(m[i, :])
		ix[rs[1:best_worst]] .= true
		ix[rs[end-best_worst+1:end]] .= true
	end
	if sum(ix) < overall
		ir = Random.randperm(size(m, 2)-sum(ix))[1:overall-sum(ix)]
		ia = findall(i->!(i .> 0), ix)[ir]
		ix[ia] .= true
	end
	return ix
end

function maximumnan(X, c...; kw...)
	maximum(X[.!isnan.(X)], c...; kw...)
end

function minimumnan(X, c...; kw...)
	minimum(X[.!isnan.(X)], c...; kw...)
end

function maximuminf(X, c...; kw...)
	maximum(X[.!isinf.(X)], c...; kw...)
end

function minimuminf(X, c...; kw...)
	minimum(X[.!isinf.(X)], c...; kw...)
end

function rmsenan(t::AbstractVector, o::AbstractVector)
	it = .!isnan.(t)
	ot = .!isnan.(o)
	ii = it .& ot
	return sqrt( sum( (t[ii] .- o[ii]) .^ 2.) ./ sum(ii) )
end

function sumnan(X; dims::Union{Nothing,Integer}=nothing, kw...)
	if isnothing(dims)
		return sum(X[.!isnan.(X)]; kw...)
	else
		count = .*(size(X)[vec(collect(dims))]...)
		I = isnan.(X)
		X[I] .= 0
		sX = sum(X; dims=dims, kw...)
		X[I] .= NaN
		sI = sum(I; dims=dims, kw...)
		sX[sI.==count] .= NaN
		return sX
	end
end

"""
MADS vector calls on

$(DocumentFunction.documentfunction(vectoron))
"""
function vectoron()
	global vectorflag = true;
end

"""
MADS vector calls off

$(DocumentFunction.documentfunction(vectoroff))
"""
function vectoroff()
	global vectorflag = false;
end

"""
Set number of processors needed for each parallel task at each node

$(DocumentFunction.documentfunction(set_nprocs_per_task))
"""
function set_nprocs_per_task(local_nprocs_per_task::Integer=1)
	global nprocs_per_task_default = local_nprocs_per_task
end

"""
MADS restart on

$(DocumentFunction.documentfunction(restarton))
"""
function restarton()
	global restart = true;
end

"""
MADS restart off

$(DocumentFunction.documentfunction(restartoff))
"""
function restartoff()
	global restart = false;
end

"""
Get MADS restart status

$(DocumentFunction.documentfunction(getrestart;
argtext=Dict("madsdata"=>"MADS problem dictionary")))
"""
function getrestart(madsdata::AbstractDict)
	haskey(madsdata, "Restart") ? madsdata["Restart"] : restart # note madsdata["Restart"] can be a string
end

"""
Make MADS quiet

$(DocumentFunction.documentfunction(quieton))
"""
function quieton()
	global quiet = true;
end

"""
Make MADS not quiet

$(DocumentFunction.documentfunction(quietoff))
"""
function quietoff()
	global quiet = false;
end

"""
Make MADS very quiet

$(DocumentFunction.documentfunction(veryquieton))
"""
function veryquieton()
	global veryquiet = true;
end

"""
Make MADS not very quiet

$(DocumentFunction.documentfunction(veryquietoff))
"""
function veryquietoff()
	global veryquiet = false;
end

"""
Make MADS capture

$(DocumentFunction.documentfunction(captureon))
"""
function captureon()
	global capture = true;
end

"""
Make MADS not capture

$(DocumentFunction.documentfunction(captureoff))
"""
function captureoff()
	global capture = false;
end

"""
MADS graph output on

$(DocumentFunction.documentfunction(graphon))
"""
function graphon()
	global graphoutput = true;
end

"""
MADS graph output off

$(DocumentFunction.documentfunction(graphoff))
"""
function graphoff()
	global graphoutput = false;
end

"""
Set image dpi

$(DocumentFunction.documentfunction(setdpi))
"""
function setdpi(dpi::Integer)
	global imagedpi = dpi;
end

"""
Turn on the generation of MADS tests (dangerous)

$(DocumentFunction.documentfunction(create_tests_on))
"""
function create_tests_on()
	global create_tests = true;
end

"""
Turn off the generation of MADS tests (default)

$(DocumentFunction.documentfunction(create_tests_off))
"""
function create_tests_off()
	global create_tests = false;
end

"""
Turn on execution of long MADS tests

$(DocumentFunction.documentfunction(long_tests_on))
"""
function long_tests_on()
	global long_tests = true;
end

"""
Turn off execution of long MADS tests (default)

$(DocumentFunction.documentfunction(long_tests_off))
"""
function long_tests_off()
	global long_tests = false;
end

"""
Turn on parallel optimization of jacobians and lambdas

$(DocumentFunction.documentfunction(parallel_optimization_on))
"""
function parallel_optimization_on()
	global parallel_optimization = true;
end

"""
Turn off parallel optimization of jacobians and lambdas

$(DocumentFunction.documentfunction(parallel_optimization_off))
"""
function parallel_optimization_off()
	global parallel_optimization = false;
end

"""
Set MADS debug level

$(DocumentFunction.documentfunction(setdebuglevel;
argtext=Dict("level"=>"debug level")))
"""
function setdebuglevel(level::Integer)
	global debuglevel = level
end

"""
Set MADS verbosity level

$(DocumentFunction.documentfunction(setverbositylevel;
argtext=Dict("level"=>"debug level")))
"""
function setverbositylevel(level::Integer)
	global verbositylevel = level
end

"""
Set maximum execution wait time for forward model runs in seconds

$(DocumentFunction.documentfunction(setexecutionwaittime;
argtext=Dict("waitime"=>"maximum execution wait time for forward model runs in seconds")))
"""
function setexecutionwaittime(waitime::Float64)
	global executionwaittime = waitime
end

"""
Reset the model runs count to be equal to zero

$(DocumentFunction.documentfunction(resetmodelruns))
"""
function resetmodelruns()
	global modelruns = 0
end

function haskeyword(madsdata::AbstractDict, keyword::AbstractString)
	return haskey(madsdata, "Problem") ? haskeyword(madsdata, "Problem", keyword) : false
end
function haskeyword(madsdata::AbstractDict, class::AbstractString, keyword::AbstractString)
	if typeof(madsdata[class]) <: AbstractDict
		return haskey(madsdata[class], keyword) ? true : false
	elseif typeof(madsdata[class]) <: AbstractString
		return madsdata[class] == keyword
	elseif typeof(madsdata[class]) <: Vector{String}
		for i in madsdata[class]
			if i == keyword
				return true
			end
		end
		return false
	else
		return false
	end
end
@doc """
Check for a `keyword` in a `class` within the Mads dictionary `madsdata`

$(DocumentFunction.documentfunction(haskeyword;
argtext=Dict("madsdata"=>"MADS problem dictionary",
			"keyword"=>"dictionary key",
			"class"=>"dictionary class; if not provided searches for `keyword` in `Problem` class")))

Returns: `true` or `false`

Examples:

```julia
- `Mads.haskeyword(madsdata, "disp")` ... searches in `Problem` class by default
- `Mads.haskeyword(madsdata, "Wells", "R-28")` ... searches in `Wells` class for a keyword "R-28"
```
""" haskeyword

function addkeyword!(madsdata::AbstractDict, keyword::AbstractString)
	haskey(madsdata, "Problem") ? addkeyword!(madsdata, "Problem", keyword) : madsdata["Problem"] = keyword
	return
end
function addkeyword!(madsdata::AbstractDict, class::AbstractString, keyword::AbstractString)
	if haskeyword(madsdata, class, keyword)
		madswarn("Keyword `$(keyword)` already exists")
		return
	end
	if typeof(madsdata[class]) <: AbstractDict
		push!(madsdata[class], keyword=>true)
	elseif typeof(madsdata[class]) <: AbstractString
		madsdata[class] = [keyword, madsdata[class]]
	elseif typeof(madsdata[class]) <: Vector{String}
		push!(madsdata[class], keyword)
	end
end
@doc """
Add a `keyword` in a `class` within the Mads dictionary `madsdata`

$(DocumentFunction.documentfunction(addkeyword!;
argtext=Dict("madsdata"=>"MADS problem dictionary",
			"keyword"=>"dictionary key",
			"class"=>"dictionary class; if not provided searches for `keyword` in `Problem` class")))
""" addkeyword!

function deletekeyword!(madsdata::AbstractDict, keyword::AbstractString)
	if haskeyword(madsdata, keyword)
		deletekeyword!(madsdata, "Problem", keyword)
	end
	return
end
function deletekeyword!(madsdata::AbstractDict, class::AbstractString, keyword::AbstractString)
	if haskeyword(madsdata, class, keyword)
		if typeof(madsdata[class]) <: AbstractDict && haskey(madsdata[class], keyword)
			delete!(madsdata[class], keyword)
		elseif typeof(madsdata[class]) <: AbstractString
			madsdata[class] = ""
		elseif typeof(madsdata[class]) <: Vector{String}
			v = madsdata[class]
			madsdata[class] = v[v .!= keyword]
		end
	end
end
@doc """
Delete a `keyword` in a `class` within the Mads dictionary `madsdata`

$(DocumentFunction.documentfunction(deletekeyword!;
argtext=Dict("madsdata"=>"MADS problem dictionary",
			"keyword"=>"dictionary key",
			"class"=>"dictionary class; if not provided searches for `keyword` in `Problem` class")))
""" deletekeyword!

"""
Get sin-space dx

$(DocumentFunction.documentfunction(getsindx;
argtext=Dict("madsdata"=>"MADS problem dictionary")))

Returns:

- sin-space dx value
"""
function getsindx(madsdata::AbstractDict)
	sindx = sindxdefault
	if Mads.haskeyword(madsdata, "sindx")
		sindx = madsdata["Problem"]["sindx"]
		if typeof(sindx) <: AbstractString
			sindx = parse(Float64, sindx)
		end
	end
	return sindx
end

function setsindx!(madsdata::AbstractDict, sindx::Number)
	setsindx!(sindx)
	if Mads.haskeyword(madsdata, "sindx")
		madsdata["Problem"]["sindx"] = sindx
	elseif haskey(madsdata, "Problem")
		push!(madsdata["Problem"], Dict("sindx"=>sindx))
	else
		madsdata["Problem"] = Dict{Any,Any}("sindx"=>sindx)
	end
end

function setsindx!(sindx::Number)
	global sindxdefault = sindx
end

"""
Set sin-space dx

$(DocumentFunction.documentfunction(setsindx!;
argtext=Dict("madsdata"=>"MADS problem dictionary", "sindx"=>"sin-space dx value")))

Returns:

- nothing
"""

"""
Transpose non-numeric vector

$(DocumentFunction.documentfunction(transposevector;
argtext=Dict("a"=>"vector")))
"""
function transposevector(a::AbstractVector)
	reshape(a, 1, length(a))
end

"""
Transpose non-numeric matrix

$(DocumentFunction.documentfunction(transposematrix;
argtext=Dict("a"=>"matrix")))
"""
function transposematrix(a::AbstractMatrix)
	permutedims(a, (2, 1))
end

"""
Print error message

$(DocumentFunction.documentfunction(printerrormsg;
argtext=Dict("errmsg"=>"error message")))
"""
function printerrormsg(errmsg::Any)
	Base.showerror(stderr, errmsg)
	if in(:msg, fieldnames(typeof(errmsg)))
		madswarn(strip(errmsg.msg))
	elseif typeof(errmsg) <: AbstractString
		madswarn(errmsg)
	end
end

function meshgrid(x::AbstractVector, y::AbstractVector)
	nx = length(x)
	ny = length(y)
	xx = reshape(x, 1, nx)
	yy = reshape(y, ny, 1)
	(permutedims(repeat(xx, ny, 1)), permutedims(repeat(yy, 1, nx)))
end
function meshgrid(nx::Number, ny::Number)
	x = collect(range(1, nx; length=nx))
	y = collect(range(1, ny; length=ny))
	xx = reshape(x, 1, nx)
	yy = reshape(y, ny, 1)
	(permutedims(repeat(xx, ny, 1)), permutedims(repeat(yy, 1, nx)))
end
@doc """
Create mesh grid

$(DocumentFunction.documentfunction(meshgrid;
argtext=Dict("x"=>"vector of grid x coordinates",
			"y"=>"vector of grid y coordinates")))

Returns:

- 2D grid coordinates based on the coordinates contained in vectors `x` and `y`
""" meshgrid

"""
Set / get current random seed. seed < 0 gets seed, anything else sets it.

$(DocumentFunction.documentfunction(setseed;
argtext=Dict("seed"=>"random seed",
			"quiet"=>"[default=`true`]")))
"""
function setseed(seed::Integer=-1, quiet::Bool=true; rng::Union{Nothing,Random.AbstractRNG,DataType}=nothing)
	if seed >= 0
		Mads.seed!(seed, rng)
		!quiet && @info("New seed: $seed")
	else
		s = getseed()
		!quiet && @info("Current seed: $s")
	end
	return nothing
end

"""
Get and return current random seed.

$(DocumentFunction.documentfunction(getseed))
"""
function getseed()
	return Random.GLOBAL_SEED.s0
end

function seedrng(f=nothing)
	if isnothing(f)
		if isdefined(Random, :TaskLocalRNG)
			f = Random.TaskLocalRNG
		else
			f = Random.MersenneTwister
		end
	end
	if isdefined(Random, :TaskLocalRNG) && f == Random.TaskLocalRNG
		global rng = f()
	else
		global rng = f()
	end
end

function seed!(s, f=nothing)
	if isnothing(f)
		if isdefined(Random, :TaskLocalRNG)
			f = Random.TaskLocalRNG
		else
			f = Random.MersenneTwister
		end
	end
	if isdefined(Random, :TaskLocalRNG) && f == Random.TaskLocalRNG
		global rng = f()
		Random.seed!(s)
	else
		isdefined(Random, :set_global_seed!) && Random.set_global_seed!(s)
		global rng = f(s)
	end
end

"""
Get package version

$(DocumentFunction.documentfunction(pkgversion_old))

Returns:

- package version
"""
function pkgversion_old(modulestr::AbstractString)
	try
		stdoutcaptureon()
		Pkg.status()
		a = stdoutcaptureoff()
		m = match(Regex(string("[ \t]*", modulestr, "[ \t]*v([0-9](.[0-9])+)")), a)
		return VersionNumber(m[1])
	catch
		o = stdoutcaptureoff()
		Mads.madswarn("Module $(modulestr) is not available")
		return v"0.0.0"
	end
end

"""
Checks if package is available

$(DocumentFunction.documentfunction(ispkgavailable_old;
argtext=Dict("modulename"=>"module name")))

Returns:

- `true` or `false`
"""
function ispkgavailable_old(modulename::AbstractString; quiet::Bool=false)
	try
		stdoutcaptureon()
		Pkg.status()
		a = stdoutcaptureoff()
		m = match(Regex(string("[ \t]*(", modulename, ")[ \t]*v([0-9](.[0-9])+)")), a)
		return m[1] == modulename
	catch
		return false
	end
end

"""
Checks if package is available

$(DocumentFunction.documentfunction(ispkgavailable;
argtext=Dict("modulename"=>"module name")))

Returns:

- `true` or `false`
"""
function ispkgavailable(modulename::AbstractString)
	return pkginstalled(modulename)
end

function pkginstalled(modulename::AbstractString)
	found = false
	deps = Pkg.dependencies()
	for (uuid, dep) in deps
		dep.is_direct_dep || continue
		isnothing(dep.version) && continue
		if dep.name == modulename
			found = true
			break
		end
	end
	return found
end

function pkginstalled()
	deps = Pkg.dependencies()
	installs = Dict{String,VersionNumber}()
	for (uuid, dep) in deps
		dep.is_direct_dep || continue
		isnothing(dep.version) && continue
		installs[dep.name] = dep.version
	end
	return installs
end

function merge_dictionaries(a::AbstractDict, b::AbstractDict)
	m = merge(a, b)
	for k in keys(m)
		if haskey(a, k)
			m[k] = merge(m[k], a[k])
		end
		if haskey(b, k)
			m[k] = merge(m[k], b[k])
		end
	end
	return m
end

function nonunique(x::AbstractVector)
	iu = nonunique_indices(x)
	return x[iu]
end

function nonunique_mask(x::AbstractVector)
	return .!unique_mask(x)
end

function nonunique_indices(x::AbstractVector)
	nunique_indices = collect(eachindex(x))
	return nunique_indices[.!unique_mask(x)]
end

function unique_indices(x::AbstractVector)
	return unique(i->x[i], eachindex(x))
end

function unique_mask(x::AbstractVector)
	iunique = unique_indices(x)
	nunique_mask = falses(length(x))
	nunique_mask[iunique] .= true
	return nunique_mask
end