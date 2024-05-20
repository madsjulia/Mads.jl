import XLSX
import DataFrames

function set_xlsx_formats(wf::XLSX.XLSXFile, dec_digits::Integer, exp_digits::Integer)
	set_xlsx_formats(wf.workbook, dec_digits, exp_digits)
end

function set_xlsx_formats(wb::XLSX.Workbook, dec_digits::Integer, exp_digits::Integer)
	dec_digits_string = lpad("", dec_digits, "0")
	exp_digits_string = lpad("", exp_digits, "0")
	numfmt_dec = XLSX.styles_add_numFmt(wb, "0.$(dec_digits_string);-0.$(dec_digits_string);-")
	numfmt_exp = XLSX.styles_add_numFmt(wb, "0.$(exp_digits_string)E+00")
	numfmt_style_dec = XLSX.styles_add_cell_xf(wb, Dict("numFmtId"=>"$numfmt_dec"))
	numfmt_style_exp = XLSX.styles_add_cell_xf(wb, Dict("numFmtId"=>"$numfmt_exp"))
	return numfmt_style_dec, numfmt_style_exp
end

function apply_xlsx_format(df::DataFrames.DataFrame, format::XLSX.CellDataFormat, cols::AbstractVector=names(df))
	DataFrames.select(df, DataFrames.All(), cols .=> DataFrames.ByRow(x -> XLSX.CellValue(x, format)) .=> cols)
end

function apply_xlsx_format(ws::XLSX.Worksheet, format::XLSX.CellDataFormat, cols::AbstractVector=Symbol.(vec(ws[1, :])))
	for j in axes(ws, 2)
		if Symbol(ws[1, j]) in cols
			for i in axes(ws, 1)
				if i > 1
					ws[i, j] = XLSX.CellValue(ws[i, j], format)
				end
			end
		end
	end
end