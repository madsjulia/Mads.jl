import Documenter
import DocumenterMarkdown

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