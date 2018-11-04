import OrderedCollections
import DocumentFunction

"""
Parse Amanzi output provided in an external file (`filename`)

$(DocumentFunction.documentfunction(amanzi_output_parser;
argtext=Dict("filename"=>"external file name [default=`\"observations.out\"`]")))

Returns:

- dictionary with model observations following MADS requirements

Example:

```julia
Mads.amanzi_output_parser()
Mads.amanzi_output_parser("observations.out")
```
"""
function amanzi_output_parser(filename::String="observations.out")
	d = readdlm(filename, ',', skipstart=2)
	no = size(d)[1]
	madsinfo("Number of observations $(no)")
	w = map(i->strip(i), d[:,2])
	madsinfo("Number of wells $(length(unique(w)))")
	time = d[:,5]
	madsinfo("Number of observation times $(length(unique(time)))")
	obs = d[:,6]
	head_index = find(d[:,4] .== " hydraulic head")
	cr_index = find(d[:,4] .== " Chromium aqueous concentration")
	madsinfo("Number of head observations $(length(head_index))")
	madsinfo("Number of chromium observations $(length(cr_index))")
	flag = Array{Char}(undef, no)
	flag[head_index] = 'h'
	flag[cr_index] = 'c'
	obs_name = Array{String}(undef, no)
	for i = 1:no
		obs_name[i] = w[i] * "$(flag[i])" * "_" * "$(@Printf.sprintf("%.1f", time[i]))"
	end
	dict = OrderedCollections.OrderedDict{String,Float64}(zip(obs_name, obs))
	return dict
end
