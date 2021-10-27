-- --------------------------------------------------------
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

local width = display.contentWidth 
local height = display.contentHeight
local centerX = width * 0.5 
local centerY = height * 0.5

local sceneView = 0

-- --------------------------------------------------------
--
-- update
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
-- on Mouse
--
-- -------------------------------------------------------
local function onMouse(event)
end

-- -------------------------------------------------------
--
-- goPlayer
--
-- -------------------------------------------------------
local function goPlayer(event)
	local options = {
		params = {
			status = "show"
		}
	}
	composer.gotoScene("scenes.win32.player", options)
end

-- --------------------------------------------------------
--
-- newPlayer
-- 
-- --------------------------------------------------------
local function newPlayer(event)
	local options = {
		params = {
			status = "new"
		}
	}
	composer.gotoScene("scenes.win32.player", options)
end

-- --------------------------------------------------------
--
-- quitApp 
--
-- --------------------------------------------------------
local function quitApp(event)
	composer.removeHidden()
	composer.removeScene(composer.getSceneName("current"))
	native.requestExit()
end

-- --------------------------------------------------------
-- 
-- now the scene functions 
--
-- --------------------------------------------------------

-- --------------------------------------------------------
function scene:create(event)
	
	local fmwidgets = fmw:new(self.view)

	local theme = fmwidgets:getTheme()

	display.setDefault("background", 0, 0, 0)
	local bgImage = display.newImage(self.view, "assets/images/bg/bg1.jpg")
	bgImage.x = centerX
	bgImage.y = centerY

	local counter = 0
	local nextElement = 120
	local gap = 10

	local welcomeText = fmwidgets:singleText(strings.welcome, 640, 120, 60)
	nextElement = nextElement + welcomeText:getHeight()

	local goPlayerButton = fmwidgets:pbutton(strings.player, goPlayer, 640, nextElement)
	nextElement = nextElement + goPlayerButton:getHeight() + gap

	local newPlayerButton = fmwidgets:pbutton(strings.newPlayer, newPlayer, 640, nextElement)
	nextElement = nextElement + newPlayerButton:getHeight() + gap
	
	local quitButton = fmwidgets:pbutton(strings.quit, quitApp)
	local tmpW = quitButton:getWidth()
	local tmpH = quitButton:getHeight()
	quitButton:setPosition(1280 - tmpW/2 - gap, 720 - tmpH/2 - gap)

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
	print("do saving")
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