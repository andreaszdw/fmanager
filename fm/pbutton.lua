-- --------------------------------------------------------
--
-- pbutton.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local widget = require("widget")

local pbutton = {}

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function pbutton:new(parent, label, eventFunction, x, y, width, height)

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

	pgx = parent.theme.button.pButtonX

	verts = {o.x + pgx, o.y - o.height, o.x + pgx + o.width, o.y - o.height, o.x + o.width, o.y, o.x, o.y}

	o.button = widget.newButton(
	{
		label = o.label,
		onEvent = onEvent,
		emboss = false,
		shape = "polygon",
		vertices = verts,
		width = o.width,
		height = o.height,
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
function pbutton:getHeight() 
	return self.button.height 
end

-- --------------------------------------------------------
-- 
-- getWidth
--
-- --------------------------------------------------------
function pbutton:getWidth() 
	return self.button.width 
end

-- --------------------------------------------------------
--
-- set position
--
-- --------------------------------------------------------
function pbutton:setPosition(x, y)
	self.button.x = x 
	self.button.y = y 
end

-- --------------------------------------------------------
return pbutton