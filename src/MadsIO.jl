import OrderedCollections
import JLD
import JLD2
import FileIO
import XLSX
import CSV
import SHA
import Dates
import DataFrames
import LightXML

mutable struct DATA
	filename::String
	filehash::String
end

function createhash!(DATA::DATA)
	println("File: $(DATA.filename)")
	open(DATA.filename) do f
		hash = SHA.bytes2hex(SHA.sha2_256(f))
		@info("Hash: $(hash)")
		if DATA.filehash == hash
			@info("Hash did not change!")
		else
			@warn("Hash changed!")
			DATA.filehash = hash
		end
	end
end

function checkhash(DATA::DATA)::Bool
	local hash
	open(DATA.filename) do f
		hash = SHA.bytes2hex(SHA.sha2_256(f))
	end
	if hash != DATA.filehash
		@error "File hash for $(DATA.filename) does not match!"
		throw("Error")
		return false
	else
		@info "File hash for $(DATA.filename) matches!"
		return true
	end
end

function load_data(filename::AbstractString)::DataFrames.DataFrame
	if !isfile(filename)
		@warn("File $(filename) does not exist!")
		return DataFrames.DataFrame()
	else
		@info("Load input data: $(filename)")
	end
	e = lowercase(last(splitext(filename)))
	if e == ".csv"
		c = CSV.read(filename, DataFrames.DataFrame)
	elseif e == ".xlsx"
		c = DataFrames.DataFrame(XLSX.readtable(filename, "Sheet1"; stop_in_empty_row=false, header=true))
	elseif e == ".jld"
		c = JLD.load(filename, "data")
	elseif e == ".jld2"
		c = JLD2.load(filename, "data")
	else
		@error("Unknown file type with extension $(e)!")
		return DataFrames.DataFrame()
	end
	return c
end

function save_data(df::DataFrames.DataFrame, filename::AbstractString)::Nothing
	if isfile(filename)
		madsinfo("File $(filename) does exist! It will be overwritten!")
	else
		madsinfo("Save output data: $(filename)")
	end
	e = lowercase(last(splitext(filename)))
	if e == ".csv"
		CSV.write(filename, df)
	elseif e == ".xlsx"
		XLSX.writetable(filename, collect(eachcol(df)), names(df); overwrite=true)
	elseif e == ".jld"
		JLD.save(filename, "data", df)
	elseif e == ".jld2"
		JLD2.save(filename, "data", df)
	else
		@error("Unknown file type with extension $(e)!")
	end
	return nothing
end
function save_data(d::AbstractDict, filename::AbstractString)::Nothing
	df = DataFrames.DataFrame()
	for k in keys(d)
		df[!, Symbol(k)] = d[k]
	end
	save_data(df, filename)
	return nothing
end

"""
Get file names by expanding wildcards

$(DocumentFunction.documentfunction(getfilenames))
"""
function getfilenames(cmdstring::AbstractString)
	readlines(runcmd("ls " * cmdstring; quiet=true, pipe=true)[2])
end

"""
Change the current directory to the Mads source dictionary

$(DocumentFunction.documentfunction(madsdir))
"""
function madsdir()
	Base.cd(Mads.dir)
	return pwd()
end

function splitdirdot(d)
	r, f = splitdir(d)
	r = r == "" ? "." : r
	return r, f
end

"""
Load MADS input file defining a MADS problem dictionary

$(DocumentFunction.documentfunction(loadmadsfile;
argtext=Dict("filename"=>"input file name (e.g. `input_file_name.mads`)"),
keytext=Dict("julia"=>"if `true`, force using `julia` parsing functions; if `false` (default), use `python` parsing functions",
             "format"=>"acceptable formats are `yaml` and `json` [default=`yaml`]")))

Returns:

- MADS problem dictionary

Example:

```julia
md = Mads.loadmadsfile("input_file_name.mads")
```
"""
function loadmadsfile(filename::AbstractString; bigfile::Bool=false, format::AbstractString="yaml", quiet::Bool=false)
	if bigfile
		madsdata = loadbigyamlfile(filename)
	end
	if !bigfile || isnothing(madsdata)
		if format == "yaml"
			madsdata = loadyamlfile(filename)
		elseif format == "json"
			madsdata = loadjsonfile(filename)
		end
	end
	while typeof(madsdata) <: AbstractString # Windows links fix
		filename = joinpath(splitdir(filename)[1], madsdata)
		if format == "yaml"
			madsdata = loadyamlfile(filename)
		elseif format == "json"
			madsdata = loadjsonfile(filename)
		end
	end
	madsdata["Filename"] = filename
	parsemadsdata!(madsdata)
	if haskey(madsdata, "Observations")
		t = getobstarget(madsdata)
		isn = isnan.(t)
		if any(isn) && !quiet
			l = length(isn[isn.==true])
			if l == 1
				Mads.madswarn("There is 1 observation with a missing target!")
			else
				Mads.madswarn("There are $(l) observations with missing targets!")
			end
		end
	end
	if haskey(madsdata, "Julia function")
		fn = Symbol(madsdata["Julia function"])
		if isdefined(Main, fn)
			@info("Main version of $(fn) will be used ...")
		elseif isdefined(Mads, fn)
			@info("Mads version of $(fn) will be used ...")
		elseif isdefined(Mads, fn)
			@info("Mads version of $(fn) will be used ...")
		else
			madswarn("Julia function $(fn) is not defined!")
		end
	end
	return convert(Dict{String,Any}, madsdata)
end

