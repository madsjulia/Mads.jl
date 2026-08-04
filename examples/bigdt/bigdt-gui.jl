# Compatibility launcher for the former Escher-based BIG-DT example.
# The maintained interactive interface is the EnviCloud decision-support demo.

include(joinpath(@__DIR__, "source_termination.jl"))

if abspath(PROGRAM_FILE) == @__FILE__
	println("Maintained browser demo: https://cloud.envitrace.com/demos/decision-support")
	run_source_termination()
end
