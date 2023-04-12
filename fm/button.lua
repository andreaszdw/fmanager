-- --------------------------------------------------------
--
-- button.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local class = require("30log")
local widget = require("widget")

local button = class()

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function button:init(parent, label, eventFunction, x, y, width, height)

	-- this is the function for the button,
	-- it will call the function for the given function
	local function onEvent(event)
		if("ended" == event.phase) then 
			eventFunction(event)
		end
	end

	self.parent = parent
	self.theme = parent.theme
	self.label = label
	self.x = x or 0
	self.y = y or 0
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

	parent.view:insert(self.button)
end

-- --------------------------------------------------------
--
-- getHeight
--
-- --------------------------------------------------------
function button:getHeight() 
	return self.button.height 
end

-- --------------------------------------------------------
-- 
-- getWidth
--
-- --------------------------------------------------------
function button:getWidth() 
	return self.button.width 
end

-- --------------------------------------------------------
--
-- set position
--
-- --------------------------------------------------------
function button:setPosition(x, y)
	self.button.x = x 
	self.button.y = y 
end

-- --------------------------------------------------------
return button