import Documenter
import DocumenterMarkdown
import DocumentFunction

"""
Create web documentation

$(DocumentFunction.documentfunction(documentation_create))
"""
function documentation_create(modules_doc=madsmodulesdoc, modules_load=string.(madsmodules))
	for i in modules_load
		Core.eval(Main, :(@Mads.tryimportmain $(Symbol(i))))
	end
	pages=[
        "Home" => "index.md",
        "User Guide" => "user.md",
        "Developer Guide" => "developer.md",
        "Migrating To PkgTemplates 0.7+" => "migrating.md",
    ]
	Documenter.makedocs(; root=joinpath(Mads.dir, "docs"), sitename="Mads", authors="Velimir (monty) Vesselinov", repo="https://github.com/madsjulia/Mads.jl/blob/{commit}{path}#{line}", format=Documenter.Writers.HTMLWriter.HTML(; prettyurls=false, canonical="https://madsjulia.github.io/Mads.jl", sidebar_sitename=false, assets=["assets/favicon.ico"]), doctest=true, modules=modules_doc, clean=true)
	return nothing
end

"""
Create web documentation

$(DocumentFunction.documentfunction(documentation_deploy))
"""
function documentation_deploy()
	Documenter.deploydocs(; root=joinpath(Mads.dir, "docs"), push_preview=true, repo="github.com/madsjulia/Mads.jl")
	return nothing
end