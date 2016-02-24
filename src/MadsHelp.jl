import Lexicon

"Produce MADS help information"
function help()
	Markdown.parse_file(Pkg.dir("Mads") * "/GETTING_STARTED.md")
end

"Produce MADS copyright information"
function copyright()
	Markdown.parse_file(Pkg.dir("Mads") * "/COPYING")
end

"Create web documentation files for Mads functions"
function create_documentation()
	Lexicon.save(Mads.madsdir * "/../docs/mads.md", Mads; md_permalink = false)
	Lexicon.save(Mads.madsdir * "/../docs/mads.html", Mads)
	Lexicon.save(Mads.madsdir * "/../mkdocs/docs/Modules/Mads.md", Mads; mdstyle_objname="##", md_permalink = false, md_subheader=:category)
	Lexicon.save(Mads.madsdir * "/../mkdocs/docs/Modules/BIGUQ.md", BIGUQ; mdstyle_objname="##", md_permalink = false, md_subheader=:category)
	Lexicon.save(Mads.madsdir * "/../mkdocs/docs/Modules/Anasol.md", Anasol; mdstyle_objname="##", md_permalink = false, md_subheader=:category)
	Lexicon.save(Mads.madsdir * "/../mkdocs/docs/Modules/ReusableFunctions.md", ReusableFunctions; mdstyle_objname="##", md_permalink = false, md_subheader=:category)
	Lexicon.save(Mads.madsdir * "/../mkdocs/docs/Modules/MetaProgTools.md", MetaProgTools; mdstyle_objname="##", md_permalink = false, md_subheader=:category)
	Lexicon.save(Mads.madsdir * "/../mkdocs/docs/Modules/RobustPmap.md", RobustPmap; mdstyle_objname="##", md_permalink = false, md_subheader=:category)

	# index = Lexicon.save(Mads.madsdir * "/../mkdocs/docs/mads.md", Mads)
	# Lexicon.save(Mads.madsdir * "/../mkdocs/docs/index.md", Lexicon.Index([index]); md_subheader = :category)

	d = pwd()
	cd(Mads.madsdir * "/../mkdocs")
	run(`mkdocs gh-deploy --clean`)
	cd(d)
	return
end

#=
#TODO IMPORTANT

MADS function documentation should include the following sections:
"""
Description:

Usage:

Arguments:

Returns:

Dumps:

Examples:

Details:

References:

See Also:
"""
=#
