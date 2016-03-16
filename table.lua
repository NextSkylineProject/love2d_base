--[[---------------------------------------------------------
	Name: Copy(t, lookup_table)
	Desc: Taken straight from http://lua-users.org/wiki/PitLibTablestuff
		  and modified to the new Lua 5.1 code by me.
		  Original function by PeterPrade!
-----------------------------------------------------------]]
function table.Copy(t, lookup_table)
	if t == nil then return nil end

	local copy = {}
	
	setmetatable(copy, debug.getmetatable(t))
	
	for i, v in pairs(t) do
		if type(v) ~= "table" then
			copy[i] = v
		else
			lookup_table = lookup_table or {}
			lookup_table[t] = copy
					
			if lookup_table[v] then
				copy[i] = lookup_table[v] -- we already copied this table. reuse the copy.
			else
				copy[i] = table.Copy(v, lookup_table) -- not yet copied. copy it.
			end
		end
	end
	
	return copy
end

--[[---------------------------------------------------------
   Name: Inherit(tbl, base)
   Desc: Copies any missing data from base to tbl
-----------------------------------------------------------]]
function table.Inherit(tbl, base)
	for k, v in pairs(base) do 
		if tbl[k] == nil then tbl[k] = v end
	end
	
	tbl["_baseClass"] = base
	
	return tbl
end

--[[---------------------------------------------------------
	Name: Empty(tbl)
	Desc: Empty a table
-----------------------------------------------------------]]
function table.Empty(tbl)
	for k, v in pairs(tbl) do
		tbl[k] = nil
	end
end

--[[---------------------------------------------------------
   Name: Merge()
   Desc: xx
-----------------------------------------------------------]]
function table.Merge(dest, source)
	for k, v in pairs(source) do
		if type(v) == "table" and type(dest[k]) == "table" then
			-- don't overwrite one table with another;
			-- instead merge them recurisvely
			table.Merge(dest[k], v)
		else
			dest[k] = v
		end
	end
	
	return dest
end

--[[---------------------------------------------------------
	Name: CopyFromTo( FROM, TO )
	Desc: Make TO exactly the same as FROM - but still the same table.
-----------------------------------------------------------]]
function table.CopyFromTo(from, to)
	-- Erase values from table TO
	table.Empty(to)
	
	-- Copy values over
	table.Merge(to, from)
end

--[[---------------------------------------------------------
   Name: HasValue(tbl, val)
   Desc: xx
-----------------------------------------------------------]]
function table.HasValue(tbl, val)
	for k, v in pairs(tbl) do
		if v == val then return true end
	end
	
	return false
end

--[[---------------------------------------------------------
   Name: table.Count( table )
   Desc: Returns the number of keys in a table
-----------------------------------------------------------]]
function table.Count(tbl)
	local i = 0
	
	for k in pairs(tbl) do i = i + 1 end
	
	return i
end

--[[----------------------------------------------------------------------
   Name: table.IsSequential(table)
   Desc: Returns true if the tables 
   keys are sequential
-------------------------------------------------------------------------]]
function table.IsSequential(t)
	local i = 1
	
	for key, value in pairs (t) do
		if not tonumber(i) or key ~= i then return false end
		
		i = i + 1
	end
	
	return true
end
--[[---------------------------------------------------------
   Name: xx
   Desc: xx
-----------------------------------------------------------]]
function table.HasValue(t, val)
	for k, v in pairs(t) do
		if v == val then return true end
	end
	
	return false
end

--[[

]]
function table.KeyFromValue(tbl, val)
	for key, value in pairs(tbl) do
		if value == val then return key end
	end
	
	return 0
end
--[[

]]
function table.PushToTop(tbl, value)	
	return table.insert(tbl, value)
end

function table.PushToDown(tbl, value)
	local temp = table.Copy(tbl)
	
	table.Empty(tbl)
	
	table.insert(tbl, value)
	
	for k, v in pairs(temp) do
		table.insert(tbl, v)
	end
	
	return tbl
end

function table.PushToDownRep(tbl, value)
	tbl[table.KeyFromValue(value)] = nil
	
	return table.PushToDown(tbl, value)
end
--[[---------------------------------------------------------
   Name: table.ToString(table, name, nice)
   Desc: Convert a simple table to a string
		table = the table you want to convert (table)
		name  = the name of the table (string)
		nice  = whether to add line breaks and indents (bool)
-----------------------------------------------------------]]
function table.ToString(t, n, nice)
	local nl, tab  = "",  ""
	if nice then nl, tab = "\n", "\t" end

	local function MakeTable(t, nice, indent, done)
		local str = ""
		local done = done or {}
		local indent = indent or 0
		local idt = ""
		if nice then idt = string.rep("\t", indent) end

		local sequential = table.IsSequential(t)

		for key, value in pairs(t) do

			str = str .. idt .. tab .. tab

			if not sequential then
				if type(key) == "number" or type(key) == "boolean" then 
					key ='['..tostring(key)..']' ..tab..'='
				else
					key = tostring(key) ..tab..'='
				end
			else
				key = ""
			end

			if istable(value) and not done [value] then
				done [value] = true
				str = str .. key .. tab .. '{' .. nl
				.. MakeTable (value, nice, indent + 1, done)
				str = str .. idt .. tab .. tab ..tab .. tab .."},".. nl
			else
				if 	type(value) == "string" then 
					value = '"'..tostring(value)..'"'
				elseif  type(value) == "Vector" then
					value = 'Vector('..value.x..','..value.y..','..value.z..')'
				elseif  type(value) == "Angle" then
					value = 'Angle('..value.pitch..','..value.yaw..','..value.roll..')'
				else
					value = tostring(value)
				end
				
				str = str .. key .. tab .. value .. ",".. nl

			end
		end
		return str
	end
	
	local str = ""
	if n then str = n .. tab .. "=" .. tab end
	str = str .. "{" .. nl .. MakeTable(t, nice) .. "}"
	
	return str
end