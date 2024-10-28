import Mads
import DataFrames
import OrderedCollections

workdir = joinpath(Mads.dir, "examples", "xlsx")
xlsxfile = joinpath(workdir, "test.xlsx")

df1 = Mads.get_excel_data(xlsxfile)

df2 = Mads.get_excel_data(xlsxfile, "Sheet1")

df3 = Mads.get_excel_data(xlsxfile, "Sheet1"; header=1:2)

df4 = Mads.get_excel_data(xlsxfile, "Sheet1"; header=1:1, rows=3:102)

df5 = Mads.get_excel_data(xlsxfile, "Sheet1"; header=1:1, rows=3:102, cols=1:6)

df6 = Mads.get_excel_data(xlsxfile, "Sheet1"; header=1:1, rows=3:102, cols=[1,3,7,5])

df7 = Mads.get_excel_data(xlsxfile, "Sheet1"; header=1:1, rows=3:102, cols=[1,3,7,5], numbertype=Float32)

dd1 = Mads.get_excel_data(xlsxfile, "Sheet1"; header=1:1, rows=3:102, cols=[1,3,7,5], dataframe=false)

dd2 = Mads.get_excel_data(xlsxfile, "Sheet1"; header=1:1, rows=3:102, cols=[1,3,7,5], dataframe=false, keytype=Symbol)

:nothing