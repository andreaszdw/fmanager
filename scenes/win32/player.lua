-- --------------------------------------------------------
--
-- player.lua
--
-- andreaszdw@googlemail.com
--
-- this shows player values in detail
--
-- --------------------------------------------------------

local composer = require("composer")
local widget = require("widget")
local i18n = require("i18n")
local fmwidgets = require("fm.widgets")
local singleText = require("fm.singletext")
local progressView = require("fm.progressview")
local CPlayer = require("doc.player")

local strings = i18n.getStrings()

-- new scene
local scene = composer.newScene()

local width = display.contentWidth 
local height = display.contentHeight
local centerX = width * 0.5 
local centerY = height * 0.5

local sceneView = 0

-- --------------------------------------------------------
--
-- onUpdate
--
-- --------------------------------------------------------
local function onUpdate(event)
end

-- --------------------------------------------------------
-- 
-- onKey
--
-- --------------------------------------------------------
local function onKey(event)
	if(event.keyName == "f") then
		if(event.phase == "down") then 
			-- toggle window
			local w = native.getProperty("windowMode")
			if w == "fullscreen" then 
				native.setProperty("windowMode", "normal")
			else 
				native.setProperty("windowMode", "fullscreen")
			end
		end
	end
	return false
end

-- -------------------------------------------------------
--
-- onMouse
--
-- -------------------------------------------------------
local function onMouse(event)
end

-- -------------------------------------------------------
--
-- goBack
--
-- -------------------------------------------------------
local function goBack(event) 
	local prevScene = composer.getSceneName("previous")
	composer.gotoScene(prevScene)
end

-- --------------------------------------------------------
-- 
-- now the scene functions 
--
-- --------------------------------------------------------

