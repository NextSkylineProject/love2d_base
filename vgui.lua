--[[=============================
vgui.lua
version 0.2
use loveframes(http://nikolairesokav.com/)
=============================]]--
local HOOK_NAME = "vgui_event"
vgui = require("base/nextframes")

hook.Add("update", HOOK_NAME, function(dt) vgui.update(dt) end)
hook.Add("drawHUD", HOOK_NAME, function() vgui.draw() end)
hook.Add("mousepressed", HOOK_NAME, function(x, y, button, ...)  vgui.mousepressed(x, y, button, ...) end)
hook.Add("mousereleased", HOOK_NAME, function(x, y, button, ...) vgui.mousereleased(x, y, button, ...) end)
hook.Add("keypressed", HOOK_NAME, function(key, unicode, ...) vgui.keypressed(key, unicode, ...) end)
hook.Add("keyreleased", HOOK_NAME, function(key, ...) vgui.keyreleased(key, ...) end)
hook.Add("textinput", HOOK_NAME, function(text, ...) vgui.textinput(text, ...) end)

--[[
Spaaaaam
]]--
