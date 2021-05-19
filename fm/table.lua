-- --------------------------------------------------------
--
-- table.lua
--
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local widget = require("widget")

local table = {}

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function table:new(parent, left, top, width, height, rowRenderer)
	local o = {
		parent = parent,
		theme = parent.theme,
		left = left or 0,
		top = top or 0,
		width = width or 0,
		height = height or 0,
		rowRenderer = rowRenderer 
	}

	o.tableView = widget.newTableView(
	{
		left = o.left,
		top = o.top,
		height = o.height,
		width = o.width,
		onRowRender = o.rowRenderer,
		listener = scrollListener
	})

	o.rowHeight = 30

	setmetatable(o, self)
	self.__index = self
	return o
end

-- --------------------------------------------------------
--
-- inserRow 
-- 
-- --------------------------------------------------------
function table:insertRow(params, isCategory)
	print(self.tableView:getNumRows())
	self.tableView:insertRow(
	{	
		isCategory = isCategory or false,
		rowHeight = self.rowHeight,
		params = params
	})
end

-- --------------------------------------------------------
return table