-- --------------------------------------------------------
--
-- panel.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local BaseContainer = require("fm.basecontainer")
local widget = require("widget")

local Panel = BaseContainer:extend()

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function Panel:init(parent, x, y, width, height)
	
	Panel.super.init(self, parent, x, y, width, height)

	self.bgRect = display.newRect(self.view, 0, 0, width, height)
	self.bgRect.strokeWidth = 2
	self.bgRect:setStrokeColor(unpack(self.theme.stroke))
	self.bgRect:setFillColor(unpack(self.theme.bg))
	self.bgRect.anchorX = 0
	self.bgRect.anchorY = 0
end

-- --------------------------------------------------------
--
-- setFillColor
--
-- --------------------------------------------------------
function Panel:setFillColor(r, g, b, a)
	self.bgRect:setFillColor(r, g, b, a or 1)
end

-- --------------------------------------------------------
--
-- setStrokeColor
--
-- --------------------------------------------------------
function Panel:setStrokeColor(r, g, b, a)
	self.bgRect:setStrokeColor(r, g, b, a or 1)
end

-- --------------------------------------------------------
--
-- setStrokeWidth
--
-- --------------------------------------------------------
function Panel:setStrokeWidth(w)
	self.bgRect.strokeWidth = w or 2
end

-- --------------------------------------------------------
--
-- getView
--
-- --------------------------------------------------------
function Panel:getView()
	return self.view
end

-- --------------------------------------------------------
--
-- getHeight
--
-- --------------------------------------------------------
function Panel:getHeight() 
	return self.height 
end

-- --------------------------------------------------------
-- 
-- getWidth
--
-- --------------------------------------------------------
function Panel:getWidth() 
	return self.width 
end

-- --------------------------------------------------------
--
-- set position
--
-- --------------------------------------------------------
function Panel:setPosition(x, y)
	self.x = x 
	self.y = y 
end

-- --------------------------------------------------------
return Panel