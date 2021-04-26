--
-- template.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------

local composer = require("composer")
local widget = require("widget")
local theme = require("theme")
local i18n = require("i18n")

local strings = i18n.getStrings()

-- new scene
local scene = composer.newScene()

local width = display.pixelWidth 
local height = display.pixelHeight
local centerX = width * 0.5 
local centerY = height * 0.5

local welcomeLabel = 0
local goPlayerButton = 0
local quitButton = 0

-- --------------------------------------------------------
local function onUpdate(event)
end

-- --------------------------------------------------------
local function onKey(event)
end

-- -------------------------------------------------------
local function onMouse(event)
end

-- -------------------------------------------------------
local function onResize(event)
	width = display.pixelWidth
	height = display.pixelHeight
	centerX = width * 0.5
	centerY = height * 0.5

	local counter = 0
	local nextElement = 120
	local gap = 20

	welcomeText.x = centerX 
	welcomeText.y = nextElement
	nextElement = nextElement + welcomeText.height

	goPlayerButton.x = centerX 
	goPlayerButton.y = nextElement

	quitButton.x = width  - quitButton.width/2 - 10
	quitButton.y = height - quitButton.height/2 - 10
end

-- -------------------------------------------------------
local function goPlayer(event)
	if("ended" == event.phase) then 
		composer.gotoScene("scenes.cross.player")
	end
end

-- --------------------------------------------------------
local function quitApp(event)
	if("ended" == event.phase) then 
		native.requestExit()
	end
end

-- 
-- now the scene functions 
--
-- --------------------------------------------------------
function scene:create(event)

	display.setDefault("background", unpack(theme.blue))

	local counter = 0
	local nextElement = 120
	local gap = 20

	welcomeText = display.newText(self.view, strings.welcome, centerX, nextElement, native.sysemFont, 120)
	welcomeText:setFillColor(unpack(theme.orange))

	nextElement = nextElement + welcomeText.height

	goPlayerButton = widget.newButton(
	{
		label = strings.player,
		onEvent = goPlayer,
		emboss = false,
		shape = "roundedRect",
		width = 150,
		height = 40,
		cornerRadius = 2,
		labelColor = {default=theme.orange, over=theme.yellow},
		fillColor = {default=theme.lightBlue, over=theme.darkBlue},
		strokeColor = {default=theme.orange, over=theme.yellow},
		strokeWidth = 2
	})

	goPlayerButton.x = centerX 
	goPlayerButton.y = nextElement

	self.view:insert(goPlayerButton)

	quitButton = widget.newButton(
	{
		label = strings.quit,
		onEvent = quitApp,
		emboss = false,
		shape = "roundedRect",
		width = 150,
		height = 40,
		cornerRadius = 2,
		labelColor = {default=theme.orange, over=theme.yellow},
		fillColor = {default=theme.lightBlue, over=theme.darkBlue},
		strokeColor = {default=theme.orange, over=theme.yellow},
		strokeWidth = 2
	})

	quitButton.x = width  - quitButton.width/2 - 10
	quitButton.y = height - quitButton.height/2 - 10

	self.view:insert(quitButton)
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
	print("destroy")
	local phase = event.phase 
	if phase == "will" then 
	elseif phase == "did" then 
	end
end

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