import Images

"""
Display image file
"""
function display(filename::String)
	if !isfile(filename)
		warn("File `$filename` is missing!")
		return
	end
	if isdefined(:TerminalExtensions)
		trytoopen = false
		ext = lowercase(Mads.getextension(filename))
		if ext == "svg"
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
			rm(filename2)
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
				warn("Do not know how to open `$filename`")
			end
		end
	end
end