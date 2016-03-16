--[[========
events.lua 
version 0.2
by NSP
=======]]--
local old_events = {}
local events = {
	"load",
--	"draw", -- this hook needed explode for levels  
	"focus",
	"update",
	"keypressed",
	"keyreleased",
	"mousepressed",
	"mousereleased",
	"mousefocus",
	"quit",
	"resize",
	"visible",
	"textinput",
--	"errhand",

--[[ joystick events
	"gamepadaxis",
	"gamepadpressed",
	"gamepadreleased",
	"joystickadded",
	"joystickaxis",
	"joystickhat",
	"joystickpressed",
	"joystickreleased",
	"joystickremoved"
--]]--
}

local function MakeHookEvents()
	for _, event_name in pairs(events) do
		old_events[event_name] = love[event_name]
		
		love[event_name] = function(...)
			if old_events[event_name] then
				old_events[event_name](...)
			end
			
			hook.Call(event_name, ...)
		end
	end
	
	old_events["draw"] = love.draw
	
	function love.draw(...)
		if old_events["draw"] then
			old_events["draw"](...)
		end
		
		hook.Call("predraw",	...)
		hook.Call("drawworld",	...)
		hook.Call("draw",		...)
		hook.Call("drawlevel1",	...)
		hook.Call("drawlevel2",	...)
		hook.Call("drawlevel3",	...)
		hook.Call("drawHUD",	...)
		hook.Call("postdraw",	...)
	end
end

function love.load()
	MakeHookEvents()
	
	hook.Call("load")
end