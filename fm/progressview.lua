-- --------------------------------------------------------
--
-- progressview.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local class = require("30log")
local widget = require("widget")

local progress = class()

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function progress:init(parent, left, top, width, value, isAnimated)

	local theme = require("fm.theme")

	self.parent = parent
	self.theme = parent.theme or theme
	self.label = label
	self.left = left or 0
	self.top =  top or 0
	self.width = width or 100
	self.value = value or 0
	self.isAnimated = isAnimated or false

	-- this is shorter to type
	local t = self.theme.progressView
	local sheet = graphics.newImageSheet(t.sheet, t.options)

	self.progressView = widget.newProgressView(
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
        left = left,
        top = top,
        width = width,
        isAnimated = isAnimated
	})

	local view = parent.view or parent

	self.progressView:setProgress(self.value)
	view:insert(self.progressView)
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