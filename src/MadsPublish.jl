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
        "MADS" => "index.md",
        "Getting Started" => "Getting_Started.md",
        "Installation" => "Installation.md",
        "Model Coupling" => "Model_Coupling.md",
		"Examples" => "Examples/index.md",
		"Testing" => "Testing.md"
    ]
	Documenter.makedocs(; root=joinpath(Mads.dir, "docs"), sitename="Mads", authors="Velimir (monty) Vesselinov", pages=pages, repo="https://github.com/madsjulia/Mads.jl/blob/{commit}{path}#{line}", format=Documenter.Writers.HTMLWriter.HTML(; prettyurls=false, canonical="https://madsjulia.github.io/Mads.jl", sidebar_sitename=false, assets=["assets/favicon.ico"]), doctest=true, modules=modules_doc, clean=true)
	return nothing
end

"""
Create web documentation

$(DocumentFunction.documentfunction(documentation_deploy))
"""
function documentation_deploy(; deploy_config=Documenter.auto_detect_deploy_system())
	Documenter.deploydocs(; root=joinpath(Mads.dir, "docs"), repo="github.com/madsjulia/Mads.jl.git", devbranch="master", target="build", deploy_config=deploy_config, push_preview=true)
	return nothing
end