-- component color
-- color.adobe.com/de/create/color-wheel

local a = {15/255, 35/255, 80/255}
local b = {35/255, 55/255, 100/255}
local c = {45/255, 65/255, 120/255}
local d = {254/255, 145/255, 3/255}

local theme = {
	bg = a,
	fill = a,
	label = d,
	labelWhite = {255, 255, 255},
	stroke = d,
	green = {0/255, 255/255, 0/255},
	
	tableView = {
		lineEven = b,
		lineOdd = c
	},
	
	button = {
		width = 150,
		height = 40,
		cornerRadius = 10,
		labelColor = {default=d, over=d},
		fillColor = {default=a, over=b},
		strokeColor = {default=d, over=d},
		strokeWidth = 2
	},

	font = "fm/assets/fonts/ubuntu/Ubuntu-R.ttf",

	progressView = {
		sheet = "fm/assets/images/widget-progress-view-standard.png",
		options = {
			width = 64,
			height = 64,
			numFrames = 6,
			sheetContentWidth = 384,
			sheetContenHeight = 64
		},
        olf = 1,
        omf = 2,
        orf = 3,
        ow = 64,
        oh = 32,
        ilf = 4,
        imf = 5,
        irf = 6,
        fw = 64,
        fh = 32
	}
}

return theme