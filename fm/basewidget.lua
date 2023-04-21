-- --------------------------------------------------------
--
-- basewidget.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local Class = require("fm.30log")
local widget = require("widget")

local Base = Class()

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function Base:init(parent, x, y, width, height)
	self.parent = parent
	self.view = parent.view
	self.theme = parent.theme
	self.x = x or 0
	self.y = y or 0
	self.width = width or 10
	self.height = height or 10
end

-- --------------------------------------------------------
--
-- destroy - clean up
--
-- --------------------------------------------------------
function Base:destroy()
end

-- --------------------------------------------------------
--
-- hide - hide it
--
-- --------------------------------------------------------
function Base:hide()
end

-- --------------------------------------------------------
--
-- show - it
--
-- --------------------------------------------------------
function Base:show()
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