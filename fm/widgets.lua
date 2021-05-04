--
-- widgets.lua
--
--
-- andreaszdw@googlemail.com
-- --------------------------------------------------------

local button = require("fm.button")

local fmwidgets = {}

--
-- constructor
-- --------------------------------------------------------
function fmwidgets:new(view, theme)

	local tmpTheme = theme or "fm.theme"
	local o = {
		view = view,
		theme = require(tmpTheme)
	}

	print(o.theme.progressView.sheet)
	setmetatable(o, self)
	self.__index = self
	return o
end

--
-- button
-- --------------------------------------------------------
function fmwidgets:button(label, onEvent, x, y, width, height)
	button:new(self, label, onEvent, x, y, width, height)
end

-----------------------------------------------------------
return fmwidgets