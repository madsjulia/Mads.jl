import Mads
import Test

# Test array values against a dictionary loaded from two files
problemdir = Mads.getproblemdir()
if problemdir == "."
	problemdir = joinpath(Mads.dir, "examples", "reading_instructions")
end

instructionfilename = joinpath(problemdir, "pm1.inst")
inputfilename = joinpath(problemdir, "pm1.obs")

obsdict = Mads.ins_obs(instructionfilename, inputfilename)

Test.@testset "Instructions" begin
	obsnames = ["P40693_r1_pm01", "P40693_r11_pm01", "P40693_r13_pm01", "P40693_r15_pm01", "P40693_r28_pm01", "P40693_r33_1_pm01", "P40693_r33_2_pm01", "P40693_r35b_pm01", "P40693_r36_pm01", "P40693_r42_pm01", "P40693_r43_1_pm01", "P40693_r43_2_pm01", "P40693_r44_1_pm01", "P40693_r44_2_pm01", "P40693_r45_1_pm01", "P40693_r45_2_pm01", "P40693_r50_1_pm01", "P40693_r50_2_pm01", "P40693_r61_1_pm01", "P40693_r61_2_pm01", "P40693_r62_pm01", "P41760_r1_pm01", "P41760_r11_pm01", "P41760_r13_pm01", "P41760_r15_pm01", "P41760_r28_pm01", "P41760_r33_1_pm01", "P41760_r33_2_pm01", "P41760_r35b_pm01", "P41760_r36_pm01", "P41760_r42_pm01", "P41760_r43_1_pm01", "P41760_r43_2_pm01", "P41760_r44_1_pm01", "P41760_r44_2_pm01", "P41760_r45_1_pm01", "P41760_r45_2_pm01", "P41760_r50_1_pm01", "P41760_r50_2_pm01", "P41760_r61_1_pm01", "P41760_r61_2_pm01", "P41760_r62_pm01"]
	obsvalues = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.8806500000000597, 2.856649999999945, 5.120670000000018, -6.644770000000108, -3.298240000000078, -3.887230000000045, -6.05074999999988, -4.182579999999916, -6.860159999999951, -6.8163999999999305, -2.4722600000000057, -2.446419999999989, -4.569749999999885, -4.335849999999937, -4.322290000000066, -4.310320000000047, -4.284290000000055, -3.7802599999999984, -3.75315999999998, -5.033439999999928, -4.987419999999929, -2.7634800000000723, -2.740490000000136, -0.09019000000012056]

	i = 1
	for obsname in obsnames
		Test.@test obsdict[obsname] == obsvalues[i]
		i += 1
	end
end

:passed