-- --------------------------------------------------------
--
-- progressview.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local BaseWidget = require("fm.basewidget")
local widget = require("widget")

local ProgressView = BaseWidget:extend()

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function ProgressView:init(parent, left, top, width, value, isAnimated)

	ProgressView.super.init(self, parent, left, top, width, height)

	-- this is for table render needed
	local theme = require("fm.theme")
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

	-- this is for table render needed
	local view = parent.view or parent

	self.progressView:setProgress(self.value)
	view:insert(self.progressView)
end

-- --------------------------------------------------------
--
-- setValue
--
-- --------------------------------------------------------
function ProgressView:setValue(v)
	self.progressView:setProgress(v)
end

-- --------------------------------------------------------
--
-- getHeight
--
-- --------------------------------------------------------
function ProgressView:getHeight() 
	return self.button.height 
end

-- --------------------------------------------------------
-- 
-- getWidth
--
-- --------------------------------------------------------
function ProgressView:getWidth() 
	return self.button.width 
end

-- --------------------------------------------------------
--
-- set position
--
-- --------------------------------------------------------
function ProgressView:setPosition(x, y)
end

-- --------------------------------------------------------
return ProgressView