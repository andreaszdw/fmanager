-- --------------------------------------------------------
--
-- grid.lua
--
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------

local grid = {}

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function grid:new(parent, x, y, width, height, rows, columns)

	local o = {
		parent = parent,
		theme = parent.theme,
		x = x or 0,
		y = y or 0,
		width = width or 0,
		height = height or 0,
		rows = rows or 1,
		columns = columns or 1
	}

	o.bgRect = display.newRect(o.parent.view, o.x, o.y, o.width, o.height)
	o.bgRect:setFillColor(1, 0, 0, 1)
	o.bgRect.anchorX = 0
	o.bgRect.anchorY = 0

	setmetatable(o, self)
	self.__index = self
	return o
end

-- --------------------------------------------------------
--
-- addRow 
--
-- --------------------------------------------------------
function grid:addRow(row)
	table.insert(rows, row)
end

-- --------------------------------------------------------
--
-- newRow 
--
-- --------------------------------------------------------
function grid:newRow()
end

-- --------------------------------------------------------
--
-- addColumn
--
-- --------------------------------------------------------
function grid:addColumn(column)
end

-- --------------------------------------------------------
return grid