"""
Load BIG YAML input file

$(DocumentFunction.documentfunction(loadmadsfile;
argtext=Dict("filename"=>"input file name (e.g. `input_file_name.mads`)")))

Returns:

- MADS problem dictionary
"""
function loadbigyamlfile(filename::AbstractString)
	lines = readlines(filename)
	nlines = length(lines)
	keyln = findall((in)(true), map(i->(match(r"^[A-Z]", lines[i]) !== nothing), 1:nlines))
	if length(keyln) == 0
		return nothing
	end
	obsia = indexin(["Observations:"], strip.(lines[keyln]))
	if length(obsia) == 0
		return nothing
	else
		obsi = obsia[1]
		obsln = keyln[obsi]
	end
	readflag = true
	yamlflag = true
	if obsln != 1 && obsln != nlines && obsi < length(keyln)
		parseindeces = vcat(collect(1:obsln-1), collect(keyln[obsi+1]:nlines))
		readindeces = obsln+1:keyln[obsi+1]-1
	elseif obsln == 1 && obsi < length(keyln)
		parseindeces = keyln[obsi+1]:nlines
		readindeces = 2:keyln[obsi+1]-1
	elseif obsln == nlines
		parseindeces = 1:obsln-1
		readindeces = obsln+1:nlines
	elseif length(keyln) == 1
		parseindeces = 0:0
		yamlflag = false
		readindeces = 1:nlines
	else
		parseindeces = 1:nlines
		readindeces = 0:0
		readflag = false
	end
	if readflag
		obsdict = OrderedCollections.OrderedDict{String,Any}()
		t = []
		badlines = Array{Int}(undef, 0)
		for i in readindeces
			mc = match(r"^- (\S*):.*", lines[i])
			if !isnothing(mc)
				kw = mc.captures[1]
			else
				push!(badlines, i)
				continue
			end
			if occursin("filename", kw)
				readflag = false
				yamlflag = true
				parseindeces = 1:nlines
				break
			end
			obsdict[kw] = OrderedCollections.OrderedDict{String,Any}()
			mc = match(r"^.*target[\"]?:[\s]*?([-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?).*", lines[i])
			if !isnothing(mc)
				obsdict[kw]["target"] = parse(Float64, mc.captures[1])
			end
			mc = match(r"^.*weight[\"]?:[\s]*?([-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?).*", lines[i])
			if !isnothing(mc)
				obsdict[kw]["weight"] = parse(Float64, mc.captures[1])
			end
			mc = match(r"^.*min[\"]?:[\s]*?([-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?).*", lines[i])
			if !isnothing(mc)
				obsdict[kw]["min"] = parse(Float64, mc.captures[1])
			end
			mc = match(r"^.*max[\"]?:[\s]*?([-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?).*", lines[i])
			if !isnothing(mc)
				obsdict[kw]["max"] = parse(Float64, mc.captures[1])
			end
		end
	end
	if yamlflag
		io = IOBuffer(join(lines[parseindeces], '\n'))
		madsdata = YAML.load(io)
	else
		madsdata = OrderedCollections.OrderedDict{String,Any}()
	end
	if readflag
		madsdata["Observations"] = obsdict
	end
	return madsdata
end

"""
Parse loaded MADS problem dictionary

$(DocumentFunction.documentfunction(parsemadsdata!;
argtext=Dict("madsdata"=>"MADS problem dictionary")))
"""
function parsemadsdata!(madsdata::AbstractDict)
	madsproblemdir = Mads.getmadsproblemdir(madsdata)
	if haskey(madsdata, "Parameters")
		parameters = OrderedCollections.OrderedDict{String,OrderedCollections.OrderedDict}()
		for dict in madsdata["Parameters"]
			for key in keys(dict)
				if !haskey(dict[key], "exp") # it is a real parameter, not an expression
					parameters[key] = OrderedCollections.OrderedDict{String,Any}()
					for pf in keys(dict[key])
						parameters[key][pf] = dict[key][pf]
					end
				else
					if !haskey(madsdata, "Expressions")
						madsdata["Expressions"] = OrderedCollections.OrderedDict{String,OrderedCollections.OrderedDict}()
					end
					madsdata["Expressions"][key] = OrderedCollections.OrderedDict{String,Any}()
					for pf in keys(dict[key])
						madsdata["Expressions"][key][pf] = dict[key][pf]
					end
				end
			end
		end
		madsdata["Parameters"] = parameters
	end
	addsourceparameters!(madsdata)
	if haskey(madsdata, "Parameters")
		parameters = madsdata["Parameters"]
		for key in keys(parameters)
			if !haskey(parameters[key], "init") && !haskey(parameters[key], "exp")
				Mads.madserror("""Parameter `$key` does not have initial value; add "init" value!""")
			end
			for v in ["init", "init_max", "init_min", "max", "min", "step"]
				if haskey(parameters[key], v)
					if typeof(parameters[key][v]) <: AbstractString
						parameters[key][v] = parse(Float64, parameters[key][v])
					elseif typeof(parameters[key][v]) <: Number
						parameters[key][v] = float(parameters[key][v])
					end
				end
			end
			if haskey(parameters[key], "log")
				flag = parameters[key]["log"]
				if flag == "yes" || flag == true
					parameters[key]["log"] = true
					for v in ["init", "init_max", "init_min", "max", "min", "step"]
						if haskey(parameters[key], v)
							if parameters[key][v] < 0
								Mads.madserror("""The value $v for Parameter $key cannot be log-transformed; it is negative!""")
							end
						end
					end
				else
					parameters[key]["log"] = false
				end
			end
		end
	end
	checkparameterranges(madsdata)
	if haskey(madsdata, "Wells")
		wells = OrderedCollections.OrderedDict{String,Any}()
		for dict in madsdata["Wells"]
			if collect(keys(dict))[1] == "filename"
				dictnew = loadmadsfile(joinpath(madsproblemdir, collect(values(dict))[1]), bigfile=true)["Wells"]
			elseif collect(keys(dict))[1] == "script"
				dictnew = include(collect(values(dict))[1])
			else
				dictnew = dict
			end
			for key in keys(dictnew)
				wells[key] = dict[key]
				wells[key]["on"] = true
				if haskey(wells[key], "obs") && !isnothing(wells[key]["obs"])
					for i = eachindex(wells[key]["obs"])
						for k in keys(wells[key]["obs"][i])
							wells[key]["obs"][i] = wells[key]["obs"][i][k]
						end
					end
				end
			end
		end
		madsdata["Wells"] = wells
		Mads.wells2observations!(madsdata)
	elseif haskey(madsdata, "Observations") # TODO drop zero weight observations
		if typeof(madsdata["Observations"]) <: Array
			observations = OrderedCollections.OrderedDict{String,OrderedCollections.OrderedDict}()
			for dict in madsdata["Observations"]
				if collect(keys(dict))[1] == "filename"
					dictnew = loadmadsfile(joinpath(madsproblemdir, collect(values(dict))[1]), bigfile=true)["Observations"]
				elseif collect(keys(dict))[1] == "script"
					dictnew = include(collect(values(dict))[1])
				else
					dictnew = dict
				end
				for key in keys(dictnew)
					observations[key] = OrderedCollections.OrderedDict{String,Any}()
					for of in keys(dictnew[key])
						observations[key][of] = dictnew[key][of]
					end
				end
			end
			madsdata["Observations"] = observations
		end
	end
	if haskey(madsdata, "Templates")
		templates = Array{AbstractDict}(undef, length(madsdata["Templates"]))
		i = 1
		for dict in madsdata["Templates"]
			for key in keys(dict)
				templates[i] = dict[key]
				filename = joinpath(madsproblemdir, templates[i]["tpl"])
				if isfile(filename)
					tplfile = open(filename)
					line = readline(tplfile)
					if length(line) >= 10 && line[1:9] == "template "
						separator = line[10]
						if separator == '$'
							Mads.madserror("Template file $filename separator cannot be \$!")
						end
					end
					close(tplfile)
				else
					Mads.madswarn("Template file $filename is missing!")
				end
			end
			i += 1
		end
		madsdata["Templates"] = templates
	end
	if haskey(madsdata, "Instructions")
		instructions = Array{AbstractDict}(undef, length(madsdata["Instructions"]))
		i = 1
		for dict in madsdata["Instructions"]
			for key in keys(dict)
				instructions[i] = dict[key]
			end
			i += 1
		end
		madsdata["Instructions"] = instructions
	end
	if haskey(madsdata, "Setup")
		include(values(madsdata["Setup"]))
	end
