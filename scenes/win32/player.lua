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
local fmw = require("fm.widgets")

local strings = i18n.getStrings()

-- new scene
local scene = composer.newScene()

local width = display.pixelWidth 
local height = display.pixelHeight
local centerX = width * 0.5 
local centerY = height * 0.5

local sceneView = 0

-- -------------------------------------------------------
local function repositeSceneView()
	local repositionX = (display.pixelWidth - 1280)/2
	sceneView.x = repositionX

	local repositionY = (display.pixelHeight - 720)/2
	sceneView.y = repositionY
end

-- --------------------------------------------------------
local function onUpdate(event)
end

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
local function onMouse(event)
end

-- -------------------------------------------------------
local function onResize(event)
	repositeSceneView()
end

-- -------------------------------------------------------
local function goBack(event) 
	local prevScene = composer.getSceneName("previous")
	composer.gotoScene(prevScene)
end

-- 
-- now the scene functions 
--
-- --------------------------------------------------------
function scene:create(event)
	
	local fmwidgets = fmw:new(self.view)

	local theme = fmwidgets:getTheme()

	local gap = 10

	display.setDefault("background", unpack(theme.bg))

	local bgRect = display.newRect(self.view, 640, 360, 1280, 720)
	bgRect.strokeWidth = 2
	bgRect:setStrokeColor(unpack(theme.stroke))
	bgRect:setFillColor(1, 1, 1, 0)

	local playerImage = display.newRect(self.view, 10, 10, 300, 450)
	playerImage.strokeWidth = 2
	playerImage:setFillColor(unpack(theme.green))
	playerImage:setStrokeColor(unpack(theme.stroke))
	playerImage.anchorX = 0
	playerImage.anchorY = 0

	local image = display.newImage(self.view, "assets/images/player/BürgerLarsDietrich.png")
	image.x = 310/2
	image.y = 460/2

	local progressView = fmwidgets:progressView(400, 400, 400, 0.5, false)

	local backButton = fmwidgets:button("Zurück", goBack)
	local tmpW = backButton:getWidth()
	local tmpH = backButton:getHeight()
	backButton:setPosition(1280 - tmpW/2 - gap, 720 - tmpH/2 - gap)
 	
 	print("in p")
	-- put the view in the local sceneView, so it can be changed on resize
	sceneView = self.view
end

-- --------------------------------------------------------
function scene:show(event)

	local phase = event.phase

	if (phase == "will") then
		repositeSceneView()
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