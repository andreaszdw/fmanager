-- --------------------------------------------------------
--
-- button.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local BaseWidget = require("basewidget")
local widget = require("widget")

local Button = BaseWidget:extend()

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function Button:init(parent, label, eventFunction, x, y, width, height)

	Button.super.init(self, parent, x, y, width, height)

	-- this is the function for the button,
	-- it will call the function for the given function
	local function onEvent(event)
		if("ended" == event.phase) then 
			eventFunction(event)
		end
	end

	self.label = label
	self.width = width or parent.theme.button.width
	self.height = height or parent.theme.button.height


	self.button = widget.newButton(
	{
		label = self.label,
		onEvent = onEvent,
		emboss = false,
		shape = "roundedRect",
		width = self.width,
		height = self.height,
		cornerRadius = self.theme.button.cornerRadius,
		labelColor = self.theme.button.labelColor,
		fillColor = self.theme.button.fillColor,
		strokeColor = self.theme.button.strokeColor,
		strokeWidth = self.theme.button.strokeWidth,
		font = self.theme.font
	})

	self.button.x = x 
	self.button.y = y 

	self.view:insert(self.button)
end

-- --------------------------------------------------------
--
-- getHeight
--
-- --------------------------------------------------------
function Button:getHeight() 
	return self.button.height 
end

-- --------------------------------------------------------
-- 
-- getWidth
--
-- --------------------------------------------------------
function Button:getWidth() 
	return self.button.width 
end

-- --------------------------------------------------------
--
-- set position
--
-- --------------------------------------------------------
function Button:setPosition(x, y)
	self.button.x = x 
	self.button.y = y 
end

-- --------------------------------------------------------
return Button