import Mads

cd(@__DIR__)

df = Mads.get_excel_data("test.xlsx")

df = Mads.get_excel_data("test.xlsx", "Sheet1")

df = Mads.get_excel_data("test.xlsx", "Sheet1"; header=1:2)

df = Mads.get_excel_data("test.xlsx", "Sheet1"; header=1:1, rows=3:102)

df = Mads.get_excel_data("test.xlsx", "Sheet1"; header=1:1, rows=3:102, cols=1:6)

df = Mads.get_excel_data("test.xlsx", "Sheet1"; header=1:1, rows=3:102, cols=[1,3,7,5])
