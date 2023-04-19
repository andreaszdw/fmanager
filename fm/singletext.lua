-- --------------------------------------------------------
--
-- singletext.lua
--
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local BaseWidget = require("fm.basewidget")
local widget = require("widget")

local SingleText = BaseWidget:extend()

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function SingleText:init(parent, label, x, y, fontSize, font)

	SingleText.super.init(self, parent, x, y)

	-- this is for table render needed
	local theme = require("fm.theme")
	self.theme = parent.theme or theme

	self.label = label or " "
	self.x = x or 0
	self.y = y or 0
	self.fontSize = fontSize or 14
	self.font = font or theme.font

	-- this is for table render needed
	local view = parent.view or parent -- if for table row render
	
	self.text = display.newText(
		view, self.label, self.x, self.y, self.font, self.fontSize)
	self.text:setFillColor(unpack(self.theme.label))
end
-- --------------------------------------------------------
--
-- setFillColor
-- 
-- --------------------------------------------------------
function SingleText:setFillColor(color)
	self.text:setFillColor(unpack(color))
end

-- --------------------------------------------------------
--
-- get height
--
-- --------------------------------------------------------
function SingleText:getHeight()
	return self.text.height 
end

-- --------------------------------------------------------
--
-- set anchor
--
-- --------------------------------------------------------
function SingleText:setAnchor(x, y)
	self.text.anchorX = x 
	self.text.anchorY = y 
end

-- --------------------------------------------------------
return SingleText