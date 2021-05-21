-- --------------------------------------------------------
--
-- progressview.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local widget = require("widget")

local progress = {}

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function progress:new(parent, left, top, width, value, isAnimated)

	local theme = require("fm.theme")

	local o = {
		parent = parent,
		theme = parent.theme or theme,
		label = label,
		left = left or 0,
		top =  top or 0,
		width = width or 100,
		value = value or 0,
		isAnimated = isAnimated or false
	}

	-- this is shorte to type
	local t = o.theme.progressView
	local sheet = graphics.newImageSheet(t.sheet, t.options)

	o.progressView = widget.newProgressView(
	{
		sheet = sheet,
        fillOuterLeftFrame = t.olf,
        fillOuterMiddleFrame = t.omf,
        fillOuterRightFrame = t.orf,
        fillOuterWidth = t.ow,
        fillOuterHeight = t.oh,
        fillInnerLeftFrame = t.ilf,
        fillInnerMiddleFrame = t.imf,
        fillInnerRightFrame = t.irf,
        fillWidth = t.fw,
        fillHeight = t.fh,
        left = o.left,
        top = o.top,
        width = o.width,
        isAnimated = o.isAnimated
	}
	)

	local view = parent.view or parent

	o.progressView:setProgress(o.value)
	view:insert(o.progressView)

	setmetatable(o, self)
	self.__index = self
	return o
end

-- --------------------------------------------------------
--
-- setValue
--
-- --------------------------------------------------------
function progress:setValue(v)
	self.progressView:setProgress(v)
end

-- --------------------------------------------------------
--
-- getHeight
--
-- --------------------------------------------------------
function progress:getHeight() 
	return self.button.height 
end

-- --------------------------------------------------------
-- 
-- getWidth
--
-- --------------------------------------------------------
function progress:getWidth() 
	return self.button.width 
end

-- --------------------------------------------------------
--
-- set position
--
-- --------------------------------------------------------
function progress:setPosition(x, y)
end

-- --------------------------------------------------------
return progress