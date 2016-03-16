--[[=============================
camera.lua
version 0.2
by NSP
=============================]]--
local camera = {}
camera.__index = camera
camera.__tostring = function(self) return "camera["..self.x..","..self.y..","..self.rotation.."]" end
camera.__concat = function(self) return tostring(self) end

debug.getregistry()["camera"] = camera
local old_global_type = type
type = function(var, ...)
	if getmetatable(var) == camera then return "camera" end
	return old_global_type(var, ...)
end

--[[=============================
	Main functions
=============================]]--
function camera:Init()
	self.x = 1
	self.y = 1
	self.scalex = 1
	self.scaley = 1
	self.minScale = 0.1
	self.maxScale = 1000
	self.rotation = 0
end

function camera:push()
	love.graphics.push()
	love.graphics.rotate(-self.rotation)
	love.graphics.scale(1 / self.scalex, 1 / self.scaley)
	love.graphics.translate(-self.x, -self.y)
end

function camera:pop()
	love.graphics.pop()
end

--[[=============================
	Rotation functions
=============================]]--
function camera:Rotate(dr)
	self.rotation = self.rotation + dr
end

--[[=============================
	Position functions
=============================]]--
function camera:SetX(x)
	if self.bounds then
		self.x = math.Clamp(x, self.bounds.x1, self.bounds.x2)
	else
		self.x = x
	end
end

function camera:SetY(y)
	if self.bounds then
		self.y = math.Clamp(y, self.bounds.y1, self.bounds.y2)
	else
		self.y = y
	end
end

function camera:SetPos(x, y)
	if x then self:SetX(x) end
	if y then self:SetY(y) end
end

function camera:SetPosCenter(x, y)
	self:SetPos(x - ScrW(self.scalex) * 0.5, y - ScrH(self.scaley) * 0.5)
end

function camera:Move(dx, dy)
	self:SetX(self.x + (dx or 0))
	self:SetY(self.y + (dy or 0))
end

function camera:GetPos()
	return self.x, self.y
end

--[[=============================
	Scaling functions
=============================]]--
local function _checkScale(self)
	self.scalex = math.Clamp(self.scalex, self.minScale, self.maxScale)
	self.scaley = math.Clamp(self.scaley, self.minScale, self.maxScale)
end

function camera:SetScale(x, y)
	self.scalex = x or self.scalex
	self.scaley = y or self.scalex
end

function camera:Scale(sx, sy)
	sx = sx or 1
	sy = sy or sx
	
	self:SetScale(self.scalex * sx, self.scaley * sy)
	_checkScale(self)
end

function camera:Zoom(z)
	self.scalex = self.scalex + z
	self.scaley = self.scaley + z
	_checkScale(self)
end

--[[=============================
	Bounding functions
=============================]]--
function camera:SetBounds(x1, y1, x2, y2)
	self.bounds = {x1 = x1, y1 = y1,
					x2 = x2, y2 = y2}
end

function camera:GetBounds()
	return unpack(self.bounds)
end

--[[=============================
	return to global
=============================]]--
cam = {
	new = function(x, y) 
		local c = setmetatable({x = x or 0, y = y or 0}, camera)
		c:Init()
		return c
	end
}