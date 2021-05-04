--
-- template.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------

local composer = require("composer")
local widget = require("widget")
local i18n = require("i18n")
local fmw = require("fm.widgets")

local strings = i18n.getStrings()

-- new scene
local scene = composer.newScene()

local width = display.pixelWidth 
local height = display.pixelHeight
local centerX = width * 0.5 
local centerY = height * 0.5

local welcomeText = 0
local goPlayerButton = 0
local quitButton = 0

local fmwidgets = 0

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
	nextElement = nextElement + welcomeText:getHeight()

	goPlayerButton.x = centerX 
	goPlayerButton.y = nextElement

	quitButton.x = width  - quitButton.width/2 - 10
	quitButton.y = height - quitButton.height/2 - 10
end

-- -------------------------------------------------------
local function goPlayer(event)
	composer.gotoScene("scenes.cross.player")
end

-- --------------------------------------------------------
local function quitApp(event)
	composer.removeHidden()
	composer.removeScene(composer.getSceneName("current"))
	native.requestExit()
end

-- 
-- now the scene functions 
--
-- --------------------------------------------------------
function scene:create(event)
	
	fmwidgets = fmw:new(self.view)

	display.setDefault("background", unpack(fmwidgets.theme.bg))

	local counter = 0
	local nextElement = 120
	local gap = 20

	local vbox = fmwidgets:vBox()
	local testText = fmwidgets:singleText("test", 0, 0, 60)
	vbox:add(testText)



	welcomeText = fmwidgets:singleText(strings.welcome, centerX, 120, 60)
	nextElement = nextElement + welcomeText:getHeight()
	goPlayerButton = fmwidgets:button(strings.player, goPlayer, centerX, nextElement)
	quitButton = fmwidgets:button(strings.quit, quitApp, "right", "bottom")

	print(#fmwidgets.childs)
	print(#vbox.elements)
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
	print("do saving")
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