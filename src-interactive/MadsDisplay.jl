if !haskey(ENV, "MADS_NO_GADFLY")
	@Mads.tryimport Gadfly
	@Mads.tryimport Compose
end
@Mads.tryimport Images

function display(filename::AbstractString)
	if !graphoutput
		return
	end
	if !isfile(filename)
		@warn("File `$filename` is missing!")
		return
	end
	if isdefined(Main, :TerminalExtensions) || (isdefined(Main, :IJulia) && Main.IJulia.inited)
		trytoopen = false
		ext = lowercase(Mads.getextension(filename))
		if ext == "svg"
			if isdefined(Main, :IJulia) && Main.IJulia.inited
				open(filename) do f
					display("image/svg+xml", read(f, String))
				end
			else
				root = Mads.getrootname(filename)
				filename2 = root * ".png"
				try
					run(`convert -density 90 -background none $filename $filename2`)
					img = Images.load(filename2)
					Base.display(img)
					println("")
				catch
					trytoopen = true
				end
				if isfile(filename2)
					rm(filename2)
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
			if gw != nothing && gh != nothing
				gwod = Compose.default_graphic_width
				ghod = Compose.default_graphic_height
				gwo = gwo == nothing ? gwod : gwo
				gho = gho == nothing ? ghod : gho
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
				if gw != nothing && gh != nothing
					Compose.set_default_graphic_size(gwod, ghod)
				end
				printerrormsg(errmsg)
				@warn("Gadfly failed!")
			end
			if gw != nothing && gh != nothing
				Compose.set_default_graphic_size(gwod, ghod)
			end
		end
	end

	function display(p::Compose.Context; gwo=nothing, gho=nothing, gw=gwo, gh=gho)
		if graphoutput
			if gw != nothing && gh != nothing
				gwod = Compose.default_graphic_width
				ghod = Compose.default_graphic_height
				gwo = gwo == nothing ? gwod : gwo
				gho = gho == nothing ? ghod : gho
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
				if gw != nothing && gh != nothing
					Compose.set_default_graphic_size(gwod, ghod)
				end
				printerrormsg(errmsg)
				@warn("Compose failed!")
			end
			if gw != nothing && gh != nothing
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

@doc """
Display image file

$(DocumentFunction.documentfunction(display;
argtext=Dict("filename"=>"image file name","p"=>"plotting object")))
""" display