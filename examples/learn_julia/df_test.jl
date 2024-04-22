import DataFrames # load required package
df = DataFrames.DataFrame(A=1:4,B="a") # create data frame with two columns; scalars are expanded
df[!, :C] = repeat([true, false], 2) # OK, new column added

for i in axes(df, 1)
	@show df
	df[i, 1] = df[i, 1] + 2
end