-- --------------------------------------------------------
--
-- textfield.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local BaseWidget = require("fm.basewidget")
local widget = require("widget")
local utf8 = require( "plugin.utf8" )

local TextField = BaseWidget:extend()

-- forward declaration
local insideListener, outsideListener, onKey

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function TextField:init(parent, x, y, width, height, anchorX, anchorY)

	TextField.super.init(self, parent, x, y, width, height)

	w = width or self.theme.textField.width
	h = height or self.theme.textField.height
	aX = 0 or anchorX
	aY = 0 or anchorY

	self.rect = display.newRect(self.view, x, y, w, h)
	self.rect.strokeWidth = 2
	self.rect:setStrokeColor(unpack(self.theme.stroke))
	self.rect:setFillColor(unpack(self.theme.bg))
	self.rect.anchorX = aX

	local options = {
		parent = self.view,
		text = "",
		font = self.theme.font,
		fontSize = self.theme.fontSize
	}

	self.text = display.newText(options)
	self.text.anchorX = aX

	self.container = display.newContainer(w, h)
	self.container.anchorChildren = false
	self.container.anchorX = aX
	self.container:translate(x, y)
	self.container:insert(self.text)--, true)
	self.view:insert(self.container)

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
-- key event
--
-- --------------------------------------------------------
function TextField:keyListener(phase)

	-- firsttime
	if self.firstTime then
		onKey = function(event)
			if self.focus then
				if event.phase == "down" then
					local k = event.keyName
					print("ä = " .. utf8.codepoint("ä", 1, 1))
					print(utf8.char(event.nativeKeyCode) .. " " .. event.nativeKeyCode)

					self.text.text = self.text.text .. event.keyName
					if self.text.width > self.container.width then
						self.text.x = -(self.text.width - self.container.width)
					else
						self.text.x = 0
					end
				end
			end
		end
	end

	if phase == "show" then
		Runtime:addEventListener("key", onKey)
	end
	if phase == "hide" then
		Runtime:removeEventListener("key", onKey)
	end
end


-- --------------------------------------------------------
--
-- hide
-- 
-- --------------------------------------------------------
function TextField:hide()
	self:focusListener("hide")
	self:keyListener("hide")
end

-- --------------------------------------------------------
--
-- show 
--
-- --------------------------------------------------------
function TextField:show()
	self:focusListener("show")
	self:keyListener("show")
	self.firstTime = false
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