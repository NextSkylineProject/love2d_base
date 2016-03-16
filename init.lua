--[[=============================
init.lua
version 0.2
by SkyAngeLoL
NextSkylineProject (NSP)
=============================]]--
love2d_base = {}
love2d_base.folder = ...
love2d_base.libs = {
	"util",
	"color",
	"math",
	"table",
	"string",
	"hook",
	"events",
	"info",
	"camera",
	"anim8", -- not my lib
--	"vgui"
}

--[[ Load libs list ]]--
for _, lib in pairs(love2d_base.libs) do
	require(love2d_base.folder..'/'..lib)
end

--[[ Shortcuts ]]--
surface	= love.graphics
keyboard= love.keyboard
phys	= love.physics
mouse	= love.mouse
window	= love.window
fs		= love.filesystem

--[[*****************
******Help info******
*********************

Draw hooks levels
	1	"PreDraw"
	2	"DrawWorld"
	3	"Draw"
	4	"draw"
	5	"DrawLevel1"
	6	"DrawLevel2"
	7	"DrawLevel3"
	8	"DrawHUD"
	9	"PostDraw"

Functions and vars in 'love2d_base' module:
	util.lua
		FUNCTIONS:
			AccessorFunc(tbl, var_name, func_name, default_value) -- make fast 'Set/Get' functions
			PrintTable(tbl, iter)
			ScrW() -- Screen size
			ScrH() -- to
			util.GetDirectoryContents(dir)
			
		ENUMS:
			color_white
			color_black
			color_debug
		
		SHORTCUTS:
			surface	= love.graphics
			input	= love.keyboard
			phys	= love.physics
			mouse	= love.mouse
			window	= love.window
			fs		= love.filesystem

	hook.lua
		hook.Add(event_name, name, callback)
		hook.Remove(event_name, name)
		hook.Call(event_name, ...)
		hook.GetTable()
		
	events.lua
		Debug = true/false
	
]]--