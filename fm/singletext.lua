-- --------------------------------------------------------
--
-- singletext.lua
--
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local widget = require("widget")

local singleText = {}

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function singleText:new(parent, label, x, y, fontSize, font)

	local theme = require("fm.theme")

	local o = {
		parent = parent,
		theme = parent.theme or theme,
		label = label or " ",
		x = x or 0,
		y = y or 0,
		fontSize = fontSize or 14,
		font = font or theme.font
	}

	local view = parent.view or parent 

	o.text = display.newText(view, o.label, o.x, o.y, o.font, o.fontSize)
	o.text:setFillColor(unpack(o.theme.label))

	setmetatable(o, self)
	self.__index = self
	return o
end
-- --------------------------------------------------------
--
-- setFillColor
-- 
-- --------------------------------------------------------
function singleText:setFillColor(color)
	self.text:setFillColor(unpack(color))
end

-- --------------------------------------------------------
--
-- get height
--
-- --------------------------------------------------------
function singleText:getHeight()
	return self.text.height 
end

-- --------------------------------------------------------
--
-- set anchor
--
-- --------------------------------------------------------
function singleText:setAnchor(x, y)
	self.text.anchorX = x 
	self.text.anchorY = y 
end

-- --------------------------------------------------------
return singleText