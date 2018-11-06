import Images

function madsgetextension(filename)
	d = split(filename, "/")
	s = split(d[end], ".")
	if length(s) > 1
		return s[end]
	else
		return ""
	end
end

function madsgetrootname(filename::String; first=true)
	d = split(filename, "/")
	s = split(d[end], ".")
	if !first && length(s) > 1
		r = join(s[1:end-1], ".")
	else
		r = s[1]
	end
	if length(d) > 1
		r = join(d[1:end-1], "/") * "/" * r
	end
	return r
end

function madsdisplay(filename::String)
	if !isfile(filename)
		@warn("File `$filename` is missing!")
		return
	end
	if isdefined(Main, :TerminalExtensions)
		trytoopen = false
		ext = lowercase(madsgetextension(filename))
		if ext == "svg"
			root = madsgetrootname(filename)
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