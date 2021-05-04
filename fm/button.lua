--
-- button.lua
--
-- andreaszdw@googlemail.com
-- --------------------------------------------------------
local widget = require("widget")

local button = {}

--
-- constructor
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

	if o.x == "right" then 
		o.button.x = display.pixelWidth - o.button.width*0.5 - 10
	elseif o.x == "left" then 
		o.button.x = 0 + o.button.width*0.5 + 10
	elseif o.x == "center" then 
		o.button.x = display.pixelWidth * 0.5
	else
		o.button.x = o.x
	end

	if o.y == "bottom" then 
		o.button.y = display.pixelHeight - o.button.height*0.52 - 10
	elseif o.y == "top" then 
		o.button.y = 0 + o.button.height * 0.5 + 10
	else
		o.button.y = o.y 
	end

	parent.view:insert(o.button)

	setmetatable(o, self)
	self.__index = self
	return o
end

-----------------------------------------------------------
return button