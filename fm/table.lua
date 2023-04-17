-- --------------------------------------------------------
--
-- table.lua
--
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local class = require("30log")
local widget = require("widget")

local table = class()

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function table:init(parent, left, top, width, height, rowRenderer, rowHeight, isLocked)
	self.parent = parent
	self.theme = parent.theme
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
		backgroundColor = {unpack(self.theme.panel)},
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