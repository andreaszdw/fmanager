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

	local bgRect = display.newRect(self.view, 0, 0, width, height)
	bgRect.strokeWidth = 2
	bgRect:setStrokeColor(unpack(self.theme.stroke))
	bgRect:setFillColor(unpack(self.theme.bg))
	bgRect.anchorX = 0
	bgRect.anchorY = 0
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