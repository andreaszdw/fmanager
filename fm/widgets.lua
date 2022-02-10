-- --------------------------------------------------------
--
-- widgets.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------

local button = require("fm.button")
local pbutton = require("fm.pbutton")
local singleText = require("fm.singletext")
local progressView = require("fm.progressview")
local tableView = require("fm.table")

local fmwidgets = {}

-- --------------------------------------------------------
--
-- constructor
-- 
-- --------------------------------------------------------
function fmwidgets:new(view, theme)

	local tmpTheme = theme or "fm.theme"
	local o = {
		view = view,
		viewWidth = display.contentWidth,
		viewHeight = display.contentHeight,
		viewCenterX = display.contentWidth * 0.5,
		viewCenterY = display.contentHeight * 0.5,
		theme = require(tmpTheme),
		childs = {}
	}

	setmetatable(o, self)
	self.__index = self
	return o
end

-- --------------------------------------------------------
--
-- getTheme
--
-- --------------------------------------------------------
function fmwidgets:getTheme()
	return self.theme 
end

-- --------------------------------------------------------
--
-- button
--
-- --------------------------------------------------------
function fmwidgets:button(label, onEvent, x, y, width, height)
	local child = button:new(self, label, onEvent, x, y, width, height)
	table.insert(self.childs, child)
	return child
end

-- --------------------------------------------------------
--
-- pbutton
--
-- --------------------------------------------------------
function fmwidgets:pbutton(label, onEvent, x, y, width, height)
	local child = pbutton:new(self, label, onEvent, x, y, width, height)
	table.insert(self.childs, child)
	return child
end

-- --------------------------------------------------------
--
-- singleText
--
-- --------------------------------------------------------
function fmwidgets:singleText(label, x, y, fontSize, font)
	local child = singleText:new(self, label, x, y, fontSize, font)
	table.insert(self.childs, child)
	return child
end

-- --------------------------------------------------------
--
-- progressVies
--
-- --------------------------------------------------------
function fmwidgets:progressView(left, top, width, value, isAnimated)
	local child = progressView:new(self, left, top, width, value, isAnimated)
	table.insert(self.childs, child)
	return child
end

-- --------------------------------------------------------
--
-- grid
-- 
-- --------------------------------------------------------
function fmwidgets:table(left, top, width, height, rowRenderer, rowHeight, isLocked)
	local child = tableView:new(self, left, top, width, height, rowRenderer, rowHeight, isLocked)
	table.insert(self.childs, child)
	return child
end

-- --------------------------------------------------------
--
-- background for the scene
-- 
-- --------------------------------------------------------
function fmwidgets:stdBackground()
	display.setDefault("background", self.theme.black)
	local bgImage = display.newImage(self.view, self.theme.bgImage)
	bgImage.x = self.viewCenterX
	bgImage.y = self.viewCenterY
end

-- --------------------------------------------------------
return fmwidgets