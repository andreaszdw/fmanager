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

	-- local imageFile = "assets/images/player/BürgerLarsDietrich.png"
	-- local nameText = "Bürger Lars Dietrich"
	-- local age = 18
	-- local contract = 3
	-- local salary = 1000000

	local docPlayer = CPlayer:new()

	local fmw = fmwidgets:new(self.view)

	local theme = fmw:getTheme()

	local gap = 10

	display.setDefault("background", unpack(theme.bg))

	-- this is the rect for the view
	local bgRect = display.newRect(self.view, 640, 360, 1280, 720)
	bgRect.strokeWidth = 2
	bgRect:setStrokeColor(unpack(theme.stroke))
	bgRect:setFillColor(1, 1, 1, 0)

	-- this is the left side
	-- the rect for the player image
	local playerImage = display.newRect(self.view, 10, 10, 300, 450)
	playerImage.strokeWidth = 2
	playerImage:setFillColor(unpack(theme.green))
	playerImage:setStrokeColor(unpack(theme.stroke))
	playerImage.anchorX = 0
	playerImage.anchorY = 0

	-- the player image
	local image = display.newImage(self.view, docPlayer.imageFile)
	image.x = 310/2
	image.y = 460/2

	local nextLine = 480
	local centerLine = 160
	local left = 10
	local tab = 100
	local width = 304
	local height = 30
	local fontSize = 20
	local lineGap = 2

	-- bgRect for player name 
	local rectPlayerName = display.newRect(self.view, centerLine, nextLine, width, height)
	rectPlayerName:setFillColor(unpack(theme.lineEven))
	-- the player name
	local playerText = fmw:singleText(docPlayer.name, centerLine, nextLine, fontSize)

	nextLine = nextLine + height + lineGap

	-- bgRect for age
	local rectAge = display.newRect(self.view, centerLine, nextLine, width, height)
	rectAge:setFillColor(unpack(theme.lineOdd))
	-- the player age
	local ageText = fmw:singleText(strings.age, left, nextLine, fontSize)
	ageText:setAnchor(0, 0.5)
	local ageYears = fmw:singleText(": " .. docPlayer.age .. " " .. strings.years, tab, nextLine, fontSize)
	ageYears:setAnchor(0, 0.5)
	
	nextLine = nextLine + height + lineGap

	-- contract
	local rectContract = display.newRect(self.view, centerLine, nextLine, width, height)
	rectContract:setFillColor(unpack(theme.lineEven))
	local contractText = fmw:singleText(strings.contract, left, nextLine, fontSize)
	contractText:setAnchor(0, 0.5)
	local contractYears = fmw:singleText(": " .. docPlayer.contract .. " " .. strings.years, tab, nextLine, fontSize)
	contractYears:setAnchor(0, 0.5)

	nextLine = nextLine + height + lineGap

	-- salary
	local rectSalary = display.newRect(self.view, centerLine, nextLine, width, height)
	rectSalary:setFillColor(unpack(theme.lineOdd))
	local salaryText = fmw:singleText(strings.salary, left, nextLine, fontSize)
	salaryText:setAnchor(0, 0.5)
	local salaryAmount = fmw:singleText(": " .. i18n.currencyFormat(docPlayer.salary, 0, "suf"), tab, nextLine, fontSize)
	salaryAmount:setAnchor(0, 0.5)

	nextLine = nextLine + height + lineGap

	-- foot
	local rectFoot = display.newRect(self.view, centerLine, nextLine, width, height)
	rectFoot:setFillColor(unpack(theme.lineEven))
	local footText = fmw:singleText(strings.foot, left, nextLine, fontSize)
	footText:setAnchor(0, 0.5)
	local foot = fmw:singleText(": " .. docPlayer.foot, tab, nextLine, fontSize)
	foot:setAnchor(0, 0.5)
	
	nextLine = nextLine + height + lineGap

	-- position skills
	local rectKeeper = display.newRect(self.view, centerLine, nextLine, width, height)
	rectKeeper:setFillColor(unpack(theme.lineOdd))
	local keeperText = fmw:singleText(strings.keeper, left, nextLine, fontSize)
	keeperText:setAnchor(0, 0.5)
	local keeperStars = display.newImage(self.view, "assets/images/stars/fuel40x38.png")
	keeperStars.x = tab + 50
	keeperStars.y = nextLine
	local keeperStars2 = display.newImage(self.view, "assets/images/stars/fuel40x38.png")
	keeperStars2.x = tab + 50 + 50
	keeperStars2.y = nextLine


	-- --
	local progressView = fmw:progressView(400, 400, 400, 0.5, false)

	local backButton = fmw:button("Zurück", goBack)
	local tmpW = backButton:getWidth()
	local tmpH = backButton:getHeight()
	backButton:setPosition(1280 - tmpW/2 - gap, 720 - tmpH/2 - gap)

	-- ----------------------------------------------------
	-- 
	-- onRowRender 
	--
	-- ----------------------------------------------------
	local function onRowRender(event)
		local row = event.row
		local title = row.params.title 
		local value = row.params.value

		local rowHeight = row.contentHeight		
		local rowWidth = row.contentWidth 

		local rowTitle = display.newText(row, title, 0, 0, nil, 14)
		rowTitle:setFillColor(1, 0, 0, 1)
		rowTitle.anchorX = 0
		rowTitle.anchorY = 0

		local rowValue = display.newText(row, value, 50, 0, nil, 14)
		rowValue:setFillColor(0, 1, 0, 1)
		rowValue.anchorX = 0 
		rowValue.anchorY = 0
	end

	local tableView = fmw:table(400, 400, 200, 300, onRowRender)

	tableView:insertRow({title = "Name", value = "Klaas Gärtner"})
	tableView:insertRow({title = "Name", value = "Fritz Merkel"})
	tableView:insertRow({title = "Name", value = "August Oeyster"})
	tableView:insertRow({title = "Name", value = "Kai Birne"})

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