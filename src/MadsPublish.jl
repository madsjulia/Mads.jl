import Documenter
import Dates

function _documenter_version()
	if isdefined(Documenter, :DOCUMENTER_VERSION)
		return getproperty(Documenter, :DOCUMENTER_VERSION)
	end
	# Fallback: assume pre-1.0 behavior
	return v"0.0.0"
end

function _run_git(args::Vector{String}; dir::AbstractString)
	cmd = Cmd(["git"; args])
	return run(Cmd(cmd; dir=dir))
end

function _run_git(args::AbstractString...; dir::AbstractString)
	return _run_git(collect(args); dir=dir)
end

function _mads_html_format(; footer)
	# Newer Documenter versions support `repolink` (used for navbar GitHub link).
	# Older Documenter (e.g. 0.27) does not.
	repolink_kwargs = _documenter_version() >= v"1.0.0" ? (repolink="https://github.com/madsjulia/Mads.jl",) : ()

	common_kwargs = (
		prettyurls=false,
		canonical="https://madsjulia.github.io/Mads.jl",
		sidebar_sitename=false,
		assets=[
			"assets/favicon.ico",
			"assets/envitrace-footer.css",
			"assets/purple-theme.css",
			"assets/accordion-toggle.js",
		],
		footer=footer,
	)
	try
		return Documenter.Writers.HTMLWriter.HTML(; common_kwargs..., repolink_kwargs..., size_threshold_warn=512 * 1024, size_threshold=1024 * 1024)
	catch err
		# Older Documenter versions do not support size_threshold_* keywords.
		if err isa MethodError
			# Older Documenter versions may also not support `repolink`.
			try
				return Documenter.Writers.HTMLWriter.HTML(; common_kwargs..., repolink_kwargs...)
			catch err2
				if err2 isa MethodError
					return Documenter.Writers.HTMLWriter.HTML(; common_kwargs...)
				end
				rethrow()
			end
		end
		rethrow()
	end
end

"""
Create web documentation

$(DocumentFunction.documentfunction(documentation_create))
"""
function documentation_create(modules_doc=madsmodulesdoc, modules_load=string.(madsmodules))
	for i in modules_load
		Core.eval(Main, :(@Mads.tryimportmain $(Symbol(i))))
	end
	footer = "Maintained and supported by EnviTrace LLC, Santa Fe, New Mexico, USA. [![EnviTrace](https://madsjulia.github.io/Mads.jl/dev/assets/Envitrace-Logo-Color-gray.svg)](https://envitrace.com/)"
	pages=[
        "MADS" => "index.md",
        "Getting Started" => "Getting_Started.md",
		"Example Problems" => "Examples/Examples.md",
		"Model Diagnostics" => "Examples/model_diagnostics/model_diagnostics.md",
		"Model Calibration" => "Examples/model_inversion_contamination/model_inversion_contamination.md",
		"Sensitivity Analysis" => "Examples/ode/ode.md",
		"Uncertainty Quantification" => "Examples/bayesian_sampling/bayesian_sampling.md",
		"Decision Analysis" => "Examples/infogap/infogap.md",
		"Blind Source Separation" => "Examples/blind_source_separation/blind_source_separation.md",
		"Contaminant Transport" => "Examples/contamination/contamination.md",
		"Contaminant Source Identification" => "Examples/contaminant_source_identification/contaminant_source_identification.md",
		"Contaminant Source Remediation" => "Examples/bigdt/source_termination/source_termination.md",
        "Model Coupling" => "Model_Coupling.md",
		"Notebooks" => "Notebooks.md",
		"Modules" => "Modules.md",
		"Testing" => "Testing.md"
    ]
	makedocs_kwargs = (
		root=joinpath(Mads.dir, "docs"),
		sitename="Mads",
		authors="Velimir (monty) Vesselinov",
		pages=pages,
		repo="https://github.com/madsjulia/Mads.jl/blob/{commit}{path}#{line}",
		format=_mads_html_format(footer=footer),
		doctest=true,
		modules=modules_doc,
		clean=true,
	)
	makedocs_kwargs = merge(makedocs_kwargs, (warnonly=[:missing_docs],))
	Documenter.makedocs(; makedocs_kwargs...)
	return nothing
