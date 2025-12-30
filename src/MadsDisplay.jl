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
		@warn("File `$filename` is missing!")
		return
	end
	trytoopen = open
	ext = lowercase(Mads.getextension(filename))
	if !open || isdefined(Main, :TerminalExtensions) || isdefined(Main, :VSCodeServer) || (isdefined(Main, :IJulia) && Main.IJulia.inited)
		if ext == "svg"
			if isdefined(Main, :IJulia) && Main.IJulia.inited
				open(filename) do f
					display("image/svg+xml", read(f, String))
				end
			else
				try
					img = _load_svg_as_image(filename)
					Base.display(img)
					println("")
				catch
					trytoopen = true
				end
			end
		else
			try
				img = Images.load(filename)
				Base.display(img)
				println("")
			catch
				trytoopen = true
			end
		end
	else
		trytoopen = true
	end
	if trytoopen
		if ext == "txt"
			a = println.(readlines(filename))
			return nothing
		end
		try
			run(`open $filename`)
		catch
			try
				run(`xdg-open $filename`)
			catch
				@warn("Do not know how to open `$filename`")
			end
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

function _load_svg_as_image(filename::AbstractString)
	# Use ImageMagick to rasterize SVGs without shelling out to `convert`.
	return ImageMagick.load(filename)
end
@doc """
Display image file

$(DocumentFunction.documentfunction(display;
argtext=Dict("filename"=>"image file name","p"=>"plotting object")))
""" display