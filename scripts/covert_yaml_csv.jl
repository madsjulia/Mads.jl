for n in keys(m["Wells"])
	x = m["Wells"]["$n"]["x"]
	y = m["Wells"]["$n"]["y"]
	z0 = m["Wells"]["$n"]["z0"]
	z1 = m["Wells"]["$n"]["z1"]
	o = m["Wells"]["$n"]["obs"]
	for i = eachindex(o)
		c = o[i]["c"]
		t = o[i]["t"]
		println("$n, $x, $y, $z0, $t, $c")
	end
end
