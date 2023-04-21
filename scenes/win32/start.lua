-- --------------------------------------------------------
--
-- start.lua
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

--forward delaration
local fmw

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
-- newGame
--
-- --------------------------------------------------------
local function newGame(event)
	composer.gotoScene("scenes.win32.newgame")
end

-- --------------------------------------------------------
--
-- loadGame
--
-- --------------------------------------------------------
local function loadGame(event)
	print(system.ResourceDirectory)
	print(system.DocumentsDirectory)
end

-- --------------------------------------------------------
-- 
-- now the scene functions 
--
-- --------------------------------------------------------

-- --------------------------------------------------------
function scene:create(event)
	
	fmw = FMWidgets(self.view)

	fmw:stdBackground()

	local counter = 0
	local nextElement = 120
	local gap = 10

	local loadButton = fmw:pbutton(strings.new, newGame, 640, nextElement)
	nextElement = nextElement + loadButton:getHeight() + gap 

	local newButton = fmw:pbutton(strings.load, loadGame, 640, nextElement)
	nextElement = nextElement + newButton:getHeight() + gap

	local quitButton = fmw:pbutton(strings.quit, quitApp)
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
		fmw:show()
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
		fmw:hide()
	elseif phase == "did" then 
	end
end

-- --------------------------------------------------------
function scene:destroy(event)
	fmw:destroy()
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