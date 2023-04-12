-- --------------------------------------------------------
--
-- pbutton.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local class = require("30log")
local widget = require("widget")

local pbutton = class()

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function pbutton:init(parent, label, eventFunction, x, y, width, height)

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

	pgx = parent.theme.button.pButtonX

	verts = {
		self.x + pgx, self.y - self.height,
		self.x + pgx + self.width, self.y - self.height,
		self.x + self.width, self.y, self.x, self.y}

	self.button = widget.newButton(
	{
		label = self.label,
		onEvent = onEvent,
		emboss = false,
		shape = "polygon",
		vertices = verts,
		width = self.width,
		height = self.height,
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