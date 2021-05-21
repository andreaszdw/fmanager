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

local width = display.pixelWidth 
local height = display.pixelHeight
local centerX = width * 0.5 
local centerY = height * 0.5

local sceneView = 0

-- -------------------------------------------------------
--
-- centerSceneView
--
-- -------------------------------------------------------
local function centerSceneView()
	sceneView.x = (display.pixelWidth - 1280)/2
	sceneView.y = (display.pixelHeight - 720)/2
end

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
-- onResize
--
-- -------------------------------------------------------
local function onResize(event)
	centerSceneView()
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

	display.setDefault("background", unpack(theme.bg))

	local bgImage = display.newImage(self.view, "assets/images/bg/bg1.jpg")
	bgImage.x = centerX
	bgImage.y = centerY

	-- this is the rect for the view
	local bgRect = display.newRect(self.view, 640, 360, 1280, 720)
	bgRect.strokeWidth = 2
	bgRect:setStrokeColor(unpack(theme.stroke))
	bgRect:setFillColor(1, 1, 1, 0)

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
	local potential = math.floor(10 * docPlayer.potential)
	local rating = math.floor(10 * docPlayer.rating)
	local starX = 0
	local starY = 0
	for i=1, potential do
		local star
		if rating >= i then 
			star = display.newImage(potentialGroup, theme.fullStar)
		else  
			star = display.newImage(potentialGroup, theme.emptyStar)
		end		
		star.x = starX 
		star.y = starY
		starX = starX + 28
	end
	
	potentialGroup.x = 160
	potentialGroup.y = 420
	potentialGroup.anchorX = 0.5
	potentialGroup.anchorY = 0.5
	potentialGroup.anchorChildren = true
	table.insert(self.view, potentialGroup)

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
			local rowHeader = singleText:new(row, row.params.header, row.width*0.5, y, headerSize)
			rowHeader:setAnchor(0.5, 0)
		end

		if row.params.title then 
			local rowTitle = singleText:new(row, row.params.title, x, y, fontSize)
			rowTitle:setAnchor(0, 0)

			local valueView = progressView:new(row, tab, 5, 300, row.params.value)

			-- print the percent, without decimals
			local valuePercent = string.format("%.0f", row.params.value * 100) .. " %"
			local valueText = singleText:new(row, valuePercent, tab2, y, fontSize)
			valueText:setAnchor(0, 0)
			valueText:setFillColor(fmw.theme.labelWhite)
		end
	end

	-- new table
	local skillTable = fmw:table(320, 10, 450, 440, skillRender, 40)

	skillTable:insertRow({header = strings.physicalSkills})
	skillTable:insertRow({title = strings.fitness, value = docPlayer.fitness})
	skillTable:insertRow({title = strings.speed, value = docPlayer.speed})
	skillTable:insertRow({title = strings.stamina, value = docPlayer.stamina})
	skillTable:insertRow({empty})
	skillTable:insertRow({header = strings.footballSkills})
	skillTable:insertRow({title = strings.passing, value = docPlayer.passing})
	skillTable:insertRow({title = strings.header, value = docPlayer.header})
	skillTable:insertRow({title = strings.shot, value = docPlayer.shot})
	skillTable:insertRow({title = strings.tackle, value = docPlayer.tackle})
	skillTable:insertRow({title = strings.tactic, value = docPlayer.tactic})


	-- the back button
	local backButton = fmw:button("Zurück", goBack)
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
		centerSceneView()
	elseif (phase == "did") then
		-- add listeners
		Runtime:addEventListener("enterFrame", onUpdate)
		Runtime:addEventListener("key", onKey)
		Runtime:addEventListener("mouse", onMouse)
		Runtime:addEventListener("resize", onResize)
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
		Runtime:removeEventListener("resize", onResize)
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