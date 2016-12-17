import Mads
import Images
import DataFrames
using Escher
using ImageMagick

function execute_bigdt(input::Dict, waiting, status, resultbox)
	if haskey(input, :name)
		push!(waiting, true)
		filename = input[:name]
		problemdir = input[:dir]
		md = Mads.loadmadsfile(problemdir * filename)
		nsample = input[:nsample]
		bigdtresults = Mads.dobigdt(md, nsample; maxHorizon=0.8, numlikelihoods=5)
		Mads.plotrobustnesscurves(md, bigdtresults; filename=joinpath(problemdir, filename * "-robustness-$nsample.svg"))
		push!(waiting, false)
	end
end

function main(window)
	push!(window.assets, "widgets")
	problemdir = Mads.getmadsdir()
	waiting = Signal(false)
	status = Signal(1)
	madslogo = Images.load("../../logo/mads_black_swan_logo_big_text_new_3inch.png")
	madstext = Escher.vbox(Escher.plaintext("Model Analysis & Decision Support"))
	madsbox = Escher.hbox(Escher.packacross(center, Escher.vbox(madslogo, madstext)))
	resultbox = Escher.hbox()
	inp = Signal(Dict())
	gin = Escher.sampler()
	form = vbox(
		madsbox |> Escher.packitems(center),
		Escher.hline(),
		Escher.h2("Bayesian Information Gap Decision Theory (BIG-DT)"),
		Escher.watch!(gin, :name, textinput("source_termination", label="Problem name")),
		Escher.watch!(gin, :dir, textinput("", label="Problem directory")),
		Escher.hbox("Number of samples", Escher.watch!(gin, :nsample, slider(100:100:1000))) |> Escher.packacross(center),
		Escher.trigger!(gin, :submit, button("Run")),
		vskip(1em),
		Escher.link("http://mads.readthedocs.org/en/latest/EXAMPLES/", "For more information check Mads website")
	) |> maxwidth(400px)

	hbox(
		map(inp) do dict
			if haskey(dict, :name)
				filename = dict[:dir] * dict[:name] * "-robustness-$(dict[:nsample]).svg"
				if isfile(filename)
					resultbox = Escher.vbox(Escher.plaintext("Robustness curve"), Escher.Elem(:div, innerHTML="$(readall(filename))"))
				else
					resultbox = Escher.plaintext("$filename is missing")
				end
			end
			hbox(
				vbox(
					Escher.intent(gin, form) >>> inp,
					Escher.vskip(2em),
					# string(dict),
					map(x ->progress(x, secondaryprogress=x), status),
					map(x -> Escher.spinner(x), waiting)
				),
				hskip(2em),
				vbox(
					resultbox
				) |> maxwidth(400px)
			)
		end
	) |> Escher.pad(2em)
end
