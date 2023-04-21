-- --------------------------------------------------------
--
-- widgets.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local Class = require("fm.30log")

local BaseContainer = require("fm.basecontainer")
local BaseWidget = require("fm.basewidget")
local Panel = require("fm.panel")
local Button = require("fm.button")
local PButton = require("fm.pbutton")
local SingleText = require("fm.singletext")
local ProgressView = require("fm.progressview")
local TableView = require("fm.table")
local TextField = require("fm.textfield")

local FmWidgets = Class()

-- --------------------------------------------------------
--
-- constructor
-- 
-- --------------------------------------------------------
function FmWidgets:init(view, theme)
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
-- clean up
--
-- --------------------------------------------------------
function FmWidgets:destroy()
	for k, v in pairs(self.childs) do
		v:destroy()
	end
end

-- --------------------------------------------------------
--
-- hide
--
-- --------------------------------------------------------
function FmWidgets:hide()
	for k, v in pairs(self.childs) do
		v:hide()
	end
end

-- --------------------------------------------------------
--
-- show
--
-- --------------------------------------------------------
function FmWidgets:show()
	for k, v in pairs(self.childs) do
		v:show()
	end
end


-- --------------------------------------------------------
--
-- getTheme
--
-- --------------------------------------------------------
function FmWidgets:getTheme()
	return self.theme 
end

-- --------------------------------------------------------
--
-- panel
--
-- --------------------------------------------------------
function FmWidgets:panel(x, y, width, height)
	local child = Panel(self, x, y, width, height)
	table.insert(self.childs, child)
	return child
end

-- --------------------------------------------------------
--
-- button
--
-- --------------------------------------------------------
function FmWidgets:button(label, onEvent, x, y, width, height)
	local child = Button(self, label, onEvent, x, y, width, height)
	table.insert(self.childs, child)
	return child
end

-- --------------------------------------------------------
--
-- pbutton
--
-- --------------------------------------------------------
function FmWidgets:pbutton(label, onEvent, x, y, width, height)
	local child = PButton(self, label, onEvent, x, y, width, height)
	table.insert(self.childs, child)
	return child 
end

-- --------------------------------------------------------
--
-- singleText
--
-- --------------------------------------------------------
function FmWidgets:singleText(label, x, y, fontSize, font)
	local child = SingleText(self, label, x, y, fontSize, font)
	table.insert(self.childs, child)
	return child
end

-- --------------------------------------------------------
--
-- progressView
--
-- --------------------------------------------------------
function FmWidgets:progressView(left, top, width, value, isAnimated)
	local child = ProgressView(self, left, top, width, value, isAnimated)
	table.insert(self.childs, child)
	return child
end

-- --------------------------------------------------------
--
-- table
-- 
-- --------------------------------------------------------
function FmWidgets:table(left, top, width, height, rowRenderer, rowHeight, isLocked)
	local child = TableView:new(self, left, top, width, height, rowRenderer, rowHeight, isLocked)
	table.insert(self.childs, child)
	return child
end

-- --------------------------------------------------------
--
-- textField
-- 
-- --------------------------------------------------------
function FmWidgets:textField(x, y, width, height)
	local child = TextField(self, x, y, width, height)
	table.insert(self.childs, child)
	return child
end

-- --------------------------------------------------------
--
-- background for the scene
-- 
-- --------------------------------------------------------
function FmWidgets:stdBackground()
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
return FmWidgets