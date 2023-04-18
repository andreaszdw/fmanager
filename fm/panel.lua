-- --------------------------------------------------------
--
-- panel.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local BaseWidget = require("basewidget")
local widget = require("widget")

local Panel = BaseWidget:extend()

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function Panel:init(parent, x, y, width, height)

	Panel.super.init(self, parent, x, y, width, height)

	--[[self.parent = parent
	self.theme = parent.theme
	self.view = display.newGroup()
	self.view.x = x
	self.view.y = y
	self.x = x or 0
	self.y = y or 0
	self.width = width or 10
	self.height = height or 10]]--

	local bgRect = display.newRect(self.view, 0, 0, width, height)
	bgRect.strokeWidth = 2
	bgRect:setStrokeColor(unpack(self.theme.stroke))
	bgRect:setFillColor(unpack(self.theme.bg))
	bgRect.anchorX = 0
	bgRect.anchorY = 0

	--self.parent.view:insert(self.view)

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