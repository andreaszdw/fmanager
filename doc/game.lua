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
	self.playerName = ""
	self.club = ""
	self.trainerTeam = ""
	self.team = ""
	self.stadium = ""
	self.fiancial = ""
	self.trainingGround = ""
end

-- --------------------------------------------------------
return Game