end

"""
Create web documentation

$(DocumentFunction.documentfunction(documentation_deploy))
"""
function documentation_deploy(; deploy_config=Documenter.auto_detect_deploy_system())
	Documenter.deploydocs(
		; root=joinpath(Mads.dir, "docs"),
		repo="github.com/madsjulia/Mads.jl.git",
		branch="gh-pages",
		devbranch="master",
		devurl="dev",
		versions=[
			"stable" => "v^",
			"v#.#",
			"dev" => "dev",
		],
		target="build",
		deploy_config=deploy_config,
		push_preview=true,
	)
	return nothing
end

"""
	documentation_deploy_local(; build=true, remote="origin", branch="gh-pages", target_subdir="dev",
		worktree_dir=joinpath(Mads.dir, "docs", "_gh-pages"), push=false, commit=true,
		message=nothing)

Deploy the locally built docs (`docs/build`) into a local git worktree for the `gh-pages`
branch.

This is intended for local development and manual publishing when `Documenter.deploydocs`
does not auto-detect a CI environment.

By default this does **not** push to the remote. To publish to GitHub Pages, call with
`push=true`.
"""
function documentation_deploy_local(; build::Bool=true, remote::AbstractString="origin", branch::AbstractString="gh-pages", target_subdir::AbstractString="dev",
	worktree_dir::AbstractString=joinpath(Mads.dir, "docs", "_gh-pages"), push::Bool=false, commit::Bool=true, message=nothing)
	root = Mads.dir
	docs_root = joinpath(root, "docs")
	build_dir = joinpath(docs_root, "build")

	if build
		documentation_create()
	end
	isdir(build_dir) || error("Docs build directory not found: $build_dir")

	# Ensure we have the gh-pages branch locally
	_run_git("fetch", remote, branch; dir=root)

	# Create worktree if needed
	if !isdir(worktree_dir)
		mkpath(Base.dirname(worktree_dir))
		_run_git("worktree", "add", worktree_dir, "$remote/$branch"; dir=root)
	end

	# Ensure the worktree is synced to the current remote tip.
	# This prevents recurring non-fast-forward push rejections when the remote
	# gh-pages branch has moved since the last local deploy.
	_run_git("fetch", remote, branch; dir=worktree_dir)
	_run_git("reset", "--hard", "$remote/$branch"; dir=worktree_dir)
	_run_git("clean", "-fdx"; dir=worktree_dir)

	# Mirror build output into gh-pages/<target_subdir>
	target_dir = joinpath(worktree_dir, target_subdir)
	if ispath(target_dir) && !isdir(target_dir)
		rm(target_dir; force=true)
	end
	if isdir(target_dir)
		rm(target_dir; recursive=true, force=true)
	end
	mkpath(target_dir)
	for entry in readdir(build_dir)
		src = joinpath(build_dir, entry)
		dst = joinpath(target_dir, entry)
		cp(src, dst; force=true)
	end

	_run_git("add", "-A", target_subdir; dir=worktree_dir)

	if commit
		# Skip commit if no changes staged
		nothing_changed = false
		try
			_run_git(["diff", "--cached", "--quiet"]; dir=worktree_dir)
			nothing_changed = true
		catch
			nothing_changed = false
		end
		if !nothing_changed
			if message === nothing
				message = "Update $(target_subdir) docs " * string(Dates.now())
			end
			_run_git("commit", "-m", string(message); dir=worktree_dir)
		end
	end

	if push
		_run_git("push", remote, "HEAD:$branch"; dir=worktree_dir)
	end

	return nothing
end