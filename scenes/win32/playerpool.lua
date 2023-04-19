-- --------------------------------------------------------
--
-- playerpool.lua
--
-- andreaszdw@googlemail.com
--
-- this shows player values in detail
--
-- --------------------------------------------------------

local composer = require("composer")

local strings = i18n.getStrings()

-- new scene
local scene = composer.newScene()

local sceneView = 0

-- --------------------------------------------------------
--
-- onUpdate
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
-- onMouse
--
-- -------------------------------------------------------
local function onMouse(event)
end

-- -------------------------------------------------------
--
-- goBack
--
-- -------------------------------------------------------
local function goBack(event) 
	local prevScene = composer.getSceneName("previous")
	composer.gotoScene(prevScene)
end

-- --------------------------------------------------------
-- 
-- now the scene functions 
--
-- --------------------------------------------------------

-- --------------------------------------------------------
function scene:create(event)
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