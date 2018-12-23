if !haskey(ENV, "MADS_NO_GADFLY")
	@Mads.tryimport Gadfly
	@Mads.tryimport Compose
end
@Mads.tryimport Images

function display(filename::String)
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

if isdefined(Mads, :Gadfly)
	function display(p::Gadfly.Plot)
		if graphoutput
			Gadfly.draw(Gadfly.PNG(), p)
			print("\r")
		end
	end
	function display(p::Compose.Context)
		if graphoutput
			Compose.draw(Compose.PNG(), p)
			print("\r")
		end
	end
end

@doc """
Display image file

$(DocumentFunction.documentfunction(display;
argtext=Dict("filename"=>"image file name","p"=>"plotting object")))
""" display