--
-- main.lua
-- project fmanager
-- andreaszdw@googlemail.com
-- --------------------------------------------------------
local useTheme = require("theme")

local composer = require("composer")

display.setStatusBar(display.HiddenStatusBar)

-- debug true/false
debugMode = false

-- set the theme, its global
theme = useTheme.standard

-- info if debug mode is true
if debugMode then 
	print("debug mode on")
end

-- get the platform
local platform = system.getInfo("platform")

-- set the window size and load the window scenes
if platform == "win32" then 
	native.setProperty("windowSize", {width=1280, height=720})
	composer.gotoScene("scenes.win32.welcome")
	--composer.gotoScene("scenes.cross.player")
end
