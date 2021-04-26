--
-- player.lua
--
-- andreaszdw@googlemail.com
--
-- this shows player values in detail
--
-- --------------------------------------------------------

local composer = require("composer")
local theme = require("theme")
local widget = require("widget")
local i18n = require("i18n")

local strings = i18n.getStrings()

-- new scene
local scene = composer.newScene()

local width = display.pixelWidth 
local height = display.pixelHeight
local centerX = width * 0.5 
local centerY = height * 0.5

local buttonGoBack = 0

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
	width = display.pixelWidth
	height = display.pixelHeight
	centerX = width * 0.5
	centerY = height * 0.5

	buttonGoBack.x = width  - buttonGoBack.width/2 - 10
	buttonGoBack.y = height - buttonGoBack.height/2 - 10
end

-- -------------------------------------------------------
local function goBack(event)
	if("ended" == event.phase) then 
		local prevScene = composer.getSceneName("previous")
		composer.gotoScene(prevScene)
	end
end

-- 
-- now the scene functions 
--
-- --------------------------------------------------------
function scene:create(event)

	display.setDefault("background", unpack(theme.blue))

	buttonGoBack = widget.newButton(
	{
		label = strings.back,
		onEvent = goBack,
		emboss = false,
		shape = "roundedRect",
		width = 150,
		height = 40,
		cornerRadius = 2,
		labelColor = {default=theme.orange, over=theme.yellow},
		fillColor = {default=theme.lightBlue, over=theme.darkBlue},
		strokeColor = {default=theme.orange, over=theme.yellow},
		strokeWidth = 2
	}
	)
	buttonGoBack.x = width  - buttonGoBack.width/2 - 10
	buttonGoBack.y = height - buttonGoBack.height/2 - 10

	self.view:insert(buttonGoBack)
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