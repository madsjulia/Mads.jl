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
	Documenter.makedocs(; root=joinpath(Mads.dir, "docs"), sitename="Mads", format=Documenter.Writers.HTMLWriter.HTML(; prettyurls=false, sidebar_sitename=false, assets=["assets/favicon.ico"]), doctest=true, modules=modules_doc, clean=true)
	return nothing
end

"""
Create web documentation

$(DocumentFunction.documentfunction(documentation_deploy))
"""
function documentation_deploy(modules_doc=madsmodulesdoc, modules_load=string.(madsmodules))
	for i in modules_load
		Core.eval(Main, :(@Mads.tryimportmain $(Symbol(i))))
	end
	Documenter.deploydocs(; root=joinpath(Mads.dir, "docs"), repo="github.com/madsjulia/Mads.jl.git")
	return nothing
end