if !haskey(ENV, "MADS_NO_GADFLY") && !haskey(ENV, "MADS_NO_DISPLAY")
	import Gadfly
	import Compose
end
import Images
import ImageMagick

function display(filename::AbstractString, open::Bool=false)
	if !graphoutput
		return
	end
	if !isfile(filename)
		@warn("File `$(filename)` does not exist!")
		return
	end
	trytoopen = open
	ext = lowercase(Mads.getextension(filename))
	if !open || isdefined(Main, :TerminalExtensions) || isdefined(Main, :VSCodeServer) || (isdefined(Main, :IJulia) && Main.IJulia.inited)
		if ext == "svg"
			if (isdefined(Main, :IJulia) && Main.IJulia.inited) || isdefined(Main, :VSCodeServer)
				Base.open(filename) do f
					Base.display(MIME"image/svg+xml"(), read(f, String))
				end
			else
				try
					img = load_svg_as_image(filename)
					Base.display(img)
					isdefined(Main, :TerminalExtensions) && println("")
				catch
					trytoopen = true
				end
			end
		else
			try
				img = Images.load(filename)
				Base.display(img)
				isdefined(Main, :TerminalExtensions) && println("")
			catch
				trytoopen = true
			end
		end
	else
		trytoopen = true
	end
	if trytoopen
		if ext == "txt"
			println.(readlines(filename))
			return nothing
		end
		try
			if Sys.iswindows()
				run(Cmd(["cmd", "/c", "start", "", abspath(filename)])) # Use default application registered for the file type
			elseif Sys.isapple()
				run(`open $filename`)
			elseif Sys.islinux()
				run(`xdg-open $filename`)
			else
				madswarn("Do not know how to open `$(filename)`!")
			end
		catch
			madswarn("Opening `$(filename)` failed")
		end
	end
end

if !haskey(ENV, "MADS_NO_GADFLY")
	function display(p::Gadfly.Plot; gwo=nothing, gho=nothing, gw=gwo, gh=gho)
		if graphoutput
			if !isnothing(gw) && !isnothing(gh)
				gwod = Compose.default_graphic_width
				ghod = Compose.default_graphic_height
				gwo = isnothing(gwo) ? gwod : gwo
				gho = isnothing(gho) ? ghod : gho
				r = gw / gh
				if r > 1
					gwon = gho * r
					ghon = gho
				else
					ghon = gwo
					gwon = gwo * r
				end
				Compose.set_default_graphic_size(gwon, ghon)
			end
			try
				Gadfly.draw(Gadfly.PNG(), p)
				print("\r")
			catch errmsg
				if !isnothing(gw) && !isnothing(gh)
					Compose.set_default_graphic_size(gwod, ghod)
				end
				printerrormsg(errmsg)
				@warn("Gadfly failed!")
			end
			if !isnothing(gw) && !isnothing(gh)
				Compose.set_default_graphic_size(gwod, ghod)
			end
		end
	end

	function display(p::Compose.Context; gwo=nothing, gho=nothing, gw=gwo, gh=gho)
		if graphoutput
			if !isnothing(gw) && !isnothing(gh)
				gwod = Compose.default_graphic_width
				ghod = Compose.default_graphic_height
				gwo = isnothing(gwo) ? gwod : gwo
				gho = isnothing(gho) ? ghod : gho
				r = gw / gh
				if r > 1
					gwon = gho * r
					ghon = gho
				else
					ghon = gwo
					gwon = gwo * r
				end
				Compose.set_default_graphic_size(gwon, ghon)
			end
			try
				Compose.draw(Compose.PNG(), p)
				print("\r")
			catch errmsg
				if !isnothing(gw) && !isnothing(gh)
					Compose.set_default_graphic_size(gwod, ghod)
				end
				printerrormsg(errmsg)
				@warn("Compose failed!")
			end
			if !isnothing(gw) && !isnothing(gh)
				Compose.set_default_graphic_size(gwod, ghod)
			end
		end
	end
end
function display(o; gwo=nothing, gho=nothing, gw=gwo, gh=gho)
	if graphoutput
		Base.display(o)
		print("\r")
	end
end

function load_svg_as_image(filename::AbstractString)
	svg_data = read(filename, String)
	svg_io = IOBuffer(svg_data)
	try
		img = ImageMagick.load(svg_io, format="SVG")
		return img
	catch
		madswarn("Failed to load SVG image from `$filename` using ImageMagick.")
	end
	return nothing
end

function convert_svg_to_png(svg_filename::AbstractString; png_filename::AbstractString="", dpi::Integer=imagedpi)
	if png_filename == ""
		png_filename = Mads.getrootname(svg_filename) * ".png"
	end
	outdir = dirname(png_filename)
	if !(outdir == "." || isempty(outdir))
		mkpath(outdir)
	end
	img = load_svg_as_image(svg_filename)
	try
		Images.save(png_filename, img; dpi=dpi)
	catch
		Images.save(png_filename, img)
	end
	return png_filename
end
@doc """
Display image file

$(DocumentFunction.documentfunction(display;
argtext=Dict("filename"=>"image file name","p"=>"plotting object")))
""" display