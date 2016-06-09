"Tag Mads modules"
function checkout()
	for i in madsmodules
		Pkg.checkout(i)
	end
end

function status()
	for i in madsmodules
		Pkg.status(i)
	end
end

"Tag Mads modules"
function tag()
	for i in madsmodules
		Pkg.checkout(i)
	end
end
