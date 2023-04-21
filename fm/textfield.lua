-- --------------------------------------------------------
--
-- textfield.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local BaseWidget = require("fm.basewidget")
local widget = require("widget")

local TextField = BaseWidget:extend()

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function TextField:init(parent, x, y, width, height)
	print("init")

	TextField.super.init(self, parent, x, y, width, height)

	w = width or self.theme.textField.width
	h = height or self.theme.textField.height

	self.rect = display.newRect(self.view, x, y, w, h)
	self.rect.strokeWidth = 2
	self.rect:setStrokeColor(unpack(self.theme.stroke))
	self.rect:setFillColor(unpack(self.theme.bg))

	self.focus = false
end

-- --------------------------------------------------------
--
-- focus listener
--
-- --------------------------------------------------------
function TextField:focusListener(phase)
	local function insideListener(event)
		self.focus = true
		print("true")
		return true
	end

	local function outsideListener(event)
		self.focus = false
		print("false")
	end

	if phase=="show" then
		print("in show")
		self.rect:addEventListener("tap", insideListener)
		Runtime:addEventListener("tap", outsideListener)
	end
	
	if phase=="hide" then
		print("in hide")
		print(self.rect:removeEventListener("tap", insideListener))
		print(Runtime:removeEventListener("tap", outsideListener))
	end
end

-- --------------------------------------------------------
--
-- hide
-- 
-- --------------------------------------------------------
function TextField:hide()
	self:focusListener("hide")
end

-- --------------------------------------------------------
--
-- show 
--
-- --------------------------------------------------------
function TextField:show()
	self:focusListener("show")
end

-- --------------------------------------------------------
--
-- getHeight
--
-- --------------------------------------------------------
function TextField:getHeight() 
	return self.rect.height 
end

-- --------------------------------------------------------
-- 
-- getWidth
--
-- --------------------------------------------------------
function TextField:getWidth() 
	return self.rect.width 
end

-- --------------------------------------------------------
--
-- set position
--
-- --------------------------------------------------------
function TextField:setPosition(x, y)
	self.rect.x = x 
	self.rect.y = y 
end

-- --------------------------------------------------------
return TextField