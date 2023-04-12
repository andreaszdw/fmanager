-- --------------------------------------------------------
--
-- club.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local class = require("30log")

local club = class()

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function club:init()

	self.name = name or "FC NRW"
	self.stadion = stadion
	self.coach = {}
	self.team = {}
	self.financial = {}
end

-- --------------------------------------------------------
return club