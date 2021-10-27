local a = {2/255, 44/255, 67/255}
local b = {5/255, 63/255, 94/255}
local c = {17/255, 81/255, 115/255}
local d = {254/255, 145/255, 3/255}
local e = {255/255, 255/255, 255/255}

local theme = {
	bg = a,
	fill = a,
	label = d,
	labelWhite = e,
	stroke = d,
	imageBg = b,
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
		fillColor = {default=b, over=b},
		strokeColor = {default=c, over=c},
		strokeWidth = 2,
		pButtonX = 5
	},

	emptyStar = "assets/images/stars/empty25x24.png",
	fullStar = "assets/images/stars/full25x24.png",

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