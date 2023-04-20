-- --------------------------------------------------------
--
-- main.lua
-- project fmanager
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local composer = require("composer")

display.setStatusBar(display.HiddenStatusBar)

DB = {
	DEBUG = true,
	new = true,
	backtrace = true,
	name = "assets/db/player.db", 
	type = "sqlite3"
}

-- debug true/false
debugMode = false

-- info if debug mode is true
if debugMode then 
	print("debug mode on")
end

-- get the platform
local platform = system.getInfo("platform")

-- set the window size and load the window scenes
if platform == "win32" then 
	native.setProperty("windowSize", {width=1280, height=720})
	composer.gotoScene("scenes.win32.start")
end
