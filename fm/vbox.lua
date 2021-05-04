--
-- vbox.lua
--
-- andreaszdw@googlemail.com
-- --------------------------------------------------------
local vbox = {}

--
-- constructor
-- --------------------------------------------------------
function vbox:new(parent, valign, halign, vgap, hgap)
	local o = {
		parent = parent,
		valign = valign or "top",
		halign = halign or "center",
		vgap = vgap or 0,
		hgap = hgap or 0,
		x = 0,
		y = 0,
		nextX = 0,
		nextY = 0,
		width = 0,
		height = 0,
		elements = {}
	}

	setmetatable(o, self)
	self.__index = self
	return o
end

--
-- add element
-- --------------------------------------------------------
function vbox:add(element)
	table.insert(self.elements, element)
	if self.valign == "top" then 
		element:setY(self.y + self.nextY + element:getHeight() * 0.5 + self.vgap)
	end
end

-----------------------------------------------------------
return vbox