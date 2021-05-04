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

local playerImage = 0
local buttonGoBack = 0
local fmwidgets = 0

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
	local prevScene = composer.getSceneName("previous")
	composer.gotoScene(prevScene)
end

-- 
-- now the scene functions 
--
-- --------------------------------------------------------
function scene:create(event)
	display.setDefault("background", unpack(theme.bg))

	playerImage = display.newRect(self.view, 10, 10, 300, 450)
	playerImage.strokeWidth = 2
	playerImage:setFillColor(unpack(theme.fill))
	playerImage:setStrokeColor(unpack(theme.stroke))
	playerImage.anchorX = 0
	playerImage.anchorY = 0

	local progress = widget.newProgressView(
	{
		left = 350,
		top = 200,
		width = 220,
		isAnimated = false
	})

	progress:setProgress(0.5)

	self.view:insert(progress)

	local tpv = theme.progressView
	local progressSheet = graphics.newImageSheet(tpv.sheet, tpv.options)
	 
	-- Create the widget
	local progressView = widget.newProgressView(
	{
	        sheet = progressSheet,
	        fillOuterLeftFrame = tpv.olf,
	        fillOuterMiddleFrame = tpv.omf,
	        fillOuterRightFrame = tpv.orf,
	        fillOuterWidth = tpv.ow,
	        fillOuterHeight = tpv.oh,
	        fillInnerLeftFrame = tpv.ilf,
	        fillInnerMiddleFrame = tpv.imf,
	        fillInnerRightFrame = tpv.irf,
	        fillWidth = tpv.fw,
	        fillHeight = tpv.fh,
	        left = 350,
	        top = 300,
	        width = 800,
	        isAnimated = true
	})
 
	-- Set the progress to 50%
	progressView:setProgress(1.0)
	
	fmwidgets = fmw:new(self.view)
	fmwidgets:button("Zurück", goBack, "center", "top")
end

-- --------------------------------------------------------
function scene:show(event)

	local phase = event.phase

	if (phase == "will") then
		print("will show")

	elseif (phase == "did") then
		print("did show")
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
		print("will hide")
		Runtime:removeEventListener("enterFrame", onUpdate)
		Runtime:removeEventListener("key", onKey)
		Runtime:removeEventListener("mouse", onMouse)
		Runtime:removeEventListener("resize", onResize)
	elseif phase == "did" then 
		print("did hide")
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