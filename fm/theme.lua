local theme = {
	bg = {28/255, 38/255, 33/255},
	fill = {55/255, 55/255, 55/255},
	label = {255/255, 146/255, 3/255},
	stroke = {255/255, 146/255, 3/255},
	button = {
		width = 150,
		height = 40,
		cornerRadius = 2
	},
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
        oh = 64,
        ilf = 4,
        imf = 5,
        irf = 6,
        fw = 64,
        fh = 64,
	}
}

return theme