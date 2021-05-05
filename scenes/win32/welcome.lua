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
	
	local fmwidgets = fmw:new(self.view)

	display.setDefault("background", unpack(fmwidgets.theme.bg))

	local counter = 0
	local nextElement = 120
	local gap = 10

	local welcomeText = fmwidgets:singleText(strings.welcome, centerX, 120, 60)
	nextElement = nextElement + welcomeText:getHeight()
	local goPlayerButton = fmwidgets:button(strings.player, goPlayer, centerX, nextElement)
	nextElement = nextElement + goPlayerButton:getHeight() + gap
	
	local quitButton = fmwidgets:button(strings.quit, quitApp)
	local tmpW = quitButton:getWidth()
	local tmpH = quitButton:getHeight()
	quitButton:setPosition(width - tmpW/2 - gap, height - tmpH/2 - gap)


	print(#fmwidgets.childs)
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