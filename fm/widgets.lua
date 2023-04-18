-- --------------------------------------------------------
--
-- widgets.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------

local class = require("30log")

local panel = require("fm.panel")
local button = require("fm.button")
local pbutton = require("fm.pbutton")
local singleText = require("fm.singletext")
local progressView = require("fm.progressview")
local tableView = require("fm.table")

local fmwidgets = class()

-- --------------------------------------------------------
--
-- constructor
-- 
-- --------------------------------------------------------
function fmwidgets:init(view, theme)

	local tmpTheme = theme or "fm.theme"
	self.view = display.newGroup()
	self.viewWidth = display.contentWidth
	self.viewHeight = display.contentHeight
	self.viewCenterX = display.contentWidth * 0.5
	self.viewCenterY = display.contentHeight * 0.5
	self.theme = require(tmpTheme)
	self.childs = {}
	view:insert(self.view)
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
-- panel
--
-- --------------------------------------------------------
function fmwidgets:panel(x, y, width, height)
	local child = panel(self, x, y, width, height)
	table.insert(self.childs, child)
	return child
end

-- --------------------------------------------------------
--
-- button
--
-- --------------------------------------------------------
function fmwidgets:button(label, onEvent, x, y, width, height)
	local child = button(self, label, onEvent, x, y, width, height)
	table.insert(self.childs, child)
	return child
end

-- --------------------------------------------------------
--
-- pbutton
--
-- --------------------------------------------------------
function fmwidgets:pbutton(label, onEvent, x, y, width, height)
	local child = pbutton(self, label, onEvent, x, y, width, height)
	table.insert(self.childs, child)
	return child
end

-- --------------------------------------------------------
--
-- singleText
--
-- --------------------------------------------------------
function fmwidgets:singleText(label, x, y, fontSize, font)
	local child = singleText(self, label, x, y, fontSize, font)
	table.insert(self.childs, child)
	return child
end

-- --------------------------------------------------------
--
-- progressView
--
-- --------------------------------------------------------
function fmwidgets:progressView(left, top, width, value, isAnimated)
	local child = progressView(self, left, top, width, value, isAnimated)
	table.insert(self.childs, child)
	return child
end

-- --------------------------------------------------------
--
-- table
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

	local bgRect = display.newRect(self.view, 0, 0, 1280, 720)
	bgRect.strokeWidth = 2
	bgRect:setStrokeColor(unpack(self.theme.stroke))
	bgRect:setFillColor(unpack(self.theme.bg), 0)
	bgRect.anchorX = 0
	bgRect.anchorY = 0
end

-- --------------------------------------------------------
return fmwidgets