end

function savemadsfile(madsdata::AbstractDict, filename::AbstractString=""; observations_separate::Bool=false, filenameobs=getrootname(filename; version=true) * "-observations.yaml")
	if filename == ""
		filename = setnewmadsfilename(madsdata)
	end
	if observations_separate
		madsdata2 = deepcopy(madsdata)
		if !isfile(filenameobs)
			printobservations(madsdata, filenameobs)
		else
			Mads.madswarn("External observation file already exist ($(filenameobs)); delete if needed!")
		end
		madsdata2["Observations"] = Dict{String,String}("filename"=>filenameobs)
	else
		madsdata2 = madsdata
	end
	dumpyamlmadsfile(madsdata2, filename)
end
function savemadsfile(madsdata::AbstractDict, parameters::AbstractDict, filename::AbstractString=""; explicit::Bool=false, observations_separate::Bool=false)
	if filename == ""
		filename = setnewmadsfilename(madsdata)
	end
	if explicit
		madsdata2 = loadyamlfile(madsdata["Filename"])
		for i = eachindex(madsdata2["Parameters"])
			pdict = madsdata2["Parameters"][i]
			paramname = collect(keys(pdict))[1]
			realparam = pdict[paramname]
			if haskey(realparam, "type") && realparam["type"] == "opt"
				oldinit = realparam["init"]
				realparam["init"] = parameters[paramname]
				newinit = realparam["init"]
			end
		end
		if observations_separate
			filenameobs = getrootname(filename; version=true) * "-observations.yaml"
			printobservations(madsdata, filenameobs)
			madsdata2["Observations"] = Dict{String,String}("filename"=>filenameobs)
		end
		dumpyamlfile(filename, madsdata2)
	else
		madsdata2 = deepcopy(madsdata)
		setparamsinit!(madsdata2, parameters)
		if observations_separate
			filenameobs = getrootname(filename; version=true) * "-observations.yaml"
			printobservations(madsdata, filenameobs)
			madsdata2["Observations"] = Dict{String,String}("filename"=>filenameobs)
		end
		dumpyamlmadsfile(madsdata2, filename)
	end
end

@doc """
Save MADS problem dictionary `madsdata` in MADS input file `filename`

$(DocumentFunction.documentfunction(savemadsfile;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "parameters"=>"Dictionary with parameters (optional)",
            "filename"=>"input file name (e.g. `input_file_name.mads`)"),
keytext=Dict("julia"=>"if `true` use Julia JSON module to save [default=`false`]",
            "explicit"=>"if `true` ignores MADS YAML file modifications and rereads the original input file [default=`false`]")))

Example:

```julia
Mads.savemadsfile(madsdata)
Mads.savemadsfile(madsdata, "test.mads")
Mads.savemadsfile(madsdata, parameters, "test.mads")
Mads.savemadsfile(madsdata, parameters, "test.mads", explicit=true)
```
""" savemadsfile

"""
Set a default MADS input file

$(DocumentFunction.documentfunction(setmadsinputfile;
argtext=Dict("filename"=>"input file name (e.g. `input_file_name.mads`)")))
"""
function setmadsinputfile(filename::AbstractString)
	global madsinputfile = filename
end

"""
Get the default MADS input file set as a MADS global variable using `setmadsinputfile(filename)`

$(DocumentFunction.documentfunction(getmadsinputfile))

Returns:

- input file name (e.g. `input_file_name.mads`)
"""
function getmadsinputfile()
	return madsinputfile
end

"""
Get the MADS problem root name

$(DocumentFunction.documentfunction(getmadsrootname;
argtext=Dict("madsdata"=>"MADS problem dictionary"),
keytext=Dict("first"=>"use the first . in filename as the seperator between root name and extention [default=`true`]",
            "version"=>"delete version information from filename for the returned rootname [default=`false`]")))

Example:

```julia
madsrootname = Mads.getmadsrootname(madsdata)
```

Returns:

- root of file name
"""
function getmadsrootname(madsdata::AbstractDict; first=true, version=false)
	if haskey(madsdata, "Filename")
		madsrootname = getrootname(madsdata["Filename"]; first=first, version=version)
	else
		madsrootname = ""
	end
	return madsrootname
end

"""
Get directory

$(DocumentFunction.documentfunction(getdir;
argtext=Dict("filename"=>"file name")))

Returns:

- directory in file name

Example:

```julia
d = Mads.getdir("a.mads") # d = "."
d = Mads.getdir("test/a.mads") # d = "test"
```
"""
function getdir(filename::AbstractString)
	d = dirname(filename)
	if d == ""
		d = "."
	end
	return d
end

"""
Get the directory where the Mads data file is located

$(DocumentFunction.documentfunction(getmadsproblemdir;
argtext=Dict("madsdata"=>"MADS problem dictionary")))

Example:

```julia
madsdata = Mads.loadmadsfile("../../a.mads")
madsproblemdir = Mads.getmadsproblemdir(madsdata)
```

where `madsproblemdir` = `"../../"`
"""
function getmadsproblemdir(madsdata::AbstractDict)
	if haskey(madsdata, "Filename")
		getdir(madsdata["Filename"])
	else
		return "."
	end
end

"""
Get the directory where currently Mads is running

$(DocumentFunction.documentfunction(getproblemdir))

Example:

```julia
problemdir = Mads.getproblemdir()
```

Returns:

- Mads problem directory
"""
function getproblemdir()
	source_path = Base.source_path()
	if isnothing(source_path)
		problemdir = "."
	elseif source_path == ""
		problemdir = Base.pkgdir(Mads)

	else
		problemdir = first(splitdir(source_path))
	end
	madsinfo("Problem directory: $(problemdir)")
	return problemdir
end

"""
Get file name root

$(DocumentFunction.documentfunction(getrootname;
argtext=Dict("filename"=>"file name"),
keytext=Dict("first"=>"use the first . in filename as the seperator between root name and extention [default=`true`]",
            "version"=>"delete version information from filename for the returned rootname [default=`false`]")))

Returns:

- root of file name

Example:

```julia
r = Mads.getrootname("a.rnd.dat") # r = "a"
r = Mads.getrootname("a.rnd.dat", first=false) # r = "a.rnd"
```
"""
function getrootname(filename::AbstractString; first::Bool=true, version::Bool=false)
	d = splitdir(filename)
	s = split(d[2], ".")
	if !first && length(s) > 1
		r = join(s[1:end-1], ".")
	else
		r = s[1]
	end
	if version
		if occursin(r"-v[0-9].$", r)
			rm = match(r"-v[0-9].$", r)
			r = r[1:rm.offset-1]
		elseif occursin(r"-rerun$", r)
			rm = match(r"-rerun$", r)
			r = r[1:rm.offset-1]
		end
	end
	if length(d) > 1
		r = joinpath(d[1], r)
	end
	return r
end

function setnewmadsfilename(madsdata::AbstractDict)
	setnewmadsfilename(madsdata["Filename"])
