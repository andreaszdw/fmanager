--
-- template.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------

local composer = require("composer")
local theme = require("theme")
local i18n = require("i18n")

local i18nStrings = i18n.getStrings()

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
	if(event.keyName == "f") then
		print("f")
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
end

-- 
-- now the scene functions 
--
-- --------------------------------------------------------
function scene:create(event)

	display.setDefault("background", unpack(theme.blue))

	local welcomeText = display.newText(self.view, i18nStrings.welcome, centerX, centerY, native.sysemFont, 120)
	welcomeText:setFillColor(unpack(theme.orange))
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