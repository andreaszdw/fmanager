-- --------------------------------------------------------
--
-- button.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local widget = require("widget")

local button = {}

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function button:new(parent, label, eventFunction, x, y, width, height)

	-- this is the function for the button,
	-- it will call the function for the given function
	local function onEvent(event)
		if("ended" == event.phase) then 
			eventFunction(event)
		end
	end

	local o = {
		parent = parent,
		theme = parent.theme,
		label = label,
		x = x or 0,
		y = y or 0,
		width = width or parent.theme.button.width,
		height = height or parent.theme.button.height
	}

	o.button = widget.newButton(
	{
		label = o.label,
		onEvent = onEvent,
		emboss = false,
		shape = "roundedRect",
		width = o.width,
		height = o.height,
		cornerRadius = o.theme.button.cornerRadius,
		labelColor = o.theme.button.labelColor,
		fillColor = o.theme.button.fillColor,
		strokeColor = o.theme.button.strokeColor,
		strokeWidth = o.theme.button.strokeWidth,
		font = o.theme.font
	})

	o.button.x = x 
	o.button.y = y 

	parent.view:insert(o.button)

	setmetatable(o, self)
	self.__index = self
	return o
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