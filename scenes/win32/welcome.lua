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

-- --------------------------------------------------------
local function onUpdate(event)
end

-- --------------------------------------------------------
local function onKey(event)
end

-- -------------------------------------------------------
local function onMouse(event)
end

-- 
-- now the scene functions 
--
-- --------------------------------------------------------
function scene:create(event)
	local width = display.pixelWidth 
	local height = display.pixelHeight
	local centerX = width * 0.5 
	local centerY = height * 0.5

	display.setDefault("background", unpack(theme.blue))

	local welcomeText = display.newText(i18nStrings.welcome, centerX, centerY, native.sysemFont, 120)
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