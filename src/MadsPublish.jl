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
	Documenter.makedocs(root=joinpath(dirname(pathof(Mads)), "..", "docs"), sitename="Mads documentation", format=DocumenterMarkdown.Markdown(), doctest=false, modules=modules_doc, clean=true)
	current_dir = pwd()
	cd(Mads.dir)
	# run(`git pull gh gh-pages`)
	if Mads.madspython
		@info("Build documentation ...")
		run(`python -m mkdocs build --clean`)
		@info("Done.")
	else
		@info("Python and mkdocs might be not available!")
	end
	cd(current_dir)
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
	Documenter.makedocs(root=joinpath(dirname(pathof(Mads)), "..", "docs"), sitename="Mads documentation", format=DocumenterMarkdown.Markdown(), doctest=false, modules=modules_doc, clean=true)
	current_dir = pwd()
	cd(Mads.dir)
	# run(`git pull gh gh-pages`)
	if Mads.madspython
		@info("Build & deploy documentation ...")
		run(`python -m mkdocs gh-deploy --clean`)
		@info("mkdocs done.")
	else
		@info("Python and mkdocs might be not available!")
	end
	cd(current_dir)
	return nothing
end