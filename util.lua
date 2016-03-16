--[[=============================
util.lua 
version 0.2
by NSP
=============================]]--
util = util or {}

-- Colors enums
color_white		= {255, 255, 255, 255}
color_black		= {0, 0, 0, 255}
color_debug		= {130, 130, 130, 230}
color_red		= {255, 0, 0, 255}
color_green		= {0, 255, 0, 255}
color_blue		= {0, 0, 255, 255}

--[[=============================
	Global functions
=============================]]--

-- Fast made 'Get/Set' functions
function AccessorFunc(tbl, var_name, func_name, default_value)
	tbl[var_name] = default_value
	tbl["Get"..func_name] = function(self) return self[var_name] end
	tbl["Set"..func_name] = function(self, var) self[var_name] = var end
end

-- Print full table
function PrintTable(t, iter, indent, done)
	done = done or {}
	indent = indent or 0

	for key, value in pairs(t) do
		local ind = string.rep("\t", indent)
 
		if type(value) == "table" and not done[value] and iter ~= 0 then
			done[value] = true
			
			print(ind..tostring(key)..":")
			PrintTable(value, iter and iter - 1 or nil, indent + 1, done)
		else
			print(ind..tostring(key).."\t"..tostring(value))
		end
	end
end

function FindMetaTable(name)
	return debug.getregistry()[name]
end

-- Screen sizes
function ScrW(mult)
	mult = mult or 1
--	return love.window.getWidth() * mult			-- for old version
	return love.graphics.getWidth() * mult	-- For version 0.10.0 [Super Toast]
end

function ScrH(mult)
	mult = mult or 1
--	return love.window.getHeight() * mult 		-- for old version
	return love.graphics.getHeight() * mult	-- For version 0.10.0 [Super Toast]
end

--[[=============================
	util functions
=============================]]--
function util.GetDirectoryContents(dir, recursion_tbl)
	local items = love.filesystem.getDirectoryItems(dir)
	local files = {}
	local dirs = {}
	
	for k, v in pairs(items) do
		if love.filesystem.isDirectory(dir.."/"..v) then
			table.insert(dirs, dir.."/"..v)
		else
			local ext = string.Explode(".", v)
			local name = ext[1]
			ext = ext[#ext]
			table.insert(files, {
				name = name,
				dir = dir.."/"..v,
				reqpart = dir:gsub("/", ".") .. "." ..name,
				ext = ext
			})
		end
	end
	
	return files, dirs
end