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

-- forward declaration
local insideListener, outsideListener

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function TextField:init(parent, x, y, width, height)

	TextField.super.init(self, parent, x, y, width, height)

	w = width or self.theme.textField.width
	h = height or self.theme.textField.height

	self.rect = display.newRect(self.view, x, y, w, h)
	self.rect.strokeWidth = 2
	self.rect:setStrokeColor(unpack(self.theme.stroke))
	self.rect:setFillColor(unpack(self.theme.bg))

	self.focus = false

	self.firstTime = true
end

-- --------------------------------------------------------
--
-- focus listener
--
-- --------------------------------------------------------
function TextField:focusListener(phase)

	-- this is for one time initailiztion
	if self.firstTime then

		insideListener = function(event)
			self.focus = true
			self.rect:setStrokeColor(unpack(self.theme.strokeFocus))
			return true
		end

		function outsideListener(event)
			self.focus = false
			self.rect:setStrokeColor(unpack(self.theme.stroke))
		end
	end
	self.firstTime = false

	if phase=="show" then
		self.rect:addEventListener("tap", insideListener)
		Runtime:addEventListener("tap", outsideListener)
	end

	if phase=="hide" then
		self.rect:removeEventListener("tap", insideListener)
		Runtime:removeEventListener("tap", outsideListener)
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