end
function setnewmadsfilename(filename::AbstractString)
	dir = getdir(filename)
	root = splitdir(getrootname(filename))[end]
	if occursin(r"-v[0-9]*$", root)
		rm = match(r"-v([0-9]*)$", root)
		v = Base.parse(Int, rm.captures[1]) + 1
		l = length(rm.captures[1])
		f = "%0" * string(l) * "d"
		filename = "$(root[1:rm.offset-1])-v$(sprintf(f, v)).mads"
	else
		filename = "$(root)-rerun.mads"
	end
	return joinpath(dir, filename)
end

@doc """
Set new mads file name

$(DocumentFunction.documentfunction(setnewmadsfilename;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "filename"=>"file name")))

Returns:

- new file name
""" setnewmadsfilename

"""
Get next mads file name

$(DocumentFunction.documentfunction(getnextmadsfilename;
argtext=Dict("filename"=>"file name")))

Returns:

- next mads file name
"""
function getnextmadsfilename(filename::AbstractString)
	t0 = 0
	filename_old = filename
	while isfile(filename)
		t = mtime(filename)
		if t < t0
			filename = filename_old
			break
		else
			t0 = t
			filename_old = filename
			filename = setnewmadsfilename(filename_old)
			if !isfile(filename)
				filename = filename_old
				break
			end
		end
	end
	return filename
end

"""
Get file name extension

$(DocumentFunction.documentfunction(getextension;
argtext=Dict("filename"=>"file name")))

Returns:

- file name extension

Example:

```julia
ext = Mads.getextension("a.mads") # ext = "mads"
```
"""
function getextension(filename::AbstractString)
	d = splitdir(filename)
	s = split(d[2], ".")
	if length(s) > 1
		return s[end]
	else
		return ""
	end
end

