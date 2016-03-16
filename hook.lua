--[[========
hook.lua 
version 0.2
by NSP
=======]]--
local hooks = {}
hook = {}

function hook.Add(event_name, name, callback)
	if not event_name then return end
	if not name then return end
	if not callback then return end
	if not hooks[event_name] then 
		hooks[event_name] = {}
	end
	hooks[event_name][name] = callback
end

function hook.Remove(event_name, name)
	if not event_name then return end
	if not name then return end
	if not hooks[event_name] then return end
	hooks[event_name][name] = nil
end

function hook.Call(event_name, ...)
	if not hooks[event_name] then return end
	
	local a, b, c, d, e, f, g
	
	for _, callback in pairs(hooks[event_name]) do
		a, b, c, d, e, f, g = callback(...)
		
		if a then 
			return a, b, c, d, e, f, g -- exit from loop
		end
	end
end

function hook.GetTable()
	return hooks
end