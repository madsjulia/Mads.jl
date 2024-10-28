import Mads
import Test

workdir = joinpath(Mads.dir, "examples", "xlsx")
runtests = joinpath(workdir, "xlsx.jl")

include(runtests)

Test.@testset "XLSX" begin
	Test.@test df1 == df2
	Test.@test Matrix(df1)[2:end,:] == Matrix(df3)
	Test.@test Matrix(df3) == Matrix(df4)
	Test.@test Matrix(df4)[:,1:6] == Matrix(df5)
	Test.@test Matrix(df4)[:,[1,3,7,5]] == Matrix(df6)
	Test.@test all(Float32.(Matrix(df4)[:,[3,7,5]]) .== Matrix(df7)[:,2:end])
	Test.@test hcat([dd1[k] for k in keys(dd1)]...) == Matrix(df6)
	Test.@test hcat([dd2[k] for k in keys(dd2)]...) == Matrix(df6)
end

:nothing