-- --------------------------------------------------------
function scene:create(event)
	local docPlayer = CPlayer:new()

	local fmw = fmwidgets:new(self.view)

	local theme = fmw:getTheme()

	local gap = 10

	display.setDefault("background", 0, 0, 0)
	local bgImage = display.newImage(self.view, "assets/images/bg/bg1.jpg")
	bgImage.x = centerX
	bgImage.y = centerY

	-- this is the rect for the view
	local bgRect = display.newRect(self.view, 640, 360, 1280, 720)
	bgRect.strokeWidth = 2
	bgRect:setStrokeColor(unpack(theme.stroke))
	bgRect:setFillColor(unpack(theme.bg), 0)

	-- player image and rect
	-- the rect 
	local playerImage = display.newRect(self.view, 10, 10, 300, 450)
	playerImage.strokeWidth = 2
	playerImage:setFillColor(unpack(theme.imageBg))
	playerImage:setStrokeColor(unpack(theme.stroke))
	playerImage.anchorX = 0
	playerImage.anchorY = 0

	-- the image
	local image = display.newImage(self.view, docPlayer.imageFile)
	image.x = 160
	image.y = 150

	-- the potential in stars
	local potentialGroup = display.newGroup()
	potentialGroup.x = 160
	potentialGroup.y = 420
	potentialGroup.anchorX = 0.5
	potentialGroup.anchorY = 0.5
	potentialGroup.anchorChildren = true
	table.insert(self.view, potentialGroup)
	local potential = math.floor(10 * docPlayer.potential)
	local rating = math.floor(10 * docPlayer.rating)
	print(-potential * 14 + 160)
	local starX = -potential * 14 + 174
	local starY = 420
	for i=1, potential do
		local star
		if rating >= i then 
			star = display.newImage(self.view, theme.fullStar)
		else  
			star = display.newImage(self.view, theme.emptyStar)
		end		
		star.x = starX
		star.y = starY
		starX = starX + 28
	end
	

	-- here comes tableView with player info
	-- name, age, contract, salary
	-- ----------------------------------------------------
	-- 
	-- dataRender 
	--
	-- ----------------------------------------------------
	local function dataRender(event)
		local row = event.row
		local title = row.params.title 
		local value = row.params.value
		local x = 5
		local y = 5
		local tab = 80
		local fontSize = 14

		local rowHeight = row.contentHeight		
		local rowWidth = row.contentWidth 

		row.backgroundColor = {1, 0, 0}

		-- here I must use singleText directly, not via wigedts/fmw because
		-- the parent must be the row of the parent tableView
		local rowTitle = singleText:new(row, title, x, y, fontSize)
		rowTitle:setAnchor(0, 0)
		
		local rowValue = singleText:new(row, value, tab, y, fontSize)
		rowValue:setAnchor(0, 0)
		rowValue:setFillColor(fmw.theme.labelWhite)
	end

	-- new table
	local dataTable = fmw:table(10, 470, 300, 240, dataRender)

	local pos = docPlayer.position
	local posValue = ""
	if pos == "k" then 
		posValue = strings.keeper 
	elseif pos == "m" then 
		posValue = strings.midfielder
	elseif pos == "d" then 
		posValue = strings.defender 
	elseif pos == "a" then 
		posValue = strings.attacker 
	end

	local contractValue = docPlayer.contract .. " " .. strings.years
	local salaryValue = i18n.currencyFormat(docPlayer.salary, 0, "suf")

	local foot = docPlayer.foot
	local footValue = ""
	if foot == "l" then 
		footValue = strings.left 
	elseif foot == "r" then 
		footValue = strings.right 
	elseif foot == "b" then 
		footValue = strings.both 
	end

	-- insert rows
	dataTable:insertRow({title = strings.name, value = docPlayer.name})
	dataTable:insertRow({title = strings.age, value = docPlayer.age})
	dataTable:insertRow({title = strings.position, value = posValue})
	dataTable:insertRow({title = strings.contract, value = contractValue})
	dataTable:insertRow({title = strings.salary, value = salaryValue})
	dataTable:insertRow({title = strings.foot, value = footValue})

	-- tableview with the player skills
	--
	-- ----------------------------------------------------
	--
	-- skillRender
	-- 
	-- ----------------------------------------------------
	local function skillRender(event)
		local row = event.row
		-- local title = row.params.title 
		-- local value = row.params.value
		local x = 5
		local y = 10
		local tab = 80
		local tab2 = 380
		local fontSize = 14
		local headerSize = 22

		if row.params.empty then
			-- do nothing
		end

		if row.params.header then 
			local rowHeader = singleText:new(row, row.params.header, row.width*0.5, y-2, headerSize)
			rowHeader:setAnchor(0.5, 0)
		end

		if row.params.title then 
			local rowTitle = singleText:new(row, row.params.title, x, y, fontSize)
			rowTitle:setAnchor(0, 0)

			if row.params.value then
				-- this is the max width of the progressview
				local pvWidth = 300

				-- draw a background rect
				local pvBgRectLength = pvWidth - 56 - 56 + 9 -- here look in the sheet for progressview to get the right values
				local pvBgRect = display.newRect(row, tab + 56, 8, pvBgRectLength, row.height - 14)
				pvBgRect:setFillColor(0, 0, 0, 0.5)
				pvBgRect.anchorX = 0
				pvBgRect.anchorY = 0

				-- draw the width of progressview in dependance of the max value
				local length = pvWidth * row.params.max

				local valueView = progressView:new(row, tab, 5, length, row.params.value / row.params.max)

				-- print the percent, without decimals
				local valuePercent = string.format("%.0f", row.params.value * 100)
				local mostPossible = string.format("%.0f", row.params.max * 100)
				local valueString = valuePercent .. " / " .. mostPossible
				local valueText = singleText:new(row, valueString, tab2, y, fontSize)
				valueText:setAnchor(0, 0)
				valueText:setFillColor(fmw.theme.labelWhite)
			end
			if row.params.points then 
				local pointsText = singleText:new(row, row.params.points, tab + 50, y, fontSize)
				pointsText:setAnchor(0, 0)
				pointsText:setFillColor(fmw.theme.labelWhite)
			end
		end
	end

	-- new table
	local skillTable = fmw:table(320, 10, 460, 480, skillRender, 40)

	skillTable:insertRow({header = strings.skills})
	skillTable:insertRow({header = strings.physical})
	skillTable:insertRow({title = strings.fitness, value = docPlayer.fitness, max = docPlayer.maxFitness})
	skillTable:insertRow({title = strings.stamina, value = docPlayer.stamina, max = docPlayer.maxFitness})
	skillTable:insertRow({header = strings.football})
	skillTable:insertRow({title = strings.speed, value = docPlayer.speed, max = docPlayer.maxSpeed})
	skillTable:insertRow({title = strings.passing, value = docPlayer.passing, max = docPlayer.maxPassing})
	skillTable:insertRow({title = strings.header, value = docPlayer.header, max = docPlayer.maxHeader})
	skillTable:insertRow({title = strings.shot, value = docPlayer.shot, max = docPlayer.maxShot})
	skillTable:insertRow({title = strings.tackle, value = docPlayer.tackle, max = docPlayer.maxTackle})
	skillTable:insertRow({title = strings.tactic, value = docPlayer.tactic, max = docPlayer.maxTactic})
	skillTable:insertRow({title = strings.experience, points = docPlayer.experience})


	-- the back button
	local backButton = fmw:pbutton(strings.back, goBack)
	local tmpW = backButton:getWidth()
	local tmpH = backButton:getHeight()
	backButton:setPosition(1280 - tmpW/2 - gap, 720 - tmpH/2 - gap)

	-- put the view in the local sceneView, so it can be changed on resize
	sceneView = self.view
end

-- --------------------------------------------------------
function scene:show(event)

	local phase = event.phase

	if (phase == "will") then

	elseif (phase == "did") then
		-- add listeners
		Runtime:addEventListener("enterFrame", onUpdate)
		Runtime:addEventListener("key", onKey)
		Runtime:addEventListener("mouse", onMouse)
	end
end

-- --------------------------------------------------------
function scene:hide(event)
	local phase = event.phase

	if phase == "will" then
		-- remove listeners	
		Runtime:removeEventListener("enterFrame", onUpdate)
		Runtime:removeEventListener("key", onKey)
		Runtime:removeEventListener("mouse", onMouse)
	elseif phase == "did" then 
	end
end

-- --------------------------------------------------------
function scene:destroy(event)
	
end

-- --------------------------------------------------------
--
-- add event listener
--
-- --------------------------------------------------------
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

-- --------------------------------------------------------
return scene