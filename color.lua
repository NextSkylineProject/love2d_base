--[[========
color.lua 
version 0.1
by NSP
=======]]--

function Color(r, g, b, a)
	r = r or 255
	g = g or r
	b = b or r
	a = a or 255
	
	return {math.Clamp(r, 0, 255),
			math.Clamp(g, 0, 255),
			math.Clamp(b, 0, 255), 
			math.Clamp(a, 0, 255)
		}
end

function ColorRandom(min, max)
	return Color(math.Rand(min, max), math.Rand(min, max), math.Rand(min, max))
end