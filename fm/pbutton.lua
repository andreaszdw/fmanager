-- --------------------------------------------------------
--
-- pbutton.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local BaseWidget = require("basewidget")
local widget = require("widget")

local PButton = BaseWidget:extend()

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function PButton:init(parent, label, eventFunction, x, y, width, height)
	print(x, y)
	PButton.super.init(self, parent, x, y, width, height)

	-- this is the function for the button,
	-- it will call the function for the given function
	local function onEvent(event)
		if("ended" == event.phase) then 
		print("ende")
			eventFunction(event)
		end
	end

	self.label = label
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

	self.view:insert(self.button)
end

-- --------------------------------------------------------
--
-- getHeight
--
-- --------------------------------------------------------
function PButton:getHeight() 
	return self.button.height 
end

-- --------------------------------------------------------
-- 
-- getWidth
--
-- --------------------------------------------------------
function PButton:getWidth() 
	return self.button.width 
end

-- --------------------------------------------------------
--
-- set position
--
-- --------------------------------------------------------
function PButton:setPosition(x, y)
	self.button.x = x 
	self.button.y = y 
end

-- --------------------------------------------------------
return PButton