--[[---------------------------------------------------------
   Name: string.ToTable( string )
-----------------------------------------------------------]]
function string.ToTable(str)
	local tbl = {}
	
	for i = 1, string.len(str) do
		tbl[i] = string.sub(str, i, i)
	end
	
	return tbl
end

--[[---------------------------------------------------------
   Name: explode(seperator ,string)
   Desc: Takes a string and turns it into a table
   Usage: string.explode( " ", "Seperate this string")
-----------------------------------------------------------]]
local totable = string.ToTable
local string_sub = string.sub
local string_gsub = string.gsub
local string_gmatch = string.gmatch
function string.Explode(separator, str, withpattern)
	if (separator == "") then return totable( str ) end
	 
	local ret = {}
	local index,lastPosition = 1,1
	 
	-- Escape all magic characters in separator
	if not withpattern then separator = string_gsub( separator, "[%-%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%1" ) end
	 
	-- Find the parts
	for startPosition,endPosition in string_gmatch( str, "()" .. separator.."()" ) do
		ret[index] = string_sub( str, lastPosition, startPosition-1)
		index = index + 1
		 
		-- Keep track of the position
		lastPosition = endPosition
	end
	 
	-- Add last part by using the position we stored
	ret[index] = string_sub( str, lastPosition)
	return ret
end

--[[---------------------------------------------------------
   Name: Implode(seperator ,Table)
   Desc: Takes a table and turns it into a string
   Usage: string.Implode( " ", {"This", "Is", "A", "Table"})
-----------------------------------------------------------]]

function string.Implode(seperator,Table) return 
	table.concat(Table,seperator) 
end

--[[

--]]
function string.Left(str, num)
	return string.sub(str, 1, num)
end

function string.Right(str, num)
	return string.sub(str, -num)
end

function string.Replace(str, tofind, toreplace)
	tofind = tofind:gsub("[%-%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%1")
	toreplace = toreplace:gsub("%%", "%%%1")
	return str:gsub(tofind, toreplace) 
end

--[[---------------------------------------------------------
   Name: Trim(s)
   Desc: Removes leading and trailing spaces from a string.
		 Optionally pass char to trim that character from the ends instead of space
-----------------------------------------------------------]]
function string.Trim(s, char)
	if not char then char = "%s" end
	return s:gsub("^"..char.."*(.-)"..char.."*$", "%1")
end

--[[---------------------------------------------------------
   Name: TrimRight(s)
   Desc: Removes trailing spaces from a string.
		 Optionally pass char to trim that character from the ends instead of space
-----------------------------------------------------------]]
function string.TrimRight(s, char)
	if not char then char = " " end
	
	if string.sub(s, -1) == char then
		s = string.sub(s, 0, -2)
		s = string.TrimRight(s, char)
	end
	
	return s
end

--[[---------------------------------------------------------
   Name: TrimLeft(s)
   Desc: Removes leading spaces from a string.
		 Optionally pass char to trim that character from the ends instead of space
-----------------------------------------------------------]]
function string.TrimLeft(s, char)
	if not char then char = " " end
	
	if string.sub(s, 1) == char then
		s = string.sub(s, 1)
		s = string.TrimLeft(s, char)
	end
	
	return s
end


local meta = getmetatable("string")

function meta:__index(key)
	if string[key] then
		return string[key]
	elseif tonumber(key) then
		return self:sub(key, key)
	else
		error("bad key to string index (number expected, got "..type(key)..")", 2)
	end
end