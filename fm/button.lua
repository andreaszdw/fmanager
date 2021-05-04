--
-- button.lua
--
--
-- andreaszdw@googlemail.com
-- --------------------------------------------------------
local widget = require("widget")

local button = {}

--
-- constructor
-- --------------------------------------------------------
function button:new(parent, label, onEvent, x, y, width, height)
	local o = {
		parent = parent,
		theme = parent.theme,
		label = label,
		onEvent = onEvent,
		x = x or 0,
		y = y or 0,
		width = width or parent.theme.button.width,
		height = height or parent.theme.button.height
	}

	o.button = widget.newButton(
	{
		label = o.label,
		onEvent = o.onEvent,
		emboss = false,
		shape = "roundedRect",
		width = o.width,
		height = o.height,
		cornerRadius = o.theme.button.cornerRadius,
		labelColor = {default = o.theme.label, over = o.theme.label},
		fillColor = {default = o.theme.fill, over = o.theme.fill},
		strokeColor = {default = o.theme.stroke, over = o.theme.stroke},
		strokeWidth = 2
	})

	o.button.x = x
	o.button.y = y

	parent.view:insert(o.button)

	setmetatable(o, self)
	self.__index = self
	return o
end

-----------------------------------------------------------
return button