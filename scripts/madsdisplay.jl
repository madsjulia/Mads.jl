import Images

function madsdisplay(filename::AbstractString)
	if !isfile(filename)
		@warn("File `$filename` is missing!")
		return
	end
	if isdefined(Main, :TerminalExtensions)
		trytoopen = false
		root, ext = splitext(filename)
		ext = lowercase(ext)
		if ext == "svg"
			filename2 = root * ".png"
			try
				run(`convert -density 90 -background none $filename $filename2`)
				img = Images.load(filename2)
				Base.display(img)
			catch
				trytoopen = true
			end
			if isfile(filename2)
				rm(filename2)
			end
		else
			img = Images.load(filename)
			Base.display(img)
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
				@warn("Do not know how to open $filename")
			end
		end
	end
end