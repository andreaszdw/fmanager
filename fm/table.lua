-- --------------------------------------------------------
--
-- table.lua
--
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local BaseWidget = require("fm.basewidget")
local widget = require("widget")

local Table = BaseWidget:extend()

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function Table:init(parent, left, top, width, height, rowRenderer, rowHeight, isLocked)

	Table.super.init(self, parent, left, top, width, height)
	
	self.left = left or 0
	self.top = top or 0
	self.width = width or 0
	self.height = height or 0
	self.rowRenderer = rowRenderer
	self.isLocked = isLocked or true
	self.rowHeight = rowHeight or 35

	self.tableView = widget.newTableView(
	{
		left = self.left,
		top = self.top,
		height = self.height,
		width = self.width,
		onRowRender = self.rowRenderer,
		isLocked = self.isLocked,
		backgroundColor = {unpack(self.theme.bg)},
		noLines = true,
		listener = scrollListener
	})
	self.sumHeight = 0

	self.parent.view:insert(self.tableView)
end

-- --------------------------------------------------------
--
-- inserRow 
-- 
-- --------------------------------------------------------
function Table:insertRow(params, isCategory)
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
return Table