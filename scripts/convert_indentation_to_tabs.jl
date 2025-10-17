#!/usr/bin/env julia
# Utility: Convert leading indentation of 4-space groups to tabs across all .jl files in the repo.
# It preserves alignment spaces after tabs and does not touch spaces inside strings or code bodies
# beyond the line's leading indentation.

import Printf

const ROOT = normpath(joinpath(@__DIR__, ".."))

function convert_file(path::AbstractString; spaces_per_tab::Int=4)
	text = read(path, String)
	changed = false
	out = IOBuffer()
	for line in eachline(IOBuffer(text), keep=true)
		# Match leading spaces only
		if startswith(line, " ")
			# Count leading spaces
			i = findfirst(!=(' '), line)
			n = isnothing(i) ? lastindex(line) : (first(i)-1)
			# Number of full tabs to insert
			tabs = n ÷ spaces_per_tab
			remspaces = n % spaces_per_tab
			if tabs > 0
				Printf.print(out, repeat("\t", tabs))
				Printf.print(out, repeat(" ", remspaces))
				Printf.print(out, line[n+1:end])
				changed = true
				continue
			end
		end
		Printf.print(out, line)
	end
	newtext = String(take!(out))
	if changed && newtext != text
		write(path, newtext)
		return true
	end
	return false
end

function main()
	repo = ROOT
	files = String[]
	for (dir, _subdirs, fnames) in walkdir(repo)
		for fn in fnames
			endswith(fn, ".jl") && push!(files, joinpath(dir, fn))
		end
	end
	# Exclude common directories that shouldn't be mass-edited
	excludes = Set([
		joinpath(repo, "docs", "build"),
		joinpath(repo, "docs", "src"), # keep docs examples as-is if desired
		joinpath(repo, "data"),
		joinpath(repo, "data_orig"),
		joinpath(repo, "data_michigan"),
		joinpath(repo, "public"),
		joinpath(repo, "gui_data"),
	])

	function is_excluded(path)
		for ex in excludes
			if startswith(path, ex)
				return true
			end
		end
		return false
	end

	edited = 0
	for f in files
		is_excluded(f) && continue
		try
			convert_file(f) && (edited += 1)
		catch e
			@warn "Failed to convert" file=f err=e
		end
	end
	@printf "Converted indentation in %d files.\n" edited
end

main()
