--[[========
info.lua 
version 0.1
by NSP
=======]]--
info = info or {}
info.x = 0
info.y = 0
info.infolist = {}
info.show = true

local lg = love.graphics
local smallfont = lg.newFont(10)
local function formate(txt)
	if txt == nil then
		return ""
	end
	return tostring(txt).."\t"
end

function info.add(callback, name)
	name = name or #info.infolist
	table.insert(info.infolist, {name = name, callback = callback})
end

function info.draw()
	if not info.show then return end
	
	lg.setFont(smallfont)
	lg.setColor(130, 130, 130, 255)
	
	for k, v in ipairs(info.infolist) do
		local a, b, c, d, i = v.callback()
		local indent = string.rep("\n", k - 1)
		local text = indent..v.name.."\t"..formate(a)..formate(b)..formate(c)..formate(d)..formate(i)
		
		lg.print(text, info.x, info.y)
	end
end

hook.Add("postdraw", "info", info.draw)

-- Standart info
info.add(function() return love.timer.getFPS() end, "FPS")
info.add(function() return love.mouse.getX(), love.mouse.getY() end, "Mouse")