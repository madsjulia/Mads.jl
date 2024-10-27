import Mads
import DataFrames
import OrderedCollections

workdir = joinpath(Mads.dir, "examples", "xlsx")
xlsxfile = joinpath(workdir, "test.xlsx")

df = Mads.get_excel_data(xlsxfile)

df = Mads.get_excel_data(xlsxfile, "Sheet1")

df = Mads.get_excel_data(xlsxfile, "Sheet1"; header=1:2)

df = Mads.get_excel_data(xlsxfile, "Sheet1"; header=1:1, rows=3:102)

df = Mads.get_excel_data(xlsxfile, "Sheet1"; header=1:1, rows=3:102, cols=1:6)

df = Mads.get_excel_data(xlsxfile, "Sheet1"; header=1:1, rows=3:102, cols=[1,3,7,5])

df = Mads.get_excel_data(xlsxfile, "Sheet1"; header=1:1, rows=3:102, cols=[1,3,7,5], numbertype=Float32)

dd = Mads.get_excel_data(xlsxfile, "Sheet1"; header=1:1, rows=3:102, cols=[1,3,7,5], dataframe=false)

dd = Mads.get_excel_data(xlsxfile, "Sheet1"; header=1:1, rows=3:102, cols=[1,3,7,5], dataframe=false, keytype=Symbol)