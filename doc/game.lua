-- --------------------------------------------------------
--
-- game.lua
--
-- andreaszdw@googlemail.com
--
-- this class holds the data for the game, club,
-- etc....
-- 
-- --------------------------------------------------------
local Class = require("30log")

local Game = Class()

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function Game:init()
	self.manager = ""
	self.clubName = ""
	self.trainerTeam = ""
	self.playerTeam = ""
end

-- --------------------------------------------------------
return Game
