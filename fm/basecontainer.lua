-- --------------------------------------------------------
--
-- basecontainer.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local Class = require("fm.30log")
local widget = require("widget")

local Container = Class()

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function Container:init(parent, x, y, width, height)
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
-- destroy - clean up
--
-- --------------------------------------------------------
function Container:destroy()
end

-- --------------------------------------------------------
--
-- hide - hide it
--
-- --------------------------------------------------------
function Container:hide()
end

-- --------------------------------------------------------
--
-- show - it
--
-- --------------------------------------------------------
function Container:show()
end


-- --------------------------------------------------------
--
-- getView
--
-- --------------------------------------------------------
function Container:getView()
	return self.view
end

-- --------------------------------------------------------
--
-- getHeight
--
-- --------------------------------------------------------
function Container:getHeight() 
	return self.height 
end

-- --------------------------------------------------------
-- 
-- getWidth
--
-- --------------------------------------------------------
function Container:getWidth() 
	return self.width 
end

-- --------------------------------------------------------
--
-- set position
--
-- --------------------------------------------------------
function Container:setPosition(x, y)
	self.x = x 
	self.y = y 
end

-- --------------------------------------------------------
return Container