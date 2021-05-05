--
-- singletext.lua
--
--
-- andreaszdw@googlemail.com
-- --------------------------------------------------------
local widget = require("widget")

local singleText = {}

--
-- constructor
-- --------------------------------------------------------
function singleText:new(parent, label, x, y, fontSize, font)

	local o = {
		parent = parent,
		theme = parent.theme,
		label = label or " ",
		x = x or 0,
		y = y or 0,
		fontSize = fontSize or 14,
		font = font or parent.theme.font
	}

	o.text = display.newText(o.parent.view, o.label, o.x, o.y, o.font, o.fontSize)
	o.text:setFillColor(unpack(o.theme.label))

	setmetatable(o, self)
	self.__index = self
	return o
end

--
-- get height
-- --------------------------------------------------------
function singleText:getHeight()
	return self.text.height 
end

-- --------------------------------------------------------
return singleText