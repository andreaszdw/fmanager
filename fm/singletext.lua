-- --------------------------------------------------------
--
-- singletext.lua
--
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local class = require("30log")
local widget = require("widget")

local singleText = class()

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function singleText:init(parent, label, x, y, fontSize, font)

	local theme = require("fm.theme")

	self.parent = parent
	self.theme = parent.theme or theme
	self.label = label or " "
	self.x = x or 0
	self.y = y or 0
	self.fontSize = fontSize or 14
	self.font = font or theme.font

	local view = parent.view or parent 

	self.text = display.newText(
		view, self.label, self.x, self.y, self.font, self.fontSize)
	self.text:setFillColor(unpack(self.theme.label))
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