--[[
math.lua
version 0.1
]]--

function math.Clamp(var, min, max)
	--return x < min and min or (x > max and max or x)
	if var < min then return min end
	if var > max then return max end
	
	return var
end

function math.Rand(low, high, idp)
	local num = low + (high - low) * math.random()
	
	if idp then
		num = math.Round(num, idp)
	end
	
	return num
end

function math.Approach(cur, target, inc)
	inc = math.abs(inc)

	if cur < target then
		return math.Clamp(cur + inc, cur, target)
	elseif cur > target then
		return math.Clamp(cur - inc, target, cur)
	end
	
	return target
end

function math.Inrange(a, min, max)
	return a >= min and a <= max
end

function math.Round(num, idp)
	local mult = 10^(idp or 0)
	
	return math.floor(num * mult + 0.5) / mult
end

function math.NormalizeAngle(a)
	return (a + 180) % 360 - 180
end

function math.Dist(x1, y1, x2, y2)
	local xd = x2 - x1
	local yd = y2 - y1
	
	return math.sqrt(xd * xd + yd * yd)
end

function math.GetMax(var_tbl)
	local max = 0
	
	for _, v in pairs(var_tbl) do
		if v >= max then
			max = v
		end
	end
	
	return max
end

function math.GetMin(var_tbl)
	local min = 0
	
	for _, v in pairs(var_tbl) do
		if v <= min then
			min = v
		end
	end
	
	return min
end