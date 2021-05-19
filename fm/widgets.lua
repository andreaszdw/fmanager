-- --------------------------------------------------------
--
-- widgets.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------

local button = require("fm.button")
local singleText = require("fm.singletext")
local progressView = require("fm.progressview")
local grid = require("fm.grid")

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
function fmwidgets:grid(x, y, rows, columns)
	local child = grid:new(self, x, y, rows, columns)
	table.insert(self.childs, child)
	return child
end

-- --------------------------------------------------------
return fmwidgets