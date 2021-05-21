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
function table:new(parent, left, top, width, height, rowRenderer, rowHeight, isLocked)
	local o = {
		parent = parent,
		theme = parent.theme,
		left = left or 0,
		top = top or 0,
		width = width or 0,
		height = height or 0,
		rowRenderer = rowRenderer,
		isLocked = isLocked or true,
		rowHeight = rowHeight or 35
	}

	o.tableView = widget.newTableView(
	{
		left = o.left,
		top = o.top,
		height = o.height,
		width = o.width,
		onRowRender = o.rowRenderer,
		isLocked = o.isLocked,
		backgroundColor = {unpack(o.theme.bg)},
		noLines = true,
		listener = scrollListener
	})

	o.parent.view:insert(o.tableView)

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
	local odd = false

	if self.tableView:getNumRows() % 2 == 1 then 
		odd = true 
	end

	local rowColor = {default = {unpack(self.theme.tableView.lineEven)}}

	if odd then
		rowColor = {default =  {unpack(self.theme.tableView.lineOdd)}}
	end

	self.tableView:insertRow(
	{	
		isCategory = isCategory or false,
		rowColor = rowColor,
		rowHeight = self.rowHeight,
		params = params
	})
end

-- --------------------------------------------------------
return table