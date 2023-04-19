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
local FMWidgets = require("fm.widgets")

local strings = i18n.getStrings()

-- new scene
local scene = composer.newScene()

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
	composer.gotoScene("scenes.win32.playerview", options)
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
	composer.gotoScene("scenes.win32.playerview", options)
end

-- --------------------------------------------------------
--
-- teamview
--
-- --------------------------------------------------------
local function goTeamView(event)
	local options = {
		params = {
			status = "show"
		}
	}
	composer.gotoScene("scenes.win32.teamview", options)
end

-- --------------------------------------------------------
--
-- poolview
-- 
-- --------------------------------------------------------
local function goPlayerPool(event)
	composer.gotoScene("scenes.win32.playerpool")
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
	local fmw = FMWidgets(self.view)

	fmw:stdBackground()

	local counter = 0
	local nextElement = 120 
	local gap = 10

	local welcomeText = fmw:singleText(strings.welcome, 640, 120, 60)
	nextElement = nextElement + welcomeText:getHeight()

	local goPlayerButton = fmw:pbutton(strings.player, goPlayer, 640, nextElement)
	nextElement = nextElement + goPlayerButton:getHeight() + gap

	local newPlayerButton = fmw:pbutton(strings.newPlayer, newPlayer, 640, nextElement)
	nextElement = nextElement + newPlayerButton:getHeight() + gap

	local goTeamViewButton = fmw:pbutton(strings.teamView, goTeamView, 640, nextElement)
	nextElement = nextElement + goTeamViewButton:getHeight() + gap

	local playerPoolButton = fmw:button(strings.playerPool, goPlayerPool, 640, nextElement)
	nextElement = nextElement + playerPoolButton:getHeight() + gap
	
	local quitButton = fmw:pbutton(strings.quit, quitApp)
	local tmpW = quitButton:getWidth()
	local tmpH = quitButton:getHeight()
	quitButton:setPosition(1280 - tmpW/2 - gap, 720 - tmpH/2 - gap) 

	-- put the view in the local sceneView, so it can be changed on resize
	sceneView = self.view
end

-- --------------------------------------------------------
function scene:show(event)
	if composer.getSceneName("previous") then
		local prevScene = composer.getSceneName("previous")
		composer.removeScene(prevScene)
	end

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