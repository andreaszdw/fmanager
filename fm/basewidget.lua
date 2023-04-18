-- --------------------------------------------------------
--
-- basewidget.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local Class = require("30log")
local widget = require("widget")

local Base = Class()

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function Base:init(parent, x, y, width, height)
	print(x, y)
	self.parent = parent
	self.theme = parent.theme
	self.view = display.newGroup()
	self.view.x = x
	self.view.y = y
	self.x = x or 0
	self.y = y or 0
	self.width = width or 10
	self.height = height or 10

	self.parent.view:insert(self.view)
end

-- --------------------------------------------------------
--
-- getView
--
-- --------------------------------------------------------
function Base:getView()
	return self.view
end

-- --------------------------------------------------------
--
-- getHeight
--
-- --------------------------------------------------------
function Base:getHeight() 
	return self.height 
end

-- --------------------------------------------------------
-- 
-- getWidth
--
-- --------------------------------------------------------
function Base:getWidth() 
	return self.width 
end

-- --------------------------------------------------------
--
-- set position
--
-- --------------------------------------------------------
function Base:setPosition(x, y)
	self.x = x 
	self.y = y 
end

-- --------------------------------------------------------
return Base