"""
Check the directories where model outputs should be saved for MADS

$(DocumentFunction.documentfunction(checkmodeloutputdirs;
argtext=Dict("madsdata"=>"MADS problem dictionary")))

Returns:

- true or false
"""
function checkmodeloutputdirs(madsdata::AbstractDict)
	directories = Array{String}(undef, 0)
	if haskey(madsdata, "Instructions")
		for instruction in madsdata["Instructions"]
			filename = instruction["read"]
			push!(directories, getdir(filename))
		end
	end
	if haskey(madsdata, "JLDPredictions")
		for filename in vcat(madsdata["JLDPredictions"])
			push!(directories, getdir(filename))
		end
	end
	if haskey(madsdata, "JLD2Predictions")
		for filename in vcat(madsdata["JLD2Predictions"])
			push!(directories, getdir(filename))
		end
	end
	if haskey(madsdata, "JSONPredictions")
		for filename in vcat(madsdata["JSONPredictions"])
			push!(directories, getdir(filename))
		end
	end
	if haskey(madsdata, "YAMLPredictions")
		for filename in vcat(madsdata["YAMLPredictions"])
			push!(directories, getdir(filename))
		end
	end
	if haskey(madsdata, "ASCIIPredictions")
		for filename in vcat(madsdata["ASCIIPredictions"])
			push!(directories, getdir(filename))
		end
	end
	if haskey(madsdata, "Linked directory
		") && madsdata["Linked directory"] == true
		push!(directories, ".")
	end
	d = unique(directories)
	nd = length(directories)
	if nd == 0
		return true
	elseif nd == 1 && d[1] == "."
		return true
	else
		return false
	end
end

"""
Set model input files; delete files where model output should be saved for MADS

$(DocumentFunction.documentfunction(setmodelinputs;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "parameters"=>"parameters"),
keytext=Dict("path"=>"path for the files [default=`.`]")))
"""
function setmodelinputs(madsdata::AbstractDict, parameters::AbstractDict=Mads.getparamdict(madsdata); path::AbstractString=".")
	errorflag = false
	boundparameters!(madsdata, parameters)
	if haskey(madsdata, "Instructions")
		for instruction in madsdata["Instructions"]
			filename = instruction["ins"]
			if !isfile(filename)
				Mads.madswarn("Instruction file $filename is missing!"); errorflag = true
			end
			Mads.rmfile(instruction["read"], path=path)
		end
	end
	if haskey(madsdata, "Templates")
		for template in madsdata["Templates"]
			filename = template["tpl"]
			if !isfile(filename)
				Mads.madswarn("Template file $filename is missing!"); errorflag = true
			end
			Mads.rmfile(template["write"], path=path)
		end
		writeparameters(madsdata, parameters)
	end
	#TODO move the writing into the "writeparameters" function
	if haskey(madsdata, "JLDParameters")
		for filename in vcat(madsdata["JLDParameters"])
			Mads.rmfile(filename, path=path)
		end
		FileIO.save(madsdata["JLDParameters"], parameters)
	end
	if haskey(madsdata, "JLDPredictions")
		for filename in vcat(madsdata["JLDPredictions"])
			Mads.rmfile(filename, path=path)
		end
	end
	if haskey(madsdata, "JLD2Parameters")
		for filename in vcat(madsdata["JLD2Parameters"])
			Mads.rmfile(filename, path=path)
		end
		FileIO.save(madsdata["JLD2Parameters"], parameters)
	end
	if haskey(madsdata, "JLD2Predictions")
		for filename in vcat(madsdata["JLD2Predictions"])
			Mads.rmfile(filename, path=path)
		end
	end
	if haskey(madsdata, "JSONParameters")
		for filename in vcat(madsdata["JSONParameters"])
			Mads.rmfile(filename, path=path)
		end
		dumpjsonfile(madsdata["JSONParameters"], parameters)
	end
	if haskey(madsdata, "JSONPredictions")
		for filename in vcat(madsdata["JSONPredictions"])
			Mads.rmfile(filename, path=path)
		end
	end
	if haskey(madsdata, "YAMLParameters")
		for filename in vcat(madsdata["YAMLParameters"])
			Mads.rmfile(filename, path=path)
		end
		dumpyamlfile(joinpath(path, madsdata["YAMLParameters"]), parameters)
	end
	if haskey(madsdata, "YAMLPredictions")
		for filename in vcat(madsdata["YAMLPredictions"])
			Mads.rmfile(filename, path=path)
		end
	end
	if haskey(madsdata, "ASCIIParameters")
		filename = madsdata["ASCIIParameters"]
		Mads.rmfile(filename, path=path)
		#TODO this does NOT work; `parameters` are not required to be Ordered Dictionary
		dumpasciifile(joinpath(path, filename), values(parameters))
	end
	if haskey(madsdata, "ASCIIPredictions")
		for filename in vcat(madsdata["ASCIIPredictions"])
			Mads.rmfile(filename, path=path)
		end
	end
	errorflag && madscritical("There are missing files!")
end

"""
Read model outputs saved for MADS

$(DocumentFunction.documentfunction(readmodeloutput;
argtext=Dict("madsdata"=>"MADS problem dictionary"),
keytext=Dict("obskeys"=>"observation keys [default=getobskeys(madsdata)]")))
"""
function readmodeloutput(madsdata::AbstractDict; obskeys::AbstractVector=getobskeys(madsdata))
	results = OrderedCollections.OrderedDict{String,Float64}()
	if haskey(madsdata, "Instructions")
		results = readobservations(madsdata, obskeys)
	end
	if haskey(madsdata, "JLDPredictions")
		for filename in vcat(madsdata["JLDPredictions"])
			results = merge(results, FileIO.load(filename))
		end
	end
	if haskey(madsdata, "JLD2Predictions")
		for filename in vcat(madsdata["JLD2Predictions"])
			results = merge(results, FileIO.load(filename))
		end
	end
	if haskey(madsdata, "JSONPredictions")
		for filename in vcat(madsdata["JSONPredictions"])
			results = merge(results, loadjsonfile(filename))
		end
	end
	if haskey(madsdata, "YAMLPredictions")
		for filename in vcat(madsdata["YAMLPredictions"])
			results = merge(results, loadyamlfile(filename))
		end
	end
	if haskey(madsdata, "ASCIIPredictions")
		predictions = loadasciifile(madsdata["ASCIIPredictions"])
		obsid=[convert(String,k) for k in obskeys]
		@assert length(obskeys) == length(predictions)
		results = merge(results, OrderedCollections.OrderedDict{String,Float64}(zip(obsid, predictions)))
	end
	missingkeys = Array{String}(undef, 0)
	validtargets = (Mads.getobsweight(madsdata) .> 0) .& .!isnan.(Mads.getobstarget(madsdata))
	for (k, v) in zip(obskeys, validtargets)
		if !haskey(results, k) && v
			push!(missingkeys, k)
		end
	end
	if length(missingkeys) > 0
		madswarn("Observations are missing (total count = $(length(missingkeys)))!")
		madscritical("Missing observation keys: $(missingkeys)")
	end
	return convert(OrderedCollections.OrderedDict{String,Float64}, results)
end

searchdir(key::Regex; path::AbstractString = ".") = filter(x->occursin(key, x), readdir(path))
searchdir(key::AbstractString; path::AbstractString = ".") = filter(x->occursin(key, x), readdir(path))

@doc """
Get files in the current directory or in a directory defined by `path` matching pattern `key` which can be a string or regular expression

$(DocumentFunction.documentfunction(searchdir;
argtext=Dict("key"=>"matching pattern for Mads input files (string or regular expression accepted)"),
keytext=Dict("path"=>"search directory for the mads input files [default=`.`]")))

Returns:

- `filename` : an array with file names matching the pattern in the specified directory

Examples:

```julia
- `Mads.searchdir("a")`
- `Mads.searchdir(r"[A-B]"; path = ".")`
- `Mads.searchdir(r".*.cov"; path = ".")`
```
""" searchdir

filterkeys(dict::AbstractDict, key::Regex) = key == r"" ? collect(keys(dict)) : filter(x->occursin(key, x), collect(keys(dict)))
filterkeys(dict::AbstractDict, key::AbstractString = "") = key == "" ? collect(keys(dict)) : filter(x->occursin(key, x), collect(keys(dict)))

@doc """
Filter dictionary keys based on a string or regular expression

$(DocumentFunction.documentfunction(filterkeys;
argtext=Dict("dict"=>"dictionary",
            "key"=>"the regular expression or string used to filter dictionary keys")))
""" filterkeys

indexkeys(dict::AbstractDict, key::Regex) = key == r"" ? findall(collect(keys(dict))) : findall(x->occursin(key, x), collect(keys(dict)))
indexkeys(dict::AbstractDict, key::AbstractString = "") = key == "" ? findall(collect(keys(dict))) : findall(x->occursin(key, x), collect(keys(dict)))

@doc """
Find indexes for dictionary keys based on a string or regular expression

$(DocumentFunction.documentfunction(indexkeys;
argtext=Dict("dict"=>"dictionary",
            "key"=>"the key to find index for")))
""" indexkeys

getdictvalues(dict::AbstractDict, key::Regex) = map(y->(y, dict[y]), filterkeys(dict, key))
getdictvalues(dict::AbstractDict, key::AbstractString = "") = map(y->(y, dict[y]), filterkeys(dict, key))

@doc """
Get dictionary values for keys based on a string or regular expression

$(DocumentFunction.documentfunction(getdictvalues;
argtext=Dict("dict"=>"dictionary",
             "key"=>"the key to find value for")))
""" getdictvalues

"""
Write `parameters` via MADS template (`templatefilename`) to an output file (`outputfilename`)

$(DocumentFunction.documentfunction(writeparametersviatemplate;
argtext=Dict("parameters"=>"parameters",
            "templatefilename"=>"tmplate file name",
            "outputfilename"=>"output file name"),
keytext=Dict("respect_space"=>"respect provided space in the template file to fit model parameters [default=`false`]")))
"""
function writeparametersviatemplate(parameters, templatefilename, outputfilename; respect_space::Bool=false)
	tplfile = open(templatefilename)
	line = readline(tplfile)
	if isfile(line)
		tplfile = open(line)
		line = readline(tplfile)
	end
	if length(line) >= 10 && line[1:9] == "template "
		separator = line[10]
		if separator == '$'
			madserror("Template separator cannot be \$")
		end
		lines = readlines(tplfile)
	else
		separator = '#'
		lines = [line; readlines(tplfile)]
	end
	close(tplfile)
	emptyline = 0
	outfile = open(outputfilename, "w")
	for line in lines
		splitline = split(line, separator) # two separators are needed for each parameter
		if rem(length(splitline), 2) != 1
			error("The number of separators (\"$separator\") is not even in template file $templatefilename on line:\n$line")
		elseif length(splitline) == 1
			emptyline += 1
		end
		for i = 1:div(length(splitline)-1, 2)
			write(outfile, splitline[2 * i - 1]) # write the text before the parameter separator
			varname = strip(splitline[2 * i])
			if respect_space
				l = length(splitline[2 * i])
				s = Mads.sprintf("%.$(l)g", parameters[varname])
			else
				s = string(parameters[varname])
			end
			write(outfile, s)
			madsinfo("Replacing " * varname * " -> " * s, 1)
		end
		write(outfile, splitline[end]) # write the rest of the line after the last separator
		write(outfile, "\n")
	end
	close(outfile)
	if emptyline == length(lines)
		madswarn("No parameters found in template file $templatefilename")
	end
end

"""
Write model `parameters`

$(DocumentFunction.documentfunction(writeparameters;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "parameters"=>"parameters"),
keytext=Dict("respect_space"=>"respect provided space in the template file to fit model parameters [default=`false`]")))
"""
function writeparameters(madsdata::AbstractDict, parameters::AbstractDict=Mads.getparamdict(madsdata); respect_space=false)
	paramsandexps = evaluatemadsexpressions(madsdata, parameters)
	respect_space = Mads.haskeyword(madsdata, "respect_space")
	changedir = false
	if haskey(madsdata, "Templates")
		for template in madsdata["Templates"]
			if !isfile(template["tpl"])
				cwd = pwd()
				cd(Mads.getmadsproblemdir(madsdata))
				changedir = true
			end
			writeparametersviatemplate(paramsandexps, template["tpl"], template["write"]; respect_space=respect_space)
			if changedir
				cd(cwd)
				changedir = false
			end
		end
	end
end

"""
Convert an instruction line in the Mads instruction file into regular expressions

$(DocumentFunction.documentfunction(instline2regexs;
argtext=Dict("instline"=>"instruction line")))

Returns:

- `regexs` : regular expressions
- `obsnames` : observation names
- `getparamhere` : parameters
"""
function instline2regexs(instline::AbstractString)
	floatregex = r"\h*[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?"
	regex = r"@[^@]*@|w|![^!]*!"
	offset = 1
	regexs = Regex[]
	obsnames = String[]
	getparamhere = Bool[]
	while offset <= length(instline) && occursin(regex, instline; offset=offset - 1) # this may be a julia bug -- offset for ismatch and match seem to be based on zero vs. one indexing
		m = match(regex, instline, offset)
		if isnothing(m)
			Mads.madserror("match not found for instruction line:\n$instline\nnear \"$(instline[offset:end])\"")
		end
		offset = m.offset + length(m.match)
		if m.match[1] == '@'
			if isspace(m.match[end - 1])
				push!(regexs, Regex(string("\\h*", m.match[2:end - 1])))
			else
				push!(regexs, Regex(string("\\h*", m.match[2:end - 1], "[^\\s]*")))
			end
			push!(getparamhere, false)
		elseif m.match[1] == '!'
			push!(regexs, floatregex)
			if m.match[2:end - 1] != "dum"
				push!(obsnames, m.match[2:end - 1])
				push!(getparamhere, true)
			else
				push!(getparamhere, false)
			end
		elseif m.match == "w"
			push!(regexs, r"\h+")
			push!(getparamhere, false)
		else
			Mads.madserror("Unknown instruction file instruction: $(m.match)")
		end
	end
	return regexs, obsnames, getparamhere
end

"""
Match an instruction line in the Mads instruction file with model input file

$(DocumentFunction.documentfunction(obslineoccursin;
argtext=Dict("obsline"=>"instruction line",
            "regexs"=>"regular expressions")))

Returns:

- true or false
"""
function obslineoccursin(obsline::AbstractString, regexs::Vector{Regex})
	if length(regexs) == 0
		return false
	end
	bigregex = Regex(string(map(x->x.pattern, regexs)...))
	return occursin(bigregex, obsline)
end

"""
Get observations for a set of regular expressions

$(DocumentFunction.documentfunction(regexs2obs;
argtext=Dict("obsline"=>"observation line",
            "regexs"=>"regular expressions",
            "obsnames"=>"observation names",
            "getparamhere"=>"parameters")))

Returns:

- `obsdict` : observations
"""
function regexs2obs(obsline::AbstractString, regexs::Vector{Regex}, obsnames::Vector{String}, getparamhere::Vector{Bool})
	offset = 1
	obsnameindex = 1
	obsdict = Dict{String, Float64}()
	for i = eachindex(regexs)
		m = match(regexs[i], obsline, offset)
		if isnothing(m)
			Mads.madserror("match not found for $(regexs[i]) in observation line: $(strip(obsline)) (\"$(strip(obsline[offset:end]))\")")
		else
			if getparamhere[i]
				obsdict[obsnames[obsnameindex]] = Base.parse(Float64, m.match)
				obsnameindex += 1
			end
		end
		offset = m.offset + length(m.match)
	end
	return obsdict
end

"""
Apply Mads instruction file `instructionfilename` to read model output file `modeloutputfilename`

$(DocumentFunction.documentfunction(ins_obs;
argtext=Dict("instructionfilename"=>"instruction file name",
            "modeloutputfilename"=>"model output file name")))

Returns:

- `obsdict` : observation dictionary with the model outputs
"""
function ins_obs(instructionfilename::AbstractString, modeloutputfilename::AbstractString)
	if !isfile(modeloutputfilename)
		throw("File $modeloutputfilename is missing!")
		return nothing
	end
	instfile = open(instructionfilename, "r")
	line = readline(instfile)
	if length(line) < 80 && isfile(line)
		close(instfile)
		instfile = open(line, "r")
	else
		close(instfile)
		instfile = open(instructionfilename, "r")
	end
	obsfile = open(modeloutputfilename, "r")
	obslineitr = eachline(obsfile)
	iter_result = iterate(obslineitr)
	obsline, state = iter_result
	obsdict = OrderedCollections.OrderedDict{String, Float64}()
	for instline in eachline(instfile)
		if length(instline) == 0
			iter_result = iterate(obslineitr, state)
			obsline, state = iter_result
			continue
		elseif instline[1] == 'l'
			l = 1
			try
				l = Base.parse(Int, instline[2:end])
			catch
			end
			for i = 1:l
				iter_result = iterate(obslineitr, state)
				obsline, state = iter_result
			end
			continue
		end
		regexs, obsnames, getparamhere = instline2regexs(instline)
		if length(regexs) == 0
			continue
		end
		gotmatch = false
		while !gotmatch && !isnothing(iter_result)
			obsline, state = iter_result
			if obslineoccursin(obsline, regexs)
				merge!(obsdict, regexs2obs(obsline, regexs, obsnames, getparamhere))
				gotmatch = true
			end
			iter_result = iterate(obslineitr, state)
		end
		if !gotmatch
			Mads.madserror("Did not get a match for instruction file ($instructionfilename) line:\n$instline")
		end
	end
	close(instfile)
	close(obsfile)
	return obsdict
end

"""
Read observations

$(DocumentFunction.documentfunction(readobservations;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "obskeys"=>"observation keys [default=`getobskeys(madsdata)`]")))

Returns:

- dictionary with Mads observations
"""
function readobservations(madsdata::AbstractDict, obskeys::AbstractVector=getobskeys(madsdata))
	dictelements = zip(obskeys, zeros(Int, length(obskeys)))
	observations = OrderedCollections.OrderedDict{String,Float64}(dictelements)
	obscount = OrderedCollections.OrderedDict{String,Int}()
	for instruction in madsdata["Instructions"]
		obs = ins_obs(instruction["ins"], instruction["read"])
		for k in keys(obs)
			obscount[k] = 0
		end
		for k in keys(obs)
			obscount[k] += 1
			observations[k] = obscount[k] > 1 ? observations[k] + obs[k] : obs[k]
		end
	end
	c = 0
	for k in obskeys
		c += 1
		if obscount[k] == 0
			delete!(observations, k)
		elseif obscount[k] > 1
			observations[k] /= obscount[k]
			madsinfo("Observation $k detected $(obscount[k]) times; an average is computed")
		end
	end
	return observations
end

"""
Dump well data from MADS problem dictionary into a ASCII file

$(DocumentFunction.documentfunction(dumpwelldata;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "filename"=>"output file name")))

Dumps:

- `filename` : a ASCII file
"""
function dumpwelldata(madsdata::AbstractDict, filename::AbstractString)
	if haskey(madsdata, "Wells")
		outfile = open(filename, "w")
		write(outfile, "well_name, x_coord [m], x_coord [m], z_coord [m], time [years], concentration [ppb]\n")
		for n in keys(madsdata["Wells"])
			x = madsdata["Wells"]["$n"]["x"]
			y = madsdata["Wells"]["$n"]["y"]
			z0 = madsdata["Wells"]["$n"]["z0"]
			z1 = madsdata["Wells"]["$n"]["z1"]
			o = madsdata["Wells"]["$n"]["obs"]
			for i = eachindex(o)
				c = o[i]["c"]
				t = o[i]["t"]
				write(outfile, "$n, $x, $y, $z0, $t, $c\n")
			end
		end
		close(outfile)
	end
end

"""
Create a symbolic link of all the files in a directory `dirsource` in a directory `dirtarget`

$(DocumentFunction.documentfunction(symlinkdirfiles;
argtext=Dict("dirsource"=>"source directory",
            "dirtarget"=>"target directory")))
"""
function symlinkdirfiles(dirsource::AbstractString, dirtarget::AbstractString)
	for f in readdir(dirsource)
		if !isdir(f)
			symlinkdir(f, dirtarget, abspath(dirsource))
		else
			Base.mkdir(joinpath(dirtarget, f))
			symlinkdirfiles(f, joinpath(dirtarget, f))
		end
	end
end

"""
Create a symbolic link of a file `filename` in a directory `dirtarget`

$(DocumentFunction.documentfunction(symlinkdir;
argtext=Dict("filename"=>"file name",
            "dirtarget"=>"target directory")))
"""
function symlinkdir(filename::AbstractString, dirtarget::AbstractString, dirsource::AbstractString)
	filenametarget = joinpath(dirtarget, filename)
	# @show filename
	# @show islink(filenametarget)
	# @show isdir(filenametarget)
	# @show isfile(filenametarget)
	if !islink(filenametarget) && !isdir(filenametarget) && !isfile(filenametarget)
		symlink(joinpath(dirsource, filename), filenametarget)
	end
end

"""
Remove directory

$(DocumentFunction.documentfunction(rmdir;
argtext=Dict("dir"=>"directory to be removed"),
keytext=Dict("path"=>"path of the directory [default=`current path`]")))
"""
function rmdir(dir::AbstractString; path::AbstractString=".")
	if path != "" && path != "."
		dir = joinpath(path, dir)
	end
	if isdir(dir)
		rm(dir, recursive=true)
	end
end

"""
Remove file

$(DocumentFunction.documentfunction(rmfile;
argtext=Dict("filename"=>"file to be removed"),
keytext=Dict("path"=>"path of the file [default=`current path`]")))
"""
function rmfile(filename::AbstractString; path::AbstractString=".")
	if path != "" && path != "."
		filename = joinpath(path, filename)
	end
	if isfile(filename) || islink(filename)
		rm(filename)
	end
end

"""
Remove files

$(DocumentFunction.documentfunction(rmfile;
argtext=Dict("filenamepattern"=>"name pattern for files to be removed"),
keytext=Dict("path"=>"path of the file [default=`current path`]")))
"""
function rmfiles(filenamepattern::Regex; path::AbstractString=".")
	for f in searchdir(filenamepattern; path=path)
		rmfile(f; path=path)
	end
end

"""
Remove files with extension `ext`

$(DocumentFunction.documentfunction(rmfiles_ext;
argtext=Dict("ext"=>"extension"),
keytext=Dict("path"=>"path of the files to be removed [default=`.`]")))
"""
function rmfiles_ext(ext::AbstractString; path::AbstractString=".")
	for f in searchdir(Regex(string(".*\\.", ext)); path=path)
		rmfile(f; path=path)
	end
end

"""
Remove files with root `root`

$(DocumentFunction.documentfunction(rmfiles_root;
argtext=Dict("root"=>"root"),
keytext=Dict("path"=>"path of the files to be removed [default=`.`]")))
"""
function rmfiles_root(root::AbstractString; path::AbstractString=".")
	s = splitdir(root)
	if s[1] != ""
		path = s[1]
		root = s[2]
	end
	for f in searchdir(Regex(string(root, ".*")); path=path)
		rmfile(f; path=path)
	end
end

"""
Create temporary directory

$(DocumentFunction.documentfunction(createtempdir;
argtext=Dict("tempdirname"=>"temporary directory name")))
"""
function createtempdir(tempdirname::AbstractString)
	attempt = 0
	trying = true
	while trying
		try
			attempt += 1
			Mads.mkdir(tempdirname)
			Mads.madsinfo("Created temporary directory: $(tempdirname)", 1)
			trying = false
		catch errmsg
			sleep(attempt * 0.5)
			if attempt > 3
				printerrormsg(errmsg)
				madscritical("$(errmsg)\nTemporary directory $(tempdirname) cannot be created!")
			end
		end
	end
end

"""
Link files in a temporary directory

$(DocumentFunction.documentfunction(linktempdir;
argtext=Dict("madsproblemdir"=>"Mads problem directory",
            "tempdirname"=>"temporary directory name")))
"""
function linktempdir(madsproblemdir::AbstractString, tempdirname::AbstractString)
	attempt = 0
	trying = true
	while trying
		try
			attempt += 1
			Mads.symlinkdirfiles(madsproblemdir, tempdirname)
			Mads.madsinfo("Links created in temporary directory: $(tempdirname)", 1)
			trying = false
		catch errmsg
			Mads.rmdir(tempdirname)
			sleep(attempt * 1)
			Mads.createtempdir(tempdirname)
			if attempt > 4
				printerrormsg(errmsg)
				madscritical("$(errmsg)\nLinks cannot be created in temporary directory $(tempdirname) cannot be created!")
			end
		end
	end
end

"""
Create a directory (if does not already exist)

$(DocumentFunction.documentfunction(mkdir;
argtext=Dict("dirname"=>"directory")))
"""
function mkdir(dirname::AbstractString)
	if !isdir(dirname) && dirname != ""
		Base.mkdir(dirname)
	end
end

"""
Create directories recursively (if does not already exist)

$(DocumentFunction.documentfunction(recursivemkdir;
argtext=Dict("dirname"=>"directory")))
"""
function recursivemkdir(s::AbstractString; filename=true)
	if filename
		if isfile(s)
			return
		end
	else
		if isdir(s)
			return
		end
	end
	d = Vector{String}(undef, 0)
	sc = deepcopy(s)
	if !filename && sc != ""
		push!(d, sc)
	end
	scold = ""
	while true
		sd = splitdir(sc)
		sc = sd[1]
		if sc == scold || sc == ""
			break
		end
		scold = deepcopy(sc)
		push!(d, sc)
	end
	for i = length(d):-1:1
		sc = d[i]
		if isfile(sc)
			Mads.madswarn("File $(sc) exists!")
			return
		elseif !isdir(sc)
			mkdir(sc)
			@info("Make dir $(sc)")
		else
			# Mads.madswarn("Dir $(sc) exists!")
		end
	end
end

"""
Remove directories recursively

$(DocumentFunction.documentfunction(recursivermdir;
argtext=Dict("dirname"=>"directory")))
"""
function recursivermdir(s::AbstractString; filename=true)
	d = Vector{String}(undef, )
	sc = deepcopy(s)
	if !filename && sc!= ""
		push!(d, sc)
	end
	while true
		sd = splitdir(sc)
		sc = sd[1]
		if sc == ""
			break;
		end
		push!(d, sc)
	end
	for i = eachindex(d)
		sc = d[i]
		if isdir(sc)
			rm(sc; force=true)
		end
	end
end

import LightXML

function parsexml(filename::AbstractString, args...; elementnode::AbstractString="variables")
	parsexml(filename, [args...]; elementnode=elementnode)
end

function parsexml(filename::AbstractString, vars::Vector{Symbol}=Vector{Symbol}(undef, 0); elementnode::AbstractString="variables")
	variable_names = Vector{String}(undef, 0)
	variable_values = Vector{Float64}(undef, 0)
	xdoc = LightXML.parse_file(filename)
	xroot = LightXML.root(xdoc)
	for c in LightXML.child_nodes(xroot)  # c is an instance of XMLNode
		if LightXML.is_elementnode(c)
			e = LightXML.XMLElement(c)  # this makes an XMLElement instance
			if LightXML.name(e) == elementnode
				for v in LightXML.child_elements(e)
					d = LightXML.attributes_dict(v)
					push!(variable_names, d["name"])
					push!(variable_values, parse(Float64, d["value"]))
				end
			end
		end
	end
	LightXML.free(xdoc)
	return parsevars(variable_names, variable_values, vars)
end

function parsevars(variable_names::Vector{String}, variable_values::Vector{Float64}, vars::Vector{Symbol})
	scalar_names = Vector{Symbol}(undef, 0)
	vector_names = Vector{Symbol}(undef, 0)
	matrix_names = Vector{Symbol}(undef, 0)
	v_names = Vector{Symbol}(undef, 0)
	v_ind = Vector{Int64}(undef, 0)
	v_rows = Vector{Int64}(undef, 0)
	v_cols = Vector{Int64}(undef, 0)
	for i in eachindex(variable_names)
		s = split(variable_names[i], '[')
		push!(v_names, string(s[1]))
		if length(s) > 1
			indices = split(first(split(s[2], ']')), ',')
			if length(indices) == 1
				push!(v_ind, 1)
				push!(v_rows, parse(Int64, indices[1]))
				push!(v_cols, 0)
				push!(vector_names, Symbol(s[1]))
			else
				push!(v_ind, 2)
				push!(v_rows, parse(Int64, indices[1]))
				push!(v_cols, parse(Int64, indices[2]))
				push!(matrix_names, Symbol(s[1]))
			end
		else
			push!(v_ind, 0)
			push!(v_rows, 0)
			push!(v_cols, 0)
			push!(scalar_names, Symbol(s[1]))
		end
	end
	scalar_names = sort(unique(scalar_names))
	vector_names = sort(unique(vector_names))
	matrix_names = sort(unique(matrix_names))
	@info("Scalars : $(scalar_names)")
	@info("Vectors : $(vector_names)")
	@info("Matrices: $(matrix_names)")
	vector_lengths = zeros(Int64, length(vector_names))
	matrix_rows = zeros(Int64, length(matrix_names))
	matrix_cols = zeros(Int64, length(matrix_names))
	for i in eachindex(v_ind)
		if v_ind[i] == 1
			ii = first(indexin([v_names[i]], vector_names))
			vector_lengths[ii] = max(vector_lengths[ii], v_rows[i])
		elseif v_ind[i] == 2
			ii = first(indexin([v_names[i]], matrix_names))
			matrix_rows[ii] = max(matrix_rows[ii], v_rows[i])
			matrix_cols[ii] = max(matrix_cols[ii], v_cols[i])
		end
	end
	for i in eachindex(vector_names)
		eval(:($(vector_names[i]) = Vector{Float64}(undef, $(vector_lengths[i]))))
	end
	for i in eachindex(matrix_names)
		eval(:($(matrix_names[i]) = Matrix{Float64}(undef, $(matrix_rows[i]), $(matrix_cols[i]))))
	end
	for i in eachindex(v_ind)
		if v_ind[i] == 1
			ii = first(indexin([v_names[i]], vector_names))
			k = v_rows[i]
			v = variable_values[i]
			eval(:($(vector_names[ii])))[k] = v
		elseif v_ind[i] == 2
			ii = first(indexin([v_names[i]], matrix_names))
			r = v_rows[i]
			c = v_cols[i]
			v = variable_values[i]
			eval(:($(matrix_names[ii])))[r, c] = v
		else
			eval(:($(v_names[i]) = $(variable_values[i])))
		end
	end
	lvars = length(vars)
	select = lvars > 0
	s = Vector{Any}(undef, lvars)
	for sc in [scalar_names; vector_names; matrix_names]
		if select
			ii = first(indexin([sc], vars))
			if !isnothing(ii)
				s[ii] = eval(:($(sc)))
			end
		else
			push!(s, eval(:($(sc))))
		end
	end
	return (s...,)
end

function fixlinks(dir::AbstractString="."; test::Bool=true)
	ccd = pwd()
	cd(dir)
	files = readdir()
	for f in files
		if isfile(f)
			@show f
			l = readlines(f)
			if length(l) == 1
				fn = l[1]
				if length(fn) < 260 && isascii(fn)
					if (isfile(fn) || islink(fn))
						if !test
							@info("Linking $(f) to $(fn)")
							rm(f)
							symlink(fn, f)
						else
							@info("TEST: Linking $(f) to $(fn)")
						end
					else
						@info("Linking of `$(f)` fails! `$(fn)` does not exist!")
						# println("ln -sf $(fn) $(f)")
					end
				end
			end
		elseif islink(f)
			link = readlink(f)
			@show link
			link_win = replace(link, "/"=>"\\")
			@show link_win
			if isfile(link_win)
				rm(f)
				if !test
					@info("Linking $(link_win) to $(f)")
					symlink(link_win, f)
				else
					@info("TEST: Linking $(link_win) to $(f)")
				end
			end
		elseif isdir(f) && f != ".git" && f != "build"
			@info("Directory $(joinpath(pwd(), f)) ...")
			fixlinks(f; test=test)
		end
	end
	cd(ccd)
	return nothing
end

function lslinks(dir::AbstractString=".")
	files = readdir(dir; join=true)
	for f in files
		if islink(f)
			@info("Link: $(f) $(readlink(f))")
		elseif isdir(f) && f != ".git"
			lslinks(f)
		end
	end
	return nothing
end

function testlinks()
	target = joinpath(Mads.dir, "Profile.toml")
	link = joinpath(Mads.dir, "Profile-link.toml")
	Mads.rmfile(link)
	symlink(target, link)
	rm(link)
end