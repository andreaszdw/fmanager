-- --------------------------------------------------------
-- 
-- main.lua
-- 
-- --------------------------------------------------------
local composer = require("composer")

display.setStatusBar(display.HiddenStatusBar)

-- debug true/false
debugMode = false

-- info if debug mode is true
if debugMode then 
	print("debug mode on")
end
 
local platform = system.getInfo("platform")

-- set the window size and load the window scenes
if platform == "win32" then 
	native.setProperty("windowSize", {width=800, height=600})
end
