# import Gadfly
import JuMP
import Gurobi

m = JuMP.Model(solver=Gurobi.GurobiSolver(Threads=4))

@JuMP.variables m begin
	Pennies, Int
	Nickels, Int
	Dimes, Int
	Quarters, Int
	Dollars, Int
	0 <= Cu <= 1000
	0 <= Ni <= 50
	0 <= Zi <= 50
	0 <= Mn <= 50
end

@JuMP.constraints m begin
	Copper, .06Pennies + 3.8Nickels + 2.1Dimes + 5.2Quarters +7.2Dollars - Cu == 0
	Nickel, 1.2Nickels + .2Dimes + .5Quarters + .2Dollars - Ni == 0
	Zinc, 2.4Pennies +.5Dollars - Zi == 0
	Manganese, .3Dollars - Mn == 0
end

@JuMP.objective(m, Max, .01Pennies + .05Nickels + .1Dimes + .25Quarters + 1Dollars )

status=JuMP.solve(m)
JuMP.getvalue(Cu)